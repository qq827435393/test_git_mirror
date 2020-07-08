# -*- coding: utf-8 -*-
import datetime
import os
import time
import socket
import threading
import paramiko

class Ssh(object):
    @classmethod
    def ssh_create_client(self, ip, username, passwd, port=22, timeout=5, pub_key=None, status=True, is_ip_ping=True):
        '''创建一个SSH的客户端,可以保持连接,支持密匙登录，需要密匙登录时，传入需要的pub_key即可'''
        global TMOUT
        TMOUT = timeout

        for i in range(0, 5):
            try:
                sshClient = dict()
                sshClient_real = paramiko.SSHClient()
                sshClient_real.set_missing_host_key_policy(paramiko.AutoAddPolicy())
                if not pub_key:
                    sshClient_real.connect(ip, port, username=username, password=passwd)
                trans = sshClient_real.get_transport()
                trans.set_keepalive(30)
                channel = trans.open_session()
                channel.settimeout(timeout)
                channel.get_pty(width=300)
                channel.invoke_shell()
                stdout = channel.makefile('r', -1)
                sshClient['ip'] = ip
                sshClient['client'] = trans
                sshClient['channel'] = channel
                sshClient['stdout'] = stdout
                sshClient['sshClient'] = sshClient_real
                time.sleep(2)
                if status:
                    self.get_prompt(sshClient)
                return sshClient

            except Exception as e:
                err_msg = 'create ssh client failed. ip:%s, username:%s, port:%s' % (
                ip, username, port)
                if not passwd:
                    err_msg += ', and passwd is none'
                if str(e):
                    err_msg += '. the error is:%s' % str(e)
                else:
                    if isinstance(e, IOError):
                        err_msg += '. the error is IOError, errno:%s, filename:%s, strerror:%s' % (
                            e.errno, e.filename, e.strerror)
                        ui_msg = "the error is IOError"
                    elif isinstance(e, EOFError):
                        err_msg += '. the error is EOFError'
                        ui_msg = "the error is EOFError"
                    else:
                        err_msg += '. the error is unkown type:%s' % type(e)
                        ui_msg = "the error is unkown type:%s" % type(e)
                print(err_msg)
                if 'authentication failed' not in err_msg.lower() and i < 4:
                    time.sleep(20)
                    continue
                msg = "error"
                raise msg
    
    @classmethod
    def ssh_exec_command_return(self, ssh_client, cmds, timeout=60, retry_times=0):
        '''执行一个命令,并获取返回值'''
        if (not ssh_client) or (type(ssh_client) != dict) or (not cmds):
            err_msg = "error"
            print(str(err_msg))
            raise err_msg
        retry_times = retry_times + 1
        err_msg = ""
        for attempNum in range(retry_times):
            try:
                now_time = datetime.datetime.now()
                ssh_client['channel'].send(cmds + ";echo last cmd result: $?\n")
                recvStr = ""
                while not recvStr.__contains__('last cmd result:'):
                    time.sleep(0.1)
                    if ssh_client['channel'].closed:
                        recvStr = recvStr + tansform(ssh_client['channel'].recv(SSH_RECV_BUFFER))
                        print("channel is closed")
                        break
                    if not ssh_client['channel'].recv_ready():
                        continue
                    if datetime.datetime.now() > (now_time + datetime.timedelta(minutes=int(timeout))):
                        print("it has been executed exceed %s mins" % timeout)
                        break
                    try:
                        recvStr = recvStr + tansform(ssh_client['channel'].recv(SSH_RECV_BUFFER))
                    except TypeError:
                        print('Type Error %s' % str(TypeError))
                        time.sleep(1)
                        recvStr = recvStr.replace(' \r', '\r')
                        recvStr = recvStr.replace('\r', '')
                        recvStr = recvStr.replace(";echo last cmd result: $?", "")
                        continue
                    recvStr = recvStr.replace(' \r', '\r')
                    recvStr = recvStr.replace('\r', '')
                    recvStr = recvStr.replace(";echo last cmd result: $?", "")

                recvStr = recvStr.replace(ssh_client.get('prompt', ''), '')
                recvStr = recvStr.replace('\n\n', '\n')
                recvStr = recvStr.replace('\n', '\n\r')
                listout = recvStr.split('\r')

                if not listout:
                    return listout

                if 0 != len(listout[0]):
                    listout = listout[1:]
                if 0 != len(listout[-1]):
                    listout = listout[:-1]
                if 0 != len(listout[-1]):
                    listout = listout[:-1]
                return listout
            except Exception as e:
                msg = str(e).replace(cmds, "") if cmds in str(e) else str(e)
                err_msg = "error"
                print(str(err_msg))
                time.sleep(5)
        else:
            raise err_msg

    @classmethod
    def ssh_send_command(self, ssh_client, cmds, expect, timeout, retry_times=0, hide_cmd=True):
        '''执行一个命令,等待一段时间之后直接返回，用来处理无法输出结束符的情况'''
        if (not ssh_client) or (type(ssh_client) != dict) or (not cmds):
            err_msg = "error"
            print(str(err_msg))
            raise err_msg

        retry_times = retry_times + 1
        err_msg = ""
        recvStr = ''
        for attempNum in range(retry_times):
            try:
                ssh_client['channel'].send(cmds + '\n')
                recvStr = ""
                t = 0
                interval = 0.5
                while not recvStr.__contains__(expect):
                    if t < timeout:
                        time.sleep(interval)
                        t += interval
                        if ssh_client['channel'].closed:
                            recvStr = recvStr + tansform(ssh_client['channel'].recv(SSH_RECV_BUFFER)).replace(' \r', '\r').replace('\r', '')
                            print("channel is closed")
                            break
                        if not ssh_client['channel'].recv_ready():
                            continue
                        recvStr = recvStr + tansform(ssh_client['channel'].recv(SSH_RECV_BUFFER)).replace(' \r', '\r').replace('\r', '')
                    else:
                        break
                try:
                    time.sleep(interval)
                    ssh_client['channel'].settimeout(1)
                    recvStr = recvStr + tansform(ssh_client['channel'].recv(SSH_RECV_BUFFER)).replace(' \r', '\r').replace('\r', '')
                    ssh_client['channel'].settimeout(TMOUT)
                except socket.error:
                    ssh_client['channel'].settimeout(TMOUT)
            except Exception as e:
                msg = str(e).replace(cmds, "") if cmds in str(e) else str(e)
                err_msg = "error"
                print(str(err_msg))

            if not recvStr.__contains__(expect):
                err_list = recvStr.replace('\r', '').split('\n')
                if hide_cmd:
                    if ssh_client.get('prompt', '') in recvStr:
                        err_msg = '\n'.join(err_list[2:])
                    else:
                        err_msg = '\n'.join(err_list[1:])
                else:
                    err_msg = '\n'.join(err_list)
                err_msg = "error"
                print(str(err_msg))
                time.sleep(2)
            else:
                break
        else:
            raise err_msg

        recvStr = recvStr.replace(ssh_client.get('prompt', ''), '')
        recvStr = recvStr.replace(' \r', '\r')
        recvStr = recvStr.replace('\r', '')
        recvStr = recvStr.replace('\n\n', '\n')
        recvStr = recvStr.replace('\n', '\n\r')
        listout = recvStr.split('\r')

        if not listout:
            return listout

        if 0 == len(listout[0]):
            listout = listout[1:]
        if 0 == len(listout[-1]):
            listout = listout[:-1]
        return listout

    @classmethod
    def ssh_close(self, ssh_client):
        '''关闭SSH连接'''
        try:
            if ssh_client and isinstance(ssh_client, dict) and 'client' in ssh_client:
                ssh_client['client'].close()
            if ssh_client and isinstance(ssh_client, dict) and 'sshClient' in ssh_client:
                ssh_client['sshClient'].close()
        except Exception as e:
            err_msg = "err"
            raise err_msg


def get_token():
    ssh_util = Ssh()
    ip = "10.0.0.1"
    user_name = "user"
    user_password = "password"
    ssh_client = None

    try:
        ssh_client = ssh_util.ssh_create_client(ip, user_name, user_password, 22)
        print("Login in [%s] by username [%s] is success." % (ip, user_name))
        print('send 11 to get into x-lcc-token')
        Ssh.ssh_send_command(ssh_client, "11", "Q]:", 10)
        print('send 1 to show x-lcc-token')
        ret = Ssh.ssh_exec_command_return(ssh_client, "1", 10)
        print("retrun value is [%s]." % (ret))

    except Exception as e:
        print(str(e))
        raise e
    finally:
        if ssh_client:
            ssh_util.ssh_close(ssh_client)

if __name__ == "__main__":
    get_token()
