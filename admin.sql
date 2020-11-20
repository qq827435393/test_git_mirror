SET NAMES utf8;
-- grant all on *.* to cloudos@localhost identified by 'Max@2018';
DROP DATABASE IF EXISTS `max_vpn_admin`;
CREATE DATABASE `max_vpn_admin`;
USE `max_vpn_admin`;

DROP TABLE IF EXISTS `mvad_group`;
CREATE TABLE `mvad_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` varchar(128) NOT NULL,
  `group_name` varchar(32) NOT NULL,
  `parent_id` varchar(128) not null default "" COMMENT "父节点",
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY (`group_id`),
  KEY (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户组';

DROP TABLE IF EXISTS `mvad_login`;
CREATE TABLE `mvad_login` (
  `login_id` char(64) CHARACTER SET utf8 NOT NULL,
  `user_id` int(11) NOT NULL,
  `account` varchar(128) NOT NULL DEFAULT '' COMMENT '帐号',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '姓名',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT '用户等级',
  `role_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户角色',
  `email` char(64) NOT NULL DEFAULT '' COMMENT '邮箱',
  `phone` varchar(16) CHARACTER SET utf8 NOT NULL,
  `ip` varchar(16) CHARACTER SET utf8 NOT NULL,
  `device` varchar(64) NOT NULL DEFAULT '' COMMENT "登录设备",
  `agent` varchar(256) CHARACTER SET utf8 NOT NULL COMMENT '终端或浏览器',
  `login_time` datetime NOT NULL,
  `act_time` datetime NOT NULL,
  PRIMARY KEY (`login_id`),
  KEY `login_time` (`login_time`),
  KEY `mobile` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='在线用户登录表';

DROP TABLE IF EXISTS `mvad_admin_login`;
CREATE TABLE `mvad_admin_login` (
  `login_id` char(64) CHARACTER SET utf8 NOT NULL,
  `user_id` int(11) NOT NULL,
  `account` varchar(128) NOT NULL DEFAULT '' COMMENT '帐号',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '姓名',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT '用户等级',
  `role_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户角色',
  `email` char(64) NOT NULL DEFAULT '' COMMENT '邮箱',
  `phone` varchar(16) CHARACTER SET utf8 NOT NULL,
  `ip` varchar(16) CHARACTER SET utf8 NOT NULL,
  `device` varchar(64) NOT NULL DEFAULT '' COMMENT "登录设备",
  `agent` varchar(256) CHARACTER SET utf8 NOT NULL COMMENT '终端或浏览器',
  `login_time` datetime NOT NULL,
  `act_time` datetime NOT NULL,
  PRIMARY KEY (`login_id`),
  KEY `account` (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='在线管理员登录表';


DROP TABLE IF EXISTS `mvad_menu`;
CREATE TABLE `mvad_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) NOT NULL DEFAULT '' COMMENT '菜单名',
  `controller` varchar(32) NOT NULL DEFAULT '' COMMENT '控制器',
  `action` varchar(32) NOT NULL DEFAULT '' COMMENT '动作',
  `icon` varchar(64) NOT NULL DEFAULT '' COMMENT '图标',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT '菜单等级',
  `type` enum('directory','leaf') NOT NULL DEFAULT 'leaf' COMMENT '菜单类型',
  `parentid` int(11) NOT NULL DEFAULT '0' COMMENT '父ID',
  `status` enum('invalid','valid') NOT NULL DEFAULT 'valid' COMMENT '菜单状态',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `morder` int default 0 COMMENT '菜单顺序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='菜单表';

INSERT INTO `mvad_menu` (`id`, `title`, `controller`, `action`, `icon`, `level`, `type`, `parentid`, `status`, `add_time`,`morder`) VALUES
(1,	'资源配置',	'',	'',	'fa-sitemap',	0,	'directory',	0,	'valid',	'2018-07-10 00:00:00',2),
-- (2,	'所有站点',	'website',	'index',	'fa-internet-explorer',	0,	'leaf',	1,	'valid',	'2018-07-10 00:00:00',99999),
-- (3,	'远程桌面',	'terminal',	'index',	'fa-terminal',	0,	'leaf',	1,	'valid',	'2018-07-10 00:00:00',99999),
(4,	'用户管理',	'',	'',	'fa-user-md',	0,	'directory',	0,	'valid',	'2018-07-10 00:00:00',3),
(22,	'全量用户',	'user',	'index',	'fa-user',	0,	'leaf',	4,	'valid',	'2018-07-10 00:00:00',99999),
-- (5,	'用户分组',	'group',	'index',	'fa-group',	0,	'leaf',	4,	'valid',	'2018-07-10 00:00:00',99999),
-- (7,	'注册审核',	'userReg',	'index',	'fa-check-square-o',	0,	'leaf',	4,	'valid',	'2018-07-10 00:00:00',99999),
(8,	'系统设置',	'',	'',	'fa-television',	0,	'directory',	0,	'valid',	'2018-07-10 00:00:00',6),
-- (9,	'系统状态',	'statesys',	'index',	'fa-industry',	0,	'leaf',	8,	'valid',	'2018-07-10 00:00:00',99999),
-- (10,	'系统设置',	'settingsys',	'index',	'fa-cog',	0,	'leaf',	8,	'valid',	'2018-07-10 00:00:00',99999),
-- (11,	'系统升级',	'upgrade',	'index',	'fa-refresh',	0,	'leaf',	8,	'valid',	'2018-07-10 00:00:00',99999),
-- (12,	'网卡设置',	'network',	'index',	'fa-hdd-o',	0,	'leaf',	8,	'valid',	'2018-07-10 00:00:00',99999),
-- (13,	'路由设置',	'router',	'index',	' fa-cogs',	0,	'leaf',	8,	'valid',	'2018-07-10 00:00:00',99999),
-- (14,	'产品授权',	'productauth',	'index',	'fa-creative-commons',	0,	'leaf',	8,	'valid',	'2018-07-10 00:00:00',99999),
(15,  '日志统计',	'',	'',	'fa-arrows',	0,	'directory',	0,	'valid',	'2018-07-10 00:00:00',4),
-- (16,	'在线用户',	'onlineuser',	'index',	'fa-globe',	0,	'leaf',	15,	'valid',	'2018-07-10 00:00:00',99999),
(17,	'资源使用分析',	'logsys',	'index',	'fa-pencil-square',	0,	'leaf',	15,	'valid',	'2018-07-10 00:00:00',99999),
-- (18,	'入侵拦截',	'intercept',	'index',	'fa-briefcase',	0,	'leaf',	15,	'valid',	'2018-07-10 00:00:00',99999),
(18,'安全防护日志',	'security',	'index',	'fa-briefcase',	0,	'leaf',	15,	'valid',	'2018-07-10 00:00:00',99999),
-- (19,	'报毒情况',	'virus',	'index',	'fa-eye',	0,	'leaf',	15,	'valid',	'2018-07-10 00:00:00',99999),
-- (20,	'终端录像',	'playback',	'index',	'fa-video-camera',	0,	'leaf',	15,	'valid',	'2018-07-10 00:00:00',99999),
-- (21,	'升级日志',	'updatelog',	'index',	'fa-edit',	0,	'leaf',	15,	'valid',	'2018-07-10 00:00:00',99999),
(6,'管理员','role','index','fa-user-plus',0,'leaf',	4,	'valid',	'2018-07-10 00:00:00',99999),
(23,	'系统首页',	'overview',	'index',	'fa-home',	0,	'leaf',	0,	'valid',	'2018-07-10 00:00:00',1),
-- (24,	'概览',	'overview',	'index',	'fa-bar-chart',	0,	'leaf',	23,	'valid',	'2018-07-10 00:00:00',99999),
(27, '云枢代理','yunshuProxy','index','fa-tasks',0,'leaf',	1,	'valid',	'2018-07-10 00:00:00',99999),
(26,	'企业微信代理',	'wechatProxy',	'index',	'fa-chain',	0,	'leaf',	1,	'valid',	'2018-07-10 00:00:00',99999),
-- (28,	'统计信息',	'chart',	'index',	'fa-line-chart',	0,	'leaf',	23,	'valid',	'2018-07-10 00:00:00',99999),
-- (29,	'敏感检测配置',	'sensitive',	'index',	'fa-filter',	0,	'leaf',	8,	'valid',	'2018-07-10 00:00:00',99999),
-- (30,	'代理设置',	'proxy',	'index',	'fa-wrench',	0,	'leaf',	31,	'valid',	'2018-07-10 00:00:00',99999),
-- (31,	'透明代理',	'',	'',	'fa-wrench',	0,	'leaf',	0,	'valid',	'2018-07-10 00:00:00',2),
-- (32, '水印配置','watermark','index','fa-tint',0,'leaf',8,'valid','2018-07-10 00:00:00',99999),
-- (33, '证书设置','certificate','index','fa-certificate',0,'leaf',8,'valid','2018-07-10 00:00:00',99999),
(34,'管理员操作日志','adminlog','index','fa-file-o',0,'leaf',15,'valid','2018-07-10 00:00:00',99999),
(35,'用户登录日志','loginlog','index','fa-user-circle-o',0,'leaf',15,'valid','2018-07-10 00:00:00',99999),
-- (36,'第三方用户列表','thirduser','index','fa-weixin',0,'leaf',4,'valid','2018-07-10 00:00:00',99999),
(37,'服务器状态',	'statesys',	'index',	'fa-pencil-square',	0,	'leaf',	0,	'valid',	'2018-07-10 00:00:00',5),
(38,'整体概览',	'useroverview',	'index',	'fa-pencil-square',	0,	'leaf',	4,	'valid',	'2018-07-10 00:00:00',5),
(39,'用户状态',	'userstatus',	'index',	'fa-pencil-square',	0,	'leaf',	4,	'valid',	'2018-07-10 00:00:00',6),
(40,'服务设置', 'servicesetting', 'index',  'fa-pencil-square', 0,  'leaf', 8,  'valid',  '2018-07-10 00:00:00',99997),
(41,'信息安全配置', 'informationsafety',  'index',  'fa-pencil-square', 0,  'leaf', 8,  'valid',  '2018-07-10 00:00:00',99998),
(42,'通知设置', 'notificationsetting',  'index',  'fa-pencil-square', 0,  'leaf', 8,  'valid',  '2018-07-10 00:00:00',99999),
(36,'IP策略管理','policy','index','fa-codepen',0,'leaf',8,'valid','2018-07-10 00:00:00',99999),
(43,'密钥管理','secretkey','index','fa-key',0,'leaf',8,'valid','2018-07-10 00:00:00',99999),
(44, '企业微信地址工具', 'oauthaddress', 'index', 'fa-pencil-square', 0, 'leaf', 8, 'valid', '2018-07-10 00:00:00', 99999),
(45, '日志配置', 'debugconfig', 'index', 'fa-pencil-square', 0, 'leaf', 8, 'valid', '2018-07-10 00:00:00', 99999);



DROP TABLE IF EXISTS `mvad_phone`;
CREATE TABLE `mvad_phone` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phone` varchar(16) NOT NULL DEFAULT '' COMMENT '手机号码',
  `send_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最后一次发送短信的时间戳',
  `today_total` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '今天发送次数',
  `total` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发送短信总次数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='手机获得激活码记录表';


DROP TABLE IF EXISTS `mvad_terminal_download`;
CREATE TABLE `mvad_terminal_download` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file_hash` char(32) DEFAULT NULL COMMENT '文件hash',
  `file_name` varchar(256) DEFAULT NULL COMMENT '文件名',
  `upload_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '上传时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='下载列表';


DROP TABLE IF EXISTS `mvad_terminal_file_log`;
CREATE TABLE `mvad_terminal_file_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_account` varchar(128) NOT NULL DEFAULT '' COMMENT '用户账号',
  `file_hash` char(32) DEFAULT NULL COMMENT '文件hash',
  `file_size` bigint(20) NOT NULL DEFAULT '0' COMMENT '文件大小',
  `file_name` varchar(256) DEFAULT NULL COMMENT '文件名',
  `add_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '上传时间',
  `ip` varchar(16) NOT NULL DEFAULT '' COMMENT 'ip地址',
  `tav_result` enum('risk','norisk') NOT NULL DEFAULT 'norisk' COMMENT 'tav扫描结果',
  `virus_name` varchar(32) DEFAULT NULL COMMENT '病毒名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='终端上传的文件';



DROP TABLE IF EXISTS `mvad_update_config_queue`;
CREATE TABLE `mvad_update_config_queue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) NOT NULL DEFAULT '0' COMMENT '资源ID',
  `domain_prefix` varchar(16) NOT NULL DEFAULT '' COMMENT '域名前缀',
  `protocol` varchar(16) NOT NULL DEFAULT '' COMMENT '协议',
  `command` enum('online','offline') NOT NULL DEFAULT 'online' COMMENT '操作',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='配置文件更新队列';


DROP TABLE IF EXISTS `mvad_user`;
CREATE TABLE `mvad_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(128) NOT NULL DEFAULT '' COMMENT '帐号',
  `passwd` char(32) NOT NULL DEFAULT '' COMMENT '密码',
  `phone` varchar(16) DEFAULT '' COMMENT '手机号码',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '姓名',
  `srand` char(32) NOT NULL DEFAULT '' COMMENT 'srand',
  `email` char(64) NOT NULL DEFAULT '' COMMENT '邮箱',
  `add_time` datetime DEFAULT NOW() COMMENT '添加时间',
  `act_time` datetime DEFAULT NOW() COMMENT '最后一次使用时间',
  `remark` varchar(1024) DEFAULT '' NOT NULL,
  `today_logs` int(11) not null default 0  comment "今天日志数",
  `exp_time` datetime DEFAULT '9999-12-31 23:59:59' COMMENT '有效期',
  `role_id` int unsigned not null default 0  comment "角色ID",
  `status` enum('invalid','valid','removed','lock') NOT NULL DEFAULT 'valid' COMMENT '帐号状态',
  `lock_time` datetime DEFAULT NULL COMMENT '被锁定时间',
  `delete_time` datetime DEFAULT NULL COMMENT '被删除时间',
  `lock_reason` varchar(64) NOT NULL DEFAULT '' COMMENT "被锁定原因",
  `lock_ip` varchar(16) NOT NULL DEFAULT '' COMMENT "被锁定时登录ip",
  `lock_device` varchar(64) NOT NULL DEFAULT '' COMMENT "被锁定时登录设备",
  `level` int(11) NOT NULL DEFAULT '0' COMMENT '用户等级',
  `ext1` varchar(128) COMMENT '拓展字段1',
  `ext2` varchar(128) COMMENT '拓展字段2',
  PRIMARY KEY (`user_id`),
  KEY `phone` (`phone`),
  KEY `act_time` (`act_time`),
  KEY `today_logs` (`today_logs`),
  UNIQUE KEY `account` (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';


DROP TABLE IF EXISTS `mvad_user_group`;
CREATE TABLE `mvad_user_group` (
  `user_account` varchar(128) NOT NULL,
  `group_id` varchar(128) NOT NULL,
  PRIMARY KEY (`user_account`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户和用户组对应关系';


DROP TABLE IF EXISTS `mvad_resource_catalog`;
CREATE TABLE `mvad_resource_catalog` (
  `catalog_id` int(11) NOT NULL AUTO_INCREMENT,
  `catalog_name` varchar(32) NOT NULL,
  PRIMARY KEY (`catalog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `mvad_resource_catalog` (`catalog_id`, `catalog_name`) VALUES(1,	'内部管理系统');


DROP TABLE IF EXISTS `mvad_system_config`;
CREATE TABLE `mvad_system_config` (
  `key` varchar(32) NOT NULL,
  `value` varchar(2048) NOT NULL,
  `type` enum('system','user','ini') NOT NULL DEFAULT 'system' COMMENT '数据类型，system类型写入defineEx文件',
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT "defineEx文件表";
INSERT INTO `mvad_system_config` VALUES ('DEFAULT_AGENT_ON','true','system');
INSERT INTO `mvad_system_config` VALUES ('DEFAULT_AUTH_TYPE','TencentSMS','system');
INSERT INTO `mvad_system_config` VALUES ('GOV_WX_TYPE','local','system');
INSERT INTO `mvad_system_config` VALUES ('DEFAULT_COMPANY','Max','system');
INSERT INTO `mvad_system_config` VALUES ('DEFAULT_DOMAIN_CLIENT','www.cloudmyos.com','system');
INSERT INTO `mvad_system_config` VALUES ('DEFAULT_DOMAIN_PORT','80','system');
INSERT INTO `mvad_system_config` VALUES ('DEFAULT_DOMAIN_PROTOCOL','http','system');
INSERT INTO `mvad_system_config` VALUES ('DEFAULT_DOMAIN_SSO','sso.cloudmyos.com','system');
INSERT INTO `mvad_system_config` VALUES ('DEFAULT_DOMAIN_TERMINAL','terminal.cloudmyos.com','system');
INSERT INTO `mvad_system_config` VALUES ('DEFAULT_SYSTEM_DOMAIN','cloudmyos.com','system');
INSERT INTO `mvad_system_config` VALUES ('DEFAULT_SYSTEM_NAME','云控平台','system');
INSERT INTO `mvad_system_config` VALUES ('DEFAULT_CERT_ID','','system');
INSERT INTO `mvad_system_config` VALUES ('GOV_WX_AGENTID','','system');
INSERT INTO `mvad_system_config` VALUES ('GOV_WX_CORPID','','system');
INSERT INTO `mvad_system_config` VALUES ('GOV_WX_HOST','','system');
INSERT INTO `mvad_system_config` VALUES ('GOV_WX_SECRET','','system');
INSERT INTO `mvad_system_config` VALUES ('GOV_WX_SYS_SECRET','2xTW0rZFzwJraLKQpYy0BkYM5G1fuu_NqvtCJmRHQn0','system');
INSERT INTO `mvad_system_config` VALUES ('PROXY_SAFE','WAF:OFF|SEN:OFF|WAT:OFF|WEB:OFF','system');
INSERT INTO `mvad_system_config` VALUES ('DEFAULT_PROXY_URL','','user');
INSERT INTO `mvad_system_config` VALUES ('DEFAULT_PROXY_USERNAME','','user');
INSERT INTO `mvad_system_config` VALUES ('DEFAULT_PROXY_PASSWORD','','user');
INSERT INTO `mvad_system_config` VALUES ('DEFAULT_SYSTEM_ACTIVE_CODE','','user');
INSERT INTO `mvad_system_config` VALUES ('ALI_SMS_API','https://dysmsapi.aliyuncs.com','ini');
INSERT INTO `mvad_system_config` VALUES ('ALI_SMS_SIGN','','ini');
INSERT INTO `mvad_system_config` VALUES ('ALI_SMS_TEMPLATE_CODE','','ini');
INSERT INTO `mvad_system_config` VALUES ('ALI_SMS_ACCESS_KEY_ID','','ini');
INSERT INTO `mvad_system_config` VALUES ('ALI_SMS_ACCESS_KEY_SECRET','','ini');
INSERT INTO `mvad_system_config` VALUES ('LDAP_SERVER_ADDR','','ini');
INSERT INTO `mvad_system_config` VALUES ('LDAP_ROOT_DN','','ini');
INSERT INTO `mvad_system_config` VALUES ('LDAP_FILTER','','ini');
INSERT INTO `mvad_system_config` VALUES ('LDAP_ADMIN_DN','','ini');
INSERT INTO `mvad_system_config` VALUES ('LDAP_ADMIN_PASSWD','','ini');
INSERT INTO `mvad_system_config` VALUES ('LDAP_DISPLAY_NAME','','ini');
INSERT INTO `mvad_system_config` VALUES ('DEFAULT_GUID','','system');
INSERT INTO `mvad_system_config` VALUES ('LOG_ACCESS_ON','true','ini');
INSERT INTO `mvad_system_config` VALUES ('LOG_DEBUG_ON','false','ini');
INSERT INTO `mvad_system_config` VALUES ('LOG_NGINX_ACCESS_ON','false','ini');
INSERT INTO `mvad_system_config` VALUES ('LOG_NGINX_ERROR_ON','false','ini');

DROP TABLE IF EXISTS `mvad_system_setting_queue`;
CREATE TABLE `mvad_system_setting_queue` (
  `task` varchar(32) NOT NULL,
  `status` enum('wait','run') NOT NULL DEFAULT 'wait' COMMENT '状态',
  `start_time` BIGINT(20) DEFAULT NULL COMMENT "当前任务开始时间",
  PRIMARY KEY (`task`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT "系统相关设置队列";

drop table if exists mvad_role;
create table mvad_role(
	role_id int unsigned not null auto_increment,
	role_name varchar(32) not null default "" comment "角色名",
	add_time bigint default 0 comment "添加时间",
	primary key(role_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

INSERT INTO `mvad_role` VALUES
(5,'系统管理员',1548810932),
(6,'审计管理员',1548810964),
(7,'运营管理员',1548810984);

drop table if exists mvad_role_rule;
create table mvad_role_rule(
	id int unsigned not null auto_increment,
	role_id int unsigned not null default 0 comment "角色ID",
	cgi_label varchar(64) not null default "" COMMENT "cgi标记",
	primary key(id),
	unique key(role_id,cgi_label)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限表';

INSERT ignore INTO `mvad_role_rule` VALUES
(158,5,'role_cgi_root_certificate_add'),
(101,5,'role_cgi_statesys_index'),
(102,5,'role_cgi_settingsys_index'),
(103,5,'role_cgi_settingsys_set'),
(104,5,'role_cgi_certificate_add'),
(105,5,'role_cgi_certificate_update'),
(106,5,'role_cgi_certificate_delete'),
(107,5,'role_cgi_productauth_auth'),
(108,5,'role_cgi_informationsafaty_index'),
(109,5,'role_cgi_informationsafaty_update'),
(110,5,'role_cgi_sensitive_add'),
(111,5,'role_cgi_sensitive_delete'),
(112,5,'role_cgi_notificationset_index'),
(113,5,'role_cgi_notificationset_update'),
(114,5,'role_cgi_policy_add'),
(115,5,'role_cgi_policy_update'),
(116,5,'role_cgi_policy_delete'),
(117,5,'role_cgi_policy_index'),
(200,6,'role_cgi_adminlog_delete'),
(201,6,'role_cgi_adminlog_export'),
(202,6,'role_cgi_adminlog_index'),
(203,6,'role_cgi_security_index'),
(204,6,'role_cgi_loginlog_delete'),
(205,6,'role_cgi_loginlog_export'),
(206,6,'role_cgi_loginlog_index'),
(207,6,'role_cgi_logfqc_export'),
(208,6,'role_cgi_logsys_delete'),
(209,6,'role_cgi_logsys_export'),
(210,6,'role_cgi_logres_index'),
(211,6,'role_cgi_overview_index'),
(300,7,'role_cgi_resource_index'),
(301,7,'role_cgi_resource_add'),
(302,7,'role_cgi_resource_update'),
(303,7,'role_cgi_resource_move'),
(304,7,'role_cgi_resource_delete'),
(305,7,'role_cgi_resource_addcatalog'),
(306,7,'role_cgi_resource_updatecatalog'),
(307,7,'role_cgi_resource_deletecatalog'),
(308,7,'role_cgi_proxy_index'),
(309,7,'role_cgi_proxy_set'),
(310,7,'role_cgi_useroverview_index'),
(311,7,'role_cgi_userstatus_index'),
(312,7,'role_cgi_online_logout'),
(313,7,'role_cgi_user_unlock'),
(314,7,'role_cgi_user_index'),
(315,7,'role_cgi_user_add'),
(317,7,'role_cgi_user_update'),
(318,7,'role_cgi_user_delete'),
(319,7,'role_cgi_user_updatemypwd'),
(320,7,'role_cgi_user_updatepwd'),
(321,7,'role_cgi_user_add_group'),
(322,7,'role_cgi_user_del_group'),
(323,7,'role_cgi_user_update_group'),
(324,7,'role_cgi_role_add'),
(325,7,'role_cgi_role_update'),
(326,7,'role_cgi_role_delete'),
(327,7,'role_cgi_role_index'),
(328,7,'role_cgi_admin_add'),
(329,7,'role_cgi_admin_update'),
(330,7,'role_cgi_admin_delete'),
(331,7,'role_cgi_user_recover'),
(332,7,'role_cgi_set_group'); 



drop table if exists mvad_cgi;
create table mvad_cgi(
	cgi_id int unsigned not null auto_increment,
	menu_id int not null default 0 COMMENT "菜单ID",
	cgi_label varchar(64) not null default "" COMMENT "cgi标记",
	cgi_name varchar(64) not null default "" COMMENT "cgi名称",
	primary key(cgi_id),
	unique key(cgi_label)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='cgi列表';


DROP TABLE IF EXISTS `mvad_resource_rule`;
CREATE TABLE `mvad_resource_rule` (
  `id` int unsigned not null auto_increment,
  `resource_id` int(11) NOT NULL COMMENT "资源ID",
  `rule_id` varchar(128) NOT NULL COMMENT "组ID或用户account",
  `type` enum('group','user') NOT NULL DEFAULT "group" COMMENT "资源类型",
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT "组对应资源表";

drop table if exists mvad_resource;
create table mvad_resource(
	`resource_id` int NOT NULL AUTO_INCREMENT,
	`name` varchar(256) NOT NULL DEFAULT "" COMMENT "资源名称",
  `foregin_protocol` varchar(16) NOT NULL DEFAULT "" COMMENT "外网协议",
	`domain` varchar(128) NOT NULL DEFAULT "" COMMENT "对外域名",
	`foreign_port` int NOT NULL DEFAULT 0 COMMENT "对外端口",
	`cert_id` int NOT NULL DEFAULT 0 COMMENT "证书ID",
  `root_cert_id` int NOT NULL DEFAULT 0 COMMENT "根证书ID",
	`catalog_id` int(11) NOT NULL DEFAULT "0",
	`host` varchar(128) NOT NULL DEFAULT "" COMMENT "内网域名",
  `http_host` varchar(128) NOT NULL DEFAULT "" COMMENT "给内网的http_host",
  `port` int NOT NULL DEFAULT 0 COMMENT "内网端口号",
  `protocol` varchar(16) NOT NULL DEFAULT "" COMMENT "内网协议",
	`uri` varchar(1024) NOT NULL DEFAULT "" COMMENT "路径",
	`timeout` int unsigned NOT NULL DEFAULT 0 COMMENT "超时时间",
	`policy_id` int NOT NULL DEFAULT 0 COMMENT "策略ID",
  `auth_policy_id` int NOT NULL DEFAULT 0 COMMENT "免授权策略ID",
  `pid` int unsigned NOT NULL DEFAULT 0 COMMENT "父亲资源ID",
  `auth_type` enum("nocheck","secret","system","login") NOT NULL DEFAULT "system" COMMENT "鉴权类型",
  `resource_type` enum("api","business") NOT NULL DEFAULT "business" COMMENT "资源类型",
  `replace_content` varchar(1024) not null default "" COMMENT "配置地址替换内容",
	`is_sensitive` enum("false","true") NOT NULL DEFAULT "false" COMMENT "站点是否敏感",
	`need_waf` enum("false","true") NOT NULL DEFAULT "false" COMMENT "是否需要waf防火墙",
	`need_watermask` enum("false","true") NOT NULL DEFAULT "false" COMMENT "是否需要水印",
  `need_warning` enum("false","true") NOT NULL DEFAULT "false" COMMENT "是否开启异常提醒",
  `warning_num` int NOT NULL DEFAULT 0 COMMENT "超过多少%提醒",
  `add_time` datetime DEFAULT NULL COMMENT "添加时间",
	`status` enum("invalid","valid") NOT NULL DEFAULT "valid" COMMENT "状态",
	PRIMARY KEY (`resource_id`),
	key (`domain`),
	key (`catalog_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT="资源表";

drop table if exists mvad_secret;
create table mvad_secret(
  secret_id int unsigned NOT NULL DEFAULT 0 COMMENT "ID",
  secret_key varchar(128) NOT NULL DEFAULT 0 COMMENT "密钥",
  `secret` varchar(128) NOT NULL DEFAULT "" COMMENT "私钥",
  title varchar(128) NOT NULL DEFAULT "" COMMENT "名称",
  `status` enum("invalid","valid") NOT NULL DEFAULT "valid" COMMENT "状态",
  update_time datetime DEFAULT NULL COMMENT "添加时间",
  primary key(secret_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT="API密钥表";

drop table if exists mvad_rlt_secret_resource;
create table mvad_rlt_secret_resource(
    id int unsigned not null default 0 COMMENT "ID",
    secret_id int unsigned NOT NULL DEFAULT 0 COMMENT "密钥ID",
    resource_id int NOT NULL DEFAULT 0 COMMENT "资源ID",
    primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT="资源密钥关系表";

drop table if exists mvad_protocol;
CREATE TABLE mvad_protocol(
	`protocol_id` int NOT NULL AUTO_INCREMENT,
	`name` varchar(16) NOT NULL DEFAULT "" COMMENT "协议名称",
	`protocol` varchar(16) NOT NULL DEFAULT "" COMMENT "协议值",
	`type` varchar(16) NOT NULL DEFAULT "" COMMENT "类型",
	`port` int default 0 COMMENT "默认端口",
	primary key(protocol_id),
	unique key(`protocol`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT="资源协议表";
insert into mvad_protocol set protocol_id=1,`name`="http",`protocol`="http",`type`="website",`port`=80;
insert into mvad_protocol set protocol_id=2,`name`="https",`protocol`="https",`type`="website",`port`=443;
-- insert into mvad_protocol set protocol_id=3,`name`="ssh",`protocol`="ssh",`type`="terminal",`port`=22;
-- insert into mvad_protocol set protocol_id=4,`name`="rdp",`protocol`="rdp",`type`="terminal",`port`=3389;
-- insert into mvad_protocol set protocol_id=5,`name`="vnc",`protocol`="vnc",`type`="terminal",`port`=5901;
-- insert into mvad_protocol set protocol_id=6,`name`="ftp",`protocol`="ftp",`type`="file",`port`=21;
-- insert into mvad_protocol set protocol_id=7,`name`="sftp",`protocol`="sftp",`type`="file",`port`=22;
insert into mvad_protocol set protocol_id=8,`name`="御点代理",`protocol`="client",`type`="website",`port`=15033;
insert into mvad_protocol set protocol_id=9,`name`="云枢门户访问",`protocol`="web",`type`="website",`port`=80;
insert into mvad_protocol set protocol_id=10,`name`="企业微信代理",`protocol`="agent",`type`="website",`port`=15031;

drop table if exists mvad_security_policy;
CREATE TABLE mvad_security_policy(
	`id` int unsigned NOT NULL AUTO_INCREMENT,
	`name` varchar(32) NOT NULL DEFAULT "" COMMENT "策略名称",
  `type` enum("white","black") NOT NULL default "white" COMMENT "类型，黑名单和白名单",
	`create_time` datetime DEFAULT NULL COMMENT "添加时间",
	primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT "ip策略表";

drop table if exists mvad_policy_ips;
CREATE TABLE mvad_policy_ips(
	`id` int unsigned NOT NULL AUTO_INCREMENT,
	`ip` varchar(18) NOT NULL DEFAULT "" COMMENT "ip",
	`policy_id` int unsigned NOT NULL DEFAULT 0 COMMENT "策略id",
	primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT "策略ip";


DROP TABLE IF EXISTS `mvad_agent_config`;
CREATE TABLE `mvad_agent_config` (
  `key` varchar(16) NOT NULL DEFAULT '' COMMENT 'key',
  `value` varchar(128) NOT NULL DEFAULT '' COMMENT '内容',
PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='透明代理配置库';


DROP TABLE IF EXISTS `mvad_sensitive_rule`;
CREATE TABLE `mvad_sensitive_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL DEFAULT '' COMMENT '规则名称',
  `context` varchar(16) DEFAULT NULL COMMENT '规则内容',
  `type` enum('phone','identify','word') NOT NULL DEFAULT 'word' COMMENT '类型',
  `status` enum('valid','invalid') NOT NULL DEFAULT 'valid' COMMENT '状态',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
PRIMARY KEY (`id`),
KEY `add_time` (`add_time`),
KEY `context` (`context`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='敏感检测规则库';
insert into mvad_sensitive_rule set `name`="手机号过滤",`type`="phone",`status`="valid",`add_time`="2018-08-08 08:00:00";
insert into mvad_sensitive_rule set `name`="身份证号过滤",`type`="identify",`status`="valid",`add_time`="2018-08-08 08:00:00";

DROP TABLE IF EXISTS `mvad_watermark`;
CREATE TABLE `mvad_watermark` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(16) NOT NULL DEFAULT '' COMMENT '规则key',
  `name` varchar(16) NOT NULL DEFAULT '' COMMENT '规则名称',
  `context` varchar(16) DEFAULT NULL COMMENT '规则内容',
  `add_time` datetime DEFAULT NULL COMMENT '修改时间',
PRIMARY KEY (`id`),
KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='水印配置库';
insert into mvad_watermark set `key`="see",`name`="可见水印",`context`="no",`add_time`=NOW();
insert into mvad_watermark set `key`="type",`name`="水印样式",`context`="name_time",`add_time`=NOW();
insert into mvad_watermark set `key`="color",`name`="水印颜色",`context`="#d8d8d8",`add_time`=NOW();

DROP TABLE IF EXISTS `mvad_certificate`;
CREATE TABLE `mvad_certificate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain` varchar(128) NOT NULL DEFAULT '' COMMENT '域名',
  `pem_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'pem文件名',
  `key_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'key文件名',
  `pem_path` varchar(256) DEFAULT NULL COMMENT 'pem路径',
  `key_path` varchar(256) DEFAULT NULL COMMENT 'key路径',
  `cert_content` text DEFAULT NULL COMMENT '证书内容',
  `key_content` text DEFAULT NULL COMMENT '密钥内容',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `exp_time` datetime DEFAULT NULL COMMENT '证书有效期',
  `type` enum('cert','root_cert') DEFAULT 'cert' COMMENT '证书类型',
  `status` enum('use','unuse') NOT NULL DEFAULT 'unuse' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ssl证书库';

DROP TABLE IF EXISTS `mvad_notification_set`;
CREATE TABLE `mvad_notification_set` (
	`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
	`logsize_warning` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否打开日志总量提醒',
	`logsize_warning_threshold` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '超过总量提醒比例',
	`intercept_warning` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否打开新增拦截提醒',
	`server_except_warning` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否打开服务器异常提醒',
	`disk_except_warning` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否打开服务器分区异常提醒',
	`cpu_except_warning` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否打开cpu异常提醒',
	`cpu_avg_except_warning` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否打开cpu平均负载常提醒',
	`cert_expire_warning` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否打开授权过期提醒',
	`except_login_warning` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否打开异常登录提醒',
	`except_login_threshold` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '超过用户数',
	`noti_gov_wechat` tinyint(1) NOT NULL DEFAULT '0' COMMENT '通知方式企业微信',
	`noti_mail` tinyint(1) NOT NULL DEFAULT '0' COMMENT '通知方式邮件',
	`noti_phone_message` tinyint(1) NOT NULL DEFAULT '0' COMMENT '通知方式手机短信',
	PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT "系统通知设置";
INSERT INTO `mvad_notification_set` (`logsize_warning`, `logsize_warning_threshold`, `intercept_warning`, `server_except_warning`, `cpu_except_warning`,`cpu_avg_except_warning`,`disk_except_warning`, `cert_expire_warning`, `except_login_warning`, `except_login_threshold`, `noti_gov_wechat`, `noti_mail`, `noti_phone_message`) VALUES
  (1, '100',1,1,1,1,1,1,1,10,1,0,0);

DROP TABLE IF EXISTS `mvad_notification_user`;
CREATE TABLE `mvad_notification_user` (
	`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
	`account` varchar(128) NOT NULL COMMENT '用户帐号',
	PRIMARY KEY (`id`),
	UNIQUE KEY `account` (`account`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT "管理员通知列表";

-- marry start
DROP TABLE IF EXISTS `mvad_clear_db`;
CREATE TABLE `mvad_clear_db` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT,
  `d_ip` varchar(16) NOT NULL DEFAULT '',
  `d_port` int(5) NOT NULL DEFAULT 0,
  `d_ctype` char(16) NOT NULL DEFAULT '' COMMENT 'db、table、binlog',
  `d_name` varchar(512) NOT NULL DEFAULT '',
  `d_backup` enum('Y','N') NOT NULL DEFAULT 'N',
  `d_backup_path` varchar(255) DEFAULT '',
  `d_clean_day`  int(3) DEFAULT 0 COMMENT '0 不清理',
  `d_status`  enum('init','doing','done') NOT NULL DEFAULT 'init',
  `d_result`  varchar(512) NOT NULL DEFAULT '',
  `d_time`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `valid` enum('Y','N') NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`d_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 COMMENT='数据库清理备份';

insert into mvad_clear_db set d_ip='127.0.0.1',d_port=3306,d_ctype='binlog',d_name='expire_logs_days',d_clean_day=3;
insert into mvad_clear_db set d_ip='127.0.0.1',d_port=3306,d_ctype='db',d_name='max_vpn_admin',d_backup='Y',d_backup_path='/data/mdata/db_backup';
insert into mvad_clear_db set d_ip='127.0.0.1',d_port=3306,d_ctype='db',d_name='max_vpn_statistic',d_backup='Y',d_backup_path='/data/mdata/db_backup';
insert into mvad_clear_db set d_ip='127.0.0.1',d_port=3307,d_ctype='binlog',d_name='expire_logs_days',d_clean_day=3;
insert into mvad_clear_db set d_ip='127.0.0.1',d_port=3307,d_ctype='table',d_name='max_vpn_log.mvlg_auth_log_%',d_clean_day=60;

DROP TABLE IF EXISTS `mvad_clear_log`;
CREATE TABLE `mvad_clear_log` (
  `c_id` int(11) NOT NULL AUTO_INCREMENT,
  `c_ctype` char(16) NOT NULL DEFAULT '' COMMENT 'dir、file',
  `c_path` varchar(512) NOT NULL DEFAULT '',
  `c_clean_day`  int(3) DEFAULT 0 COMMENT '置空',
  `c_clean_size`  char(16) NOT NULL DEFAULT '0' ,
  `c_status`  enum('init','doing','done') NOT NULL DEFAULT 'init',
  `c_result`  varchar(512) NOT NULL DEFAULT '',
  `c_time`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `valid` enum('Y','N') NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 COMMENT='日志清理';

insert into mvad_clear_log set c_ctype='dir',c_path='/data/mdata/logs/servers',c_clean_day=3;
insert into mvad_clear_log set c_ctype='dir',c_path='/data/mdata/logs/servers',c_clean_size='100M';
insert into mvad_clear_log set c_ctype='dir',c_path='/data/mdata/logs/supervisor',c_clean_size='10M';
insert into mvad_clear_log set c_ctype='file',c_path='/data/mdata/logs/demo';
-- marry end

DROP DATABASE IF EXISTS `max_vpn_log`;
CREATE DATABASE `max_vpn_log`;
USE `max_vpn_log`;
DROP TABLE IF EXISTS `mvlg_auth_log_p`;
CREATE TABLE `mvlg_auth_log_p`(
	`id` int unsigned NOT NULL auto_increment,
	`add_time` datetime NOT NULL COMMENT "访问时间",
	`account` varchar(128) NOT NULL COMMENT "访问帐号",
	`name` varchar (32) NOT NULL DEFAULT '' COMMENT "姓名",
	`level` int(11) NOT NULL COMMENT '用户等级',
	`ip` varchar(16) NOT NULL COMMENT "访问IP",
	`resource_type` varchar(16) NOT NULL COMMENT "资源类型",
  `auth_type` varchar(16) NOT NULL COMMENT "授权类型",
	`resource_id` int NOT NULL COMMENT "资源ID",
  `port` int(11) NOT NULL COMMENT '访问节点地址端口',
	`source` varchar(256) NOT NULL COMMENT "访问代理地址",
	`target` varchar(256) NOT NULL COMMENT "访问节点地址",
	`uri` varchar(512) NOT NULL COMMENT "访问的URI",
	`is_ajax` enum("false","true") NOT NULL COMMENT "是否是ajax请求",
	`status` int NOT NULL COMMENT "状态",
	`user_agent` varchar(256) NOT NULL COMMENT "用户代理",
	PRIMARY KEY(id),
	INDEX(add_time DESC)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT "访问日志";

SET @cur_table = CONCAT("mvlg_auth_log", date_format(now(),'_%Y%m%d'));
SET @c = CONCAT('create table if not exists ',@cur_table, ' like mvlg_auth_log_p');
PREPARE stmt from @c;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @cur_table2 = CONCAT("mvlg_auth_log", date_format(date_add(now(),INTERVAL 1 DAY),'_%Y%m%d'));
SET @c2 = CONCAT('create table if not exists ',@cur_table2, ' like mvlg_auth_log_p');
PREPARE stmt2 from @c2;
EXECUTE stmt2;
DEALLOCATE PREPARE stmt2;

SET @cur_table3 = CONCAT("mvlg_auth_log", date_format(date_add(now(),INTERVAL 2 DAY),'_%Y%m%d'));
SET @c3 = CONCAT('create table if not exists ',@cur_table3, ' like mvlg_auth_log_p');
PREPARE stmt3 from @c3;
EXECUTE stmt3;
DEALLOCATE PREPARE stmt3;

DROP TABLE IF EXISTS `mvlg_terminal_log`;
CREATE TABLE `mvlg_terminal_log`(
  `id` int unsigned NOT NULL auto_increment,
  `account` varchar(128) NOT NULL COMMENT "访问帐号",
  `level` int(11) NOT NULL DEFAULT '0' COMMENT '用户等级',
  `account_name` varchar(32) NOT NULL DEFAULT '' COMMENT "账号姓名",
  `ip` varchar(16) NOT NULL COMMENT "源ip",
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '终端名称',
  `host` varchar(64) NOT NULL DEFAULT '' COMMENT '主机地址',
  `protocol` varchar(16) NOT NULL DEFAULT '' COMMENT '协议如ssh,rdp',
  `port` int(11) NOT NULL DEFAULT '0' COMMENT '端口',
  `log_name` varchar(64) NOT NULL DEFAULT '' COMMENT '录像文件名',
  `add_time` datetime DEFAULT NULL COMMENT "访问时间",
  primary key(id),
  key(add_time),
  UNIQUE KEY `log_name` (`log_name`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT "终端访问日志";

DROP TABLE IF EXISTS `mvlg_waf_log`;
CREATE TABLE `mvlg_waf_log`(
  `id` int unsigned NOT NULL auto_increment,
  `account` varchar(128) NOT NULL COMMENT "访问帐号",
  `ip` varchar(16) NOT NULL COMMENT "攻击源ip",
  `url` text DEFAULT NULL COMMENT '攻击路径',
  `data` varchar(256) NOT NULL DEFAULT '' COMMENT '攻击内容',
  `ruletag` varchar(256) NOT NULL DEFAULT '' COMMENT '攻击类型',
  `add_time` datetime DEFAULT NULL COMMENT "攻击时间",
  primary key(id),
  key(add_time)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT "waf攻击日志";

DROP TABLE IF EXISTS `mvlg_login_log`;
CREATE TABLE `mvlg_login_log`(
  `id` int unsigned NOT NULL auto_increment,
  `login_time` datetime DEFAULT NULL COMMENT "登录时间",
  `account` varchar(128) NOT NULL COMMENT "访问帐号",
  `name` varchar(32) NOT NULL COMMENT "姓名",
  `level` int(11) NOT NULL DEFAULT '0' COMMENT '用户等级',
  `ip` varchar(16) NOT NULL COMMENT "源ip",
  `type` varchar(16) NOT NULL COMMENT "登录方式",
  `device` varchar(16) NOT NULL DEFAULT '' COMMENT "登录设备",
  `status` varchar(16) NOT NULL COMMENT "登录结果",
  `system` varchar(16) NOT NULL COMMENT "登录系统",
  primary key(id),
  key(login_time)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT "用户登录日志";

DROP TABLE IF EXISTS `mvlg_admin_log`;
CREATE TABLE `mvlg_admin_log`(
  `id` int unsigned NOT NULL auto_increment,
  `add_time` datetime DEFAULT NULL COMMENT "操作时间",
  `account` varchar(128) NOT NULL COMMENT "访问帐号",
  `name` varchar(32) NOT NULL COMMENT "姓名",
  `module_name` varchar(64) NOT NULL COMMENT "操作模块",
  `cgi_name` varchar(64) NOT NULL COMMENT "操作名称",
  `level` int(11) NOT NULL DEFAULT '0' COMMENT '用户等级',
  `ip` varchar(16) NOT NULL COMMENT "源ip",
  `status` int(11) NOT NULL COMMENT "操作结果",
  `role_name` varchar(16) NOT NULL COMMENT "角色名",
  primary key(id),
  key(add_time)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT "后台操作日志";

DROP DATABASE IF EXISTS `max_vpn_statistic`;
CREATE DATABASE `max_vpn_statistic`;
USE `max_vpn_statistic`;
DROP TABLE IF EXISTS `mvs_resource_log`;
CREATE TABLE `mvs_resource_log`(
  `id` int unsigned NOT NULL auto_increment,
  `resource_id` int NOT NULL COMMENT "资源ID",
  `identity` varchar(256) NOT NULL DEFAULT "" COMMENT "资源统计标识",
  `name` varchar(256) NOT NULL DEFAULT "" COMMENT "资源名称",
  `type` varchar(16) NOT NULL DEFAULT "" COMMENT "类型",
  `protocol` varchar(16) NOT NULL DEFAULT "" COMMENT "协议",
  `host` varchar(128) NOT NULL DEFAULT "" COMMENT "域名",
  `port` int NOT NULL DEFAULT 0 COMMENT "端口号",
  `enter_count` int(11) NOT NULL COMMENT "入口访问次数",
  `user_count` int(11) NOT NULL COMMENT "独立用户访问次数",
  `add_time` datetime DEFAULT NULL COMMENT "统计时间",
  primary key(`id`),
  key(`add_time`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT "资源id访问统计表";

DROP TABLE IF EXISTS `mvs_resource_type_log`;
CREATE TABLE `mvs_resource_type_log`(
  `id` int unsigned NOT NULL auto_increment,
  `type` varchar(32) NOT NULL COMMENT "资源类型",
  `enter_count` int(11) NOT NULL COMMENT "入口访问次数",
  `user_count` int(11) NOT NULL COMMENT "独立用户访问次数",
  `add_time` datetime DEFAULT NULL COMMENT "统计时间",
  primary key(`id`),
  key(`add_time`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT "资源类型访问统计表";

DROP TABLE IF EXISTS `mvs_user_log`;
CREATE TABLE `mvs_user_log`(
  `id` int unsigned NOT NULL auto_increment,
  `total_count` int(11) NOT NULL COMMENT "总点击数",
  `resource_count` int(11) NOT NULL COMMENT "使用资源总数",
  `user_count` int(11) NOT NULL COMMENT "总使用用户数",
  `add_time` datetime DEFAULT NULL COMMENT "统计时间",
  primary key(`id`),
  key(`add_time`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT "用户访问日志统计表";

DROP TABLE IF EXISTS `mvs_history_log`;
CREATE TABLE `mvs_history_log`(
  `id` int unsigned NOT NULL auto_increment,
  `path` varchar(128) NOT NULL COMMENT "路径",
  `date` varchar(32) NOT NULL COMMENT "日期",
  `size` int(11) NOT NULL COMMENT "大小",
  `add_time` datetime DEFAULT NULL COMMENT "添加时间",
  primary key(`id`),
  key(`add_time`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT "用户访问日志历史存档表";

DROP TABLE IF EXISTS `mvs_visit_count_log`;
CREATE TABLE `mvs_visit_count_log`(
  `id` int unsigned NOT NULL auto_increment,
  `source_token` varchar(256) NOT NULL COMMENT "资源token, 1.反向代理由: 'reverse_proxy/'+资源id, 2.正向代理由:'agent/' + target组成，3. 外加一个'total' ",
  `count` int unsigned NOT NULL COMMENT "访问次数",
  `thresh` int unsigned NOT NULL COMMENT "报警阈值",
  `isWarning` tinyint unsigned NOT NULL COMMENT "当天是否报警",
  `date` date NOT NULL COMMENT "统计日期",
  primary key(`id`),
  key(`date`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT "资源访问次数统计表";

DROP TABLE IF EXISTS `mvs_online_count_history`;
CREATE TABLE `mvs_online_count_history`(
  `id` int unsigned NOT NULL auto_increment,
  `count` int(11) NOT NULL COMMENT "人数",
  `add_time` datetime DEFAULT NULL COMMENT "添加时间",
  primary key(`id`),
  key(`add_time`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT "用户在线人数历史";

DROP TABLE IF EXISTS `mvs_user_log_count`;
CREATE TABLE `mvs_user_log_count`(
  `id` int unsigned NOT NULL auto_increment,
  `account` varchar(128) NOT NULL COMMENT "访问帐号",
  `today_logs` int(11) NOT NULL DEFAULT 0 COMMENT "今天日志数",
  `act_time` datetime DEFAULT NOW() COMMENT "最后一次使用时间",
  PRIMARY KEY(`id`),
  KEY (`account`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT "用户访问日志数";



grant all on *.* to cloudos@localhost identified by 'Max@2018';
