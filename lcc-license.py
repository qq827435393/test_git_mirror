#!/usr/bin/env python
# encoding=utf-8
'''
    # 功能： lcc license监控脚本
'''
import subprocess
import re
import datetime
import logging
import logging.handlers
import logging.config
import os
import configparser
import requests
import json

MODULE_NAME = "LccLicenseDateline"
CONFIG_PATH = "/opt/cloud/cbs/bin/cmc"

LCC_CONFIG = "lcc_conf"
LCC_IP = "lcc_address"
LCC_PORT = "lcc_port"
HTTP_STATUS_OK = [200, 201, 302]

LOG_CONFIG = "log_config"
LOG_BASE_PATH = "log_path"
LOG_STORAGE_PERIOD = "log_storage_period"

OUTDATE = "outdate"
LESS7DAYS = "less7days"
LESS30DAYS = "less30days"


class Monitor(object):
    '''
        监控脚本主程序
    '''
    def __init__(self):
        self.config_path = CONFIG_PATH
        self.monitor_config = self.monitor_config_init()
        self.lcc_ip = self.monitor_config.get(LCC_CONFIG, LCC_IP)
        self.lcc_port = self.monitor_config.get(LCC_CONFIG, LCC_PORT)

    def get_lcc_token(self):
        try:
            url = "http://%s:%s/lcc/system/token" % (self.lcc_ip, self.lcc_port)
            response = requests.get(url, verify=False)

            if response.status_code in HTTP_STATUS_OK:
                    resp_dict = json.loads(response.text)
                    token = resp_dict["data"]
                    return token

        except Exception as e:
            pass

    def get_lcc_license_dateline(self):
        #curl -H 'Content-Type: application/json' -H 'x-lcc-token: kqOGTEPjRg8UgqBiqJJOlfF3FL01Gt8u' -X GET "http://172.31.12.241:9000/lcc/v1/license"
        try:
            token = self.get_lcc_token()
            url = "http://%s:%s/lcc/v1/license" % (self.lcc_ip, self.lcc_port)
            headers = {
                'Content-Type': 'application/json',
                'accept': 'application/json',
                'x-lcc-token': token,
            }
            response = requests.get(url, headers=headers, verify=False)
            if response.status_code in HTTP_STATUS_OK:
                resp_dict = json.loads(response.text)
                deadline = resp_dict["data"]["deadline"]
                return deadline

        except Exception as e:
            pass

    def log_init(self):
        '''日志模块初始化'''
        log_base_path = self.monitor_config.get(LOG_CONFIG, LOG_BASE_PATH)
        monitor_log = logging.getLogger(MODULE_NAME)
        monitor_log.setLevel(logging.INFO)

        # 根据key获取log日志文件的存储路径
        date = datetime.datetime.now().strftime('%Y-%m-%d')
        dir_name = os.path.join(log_base_path, "Monitor.log_{}".format(date))

        # 设置log的存储文件内存上限20M, 保留的log备份文件7个
        log_handler = logging.handlers.RotatingFileHandler(dir_name, maxBytes=200000, backupCount=7)

        # 设置log日志的存储格式
        formatter = logging.Formatter("[%(asctime)s][%(name)s][%(levelname)s]%(message)s")
        log_handler.setFormatter(formatter)
        monitor_log.addHandler(log_handler)

        return monitor_log

    def log_clear(self):
        '''日志清理'''
        log_storage_period = int(self.monitor_config.get(LOG_CONFIG, LOG_STORAGE_PERIOD))
        log_path = self.monitor_config.get(LOG_CONFIG, LOG_BASE_PATH)
        file_list = os.listdir(log_path)
        now = datetime.datetime.now()
        for log_file in file_list:
            res = re.search(r'Monitor\.log_([0-9\-]{10})', log_file)
            if not res:
                continue
            date_str = res.groups()[0]
            date = datetime.datetime.strptime(date_str, '%Y-%m-%d')
            if (now - date).days > log_storage_period:
                os.remove(os.path.join(log_path, log_file))

    def monitor_config_init(self):
        '''监控配置初始化'''
        monitor_config = configparser.RawConfigParser()
        monitor_config_path = os.path.join(self.config_path, "monitor.conf")
        monitor_config.read(monitor_config_path)
        return monitor_config

    def get_monitor_data(self):
        '''获取监控数据'''
        deadline = self.get_lcc_license_dateline()
        error = self.parse_Lcc_license_result(deadline)
        print('==lcc_license\nLccLicense01={0}, LccLicense02={1}, LccLicense03={2}'.format(
            str(error.get(OUTDATE, 0)),
            str(error.get(LESS7DAYS, 0)),
            str(error.get(LESS30DAYS, 0)),
            ))

    def parse_Lcc_license_result(self, deadline):
        '''解析数据库数据'''
        Lcc_license = {OUTDATE: 0, LESS7DAYS: 0, LESS30DAYS: 0}
        if deadline == None:
            Lcc_license[OUTDATE] = -1
        else:
            date = datetime.datetime.strptime(deadline, '%Y-%m-%d')
            now = datetime.datetime.now()
            time_interval = (date - now).days
            if time_interval < 7:
                Lcc_license[LESS7DAYS] = time_interval
            elif time_interval < 30:
                Lcc_license[LESS30DAYS] = time_interval
            else:
                return Lcc_license
        return Lcc_license

    def execute_monitor(self):
        '''执行监控脚本命令'''
        self.get_monitor_data()


if __name__ == '__main__':
    MONITOR_LCC_LICENSE = Monitor()
    MONITOR_LCC_LICENSE.execute_monitor()
