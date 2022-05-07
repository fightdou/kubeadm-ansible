/*
 Navicat Premium Data Transfer

 Source Server         : FSD-1.0新开发环境
 Source Server Type    : MySQL
 Source Server Version : 50505
 Source Host           : 172.27.122.202
 Source Database       : xxl_job

 Target Server Type    : MySQL
 Target Server Version : 50505
 File Encoding         : utf-8

 Date: 05/05/2022 15:50:59 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `xxl_job_group`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_group`;
CREATE TABLE `xxl_job_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(64) NOT NULL COMMENT '执行器AppName',
  `title` varchar(12) NOT NULL COMMENT '执行器名称',
  `address_type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '执行器地址类型：0=自动注册、1=手动录入',
  `address_list` text DEFAULT NULL COMMENT '执行器地址列表，多地址逗号分隔',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Records of `xxl_job_group`
-- ----------------------------
BEGIN;
INSERT INTO `xxl_job_group` VALUES ('2', 'fsd-executor', '云桌面执行器', '0', 'http://172.18.106.36:9999/,http://172.18.106.57:9999/,http://192.168.254.8:9999/', '2022-05-05 15:50:50'), ('15', 'fsd-desktop', 'test', '1', 'http://172.18.106.92:9999/', '2022-03-25 13:12:31');
COMMIT;

-- ----------------------------
--  Table structure for `xxl_job_info`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_info`;
CREATE TABLE `xxl_job_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_desc` varchar(255) NOT NULL,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(255) DEFAULT NULL COMMENT '报警邮件',
  `schedule_type` varchar(50) NOT NULL DEFAULT 'NONE' COMMENT '调度类型',
  `schedule_conf` varchar(128) DEFAULT NULL COMMENT '调度配置，值含义取决于调度类型',
  `misfire_strategy` varchar(50) NOT NULL DEFAULT 'DO_NOTHING' COMMENT '调度过期策略',
  `executor_route_strategy` varchar(50) DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_timeout` int(11) NOT NULL DEFAULT 0 COMMENT '任务执行超时时间，单位秒',
  `executor_fail_retry_count` int(11) NOT NULL DEFAULT 0 COMMENT '失败重试次数',
  `glue_type` varchar(50) NOT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext DEFAULT NULL COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` varchar(255) DEFAULT NULL COMMENT '子任务ID，多个逗号分隔',
  `trigger_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '调度状态：0-停止，1-运行',
  `trigger_last_time` bigint(13) NOT NULL DEFAULT 0 COMMENT '上次调度时间',
  `trigger_next_time` bigint(13) NOT NULL DEFAULT 0 COMMENT '下次调度时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Records of `xxl_job_info`
-- ----------------------------
BEGIN;
INSERT INTO `xxl_job_info` VALUES ('4', '2', '系统-定时清除日志', '2022-02-18 13:59:05', '2022-02-24 15:43:11', '袁玮', '', 'CRON', '0 10 0 * * ?', 'DO_NOTHING', 'LAST', 'log_delete_handler', '', 'SERIAL_EXECUTION', '0', '0', 'BEAN', '', 'GLUE代码初始化', '2022-02-18 13:59:05', '', '1', '1651680600000', '1651767000000'), ('5', '2', '系统-定时mqtt发送日志状态数量', '2022-02-22 10:45:49', '2022-02-24 15:34:28', '袁玮', '', 'FIX_RATE', '30', 'DO_NOTHING', 'LAST', 'log_status_handler', '', 'SERIAL_EXECUTION', '0', '0', 'BEAN', '', 'GLUE代码初始化', '2022-02-22 10:45:49', '', '1', '1651737031017', '1651737061017'), ('11', '2', '系统-定时清理回收站', '2022-03-16 11:31:57', '2022-03-16 13:15:07', '王兆迎', '', 'CRON', '0 1 0 * * ?', 'DO_NOTHING', 'ROUND', 'desktop_delete_handler', '', 'SERIAL_EXECUTION', '0', '0', 'BEAN', '', 'GLUE代码初始化', '2022-03-16 11:31:57', '', '1', '1651680060000', '1651766460000'), ('32', '2', '系统-定时开关机', '2022-04-01 14:06:16', '2022-04-01 14:06:43', '王兆迎', '', 'CRON', '0 0,30 0-23 * * ?', 'DO_NOTHING', 'ROUND', 'desktop_plan_handler', '', 'SERIAL_EXECUTION', '0', '0', 'BEAN', '', 'GLUE代码初始化', '2022-04-01 14:06:16', '', '1', '1651735800000', '1651737600000'), ('37', '15', '同步云桌面', '2022-04-05 21:23:59', '2022-04-05 21:23:59', '马延毅', null, 'CRON', '50 24 21 05 04 ? 2022', 'DO_NOTHING', 'LAST', 'desktop_sync_handler', '{\"nowTimeFlag\":0,\"snapshotUuid\":\"678c7637-29b9-4901-96b1-d0c23ed052c9\",\"syncMode\":\"existing\",\"syncTime\":1649165090000,\"uuid\":\"b6e365aa-2b61-4016-bde6-144537a9bab9\"}', 'SERIAL_EXECUTION', '0', '0', 'BEAN', '', 'GLUE代码初始化', '2022-04-05 21:23:59', null, '0', '0', '0'), ('39', '15', '同步云桌面', '2022-04-05 21:43:45', '2022-04-28 16:41:00', '马延毅', '', 'CRON', '39 44 21 05 04 ? 2022', 'DO_NOTHING', 'LAST', 'desktop_sync_handler', '{\"nowTimeFlag\":0,\"snapshotUuid\":\"678c7637-29b9-4901-96b1-d0c23ed052c9\",\"syncMode\":\"existing\",\"syncTime\":1649166279000,\"uuid\":\"b6e365aa-2b61-4016-bde6-144537a9bab9\"}', 'SERIAL_EXECUTION', '0', '0', 'BEAN', '', 'GLUE代码初始化', '2022-04-05 21:43:45', '', '0', '0', '0'), ('40', '2', '更新授权状态', '2022-04-07 16:32:11', '2022-04-07 17:08:28', '马延毅', '', 'CRON', '0 0 1 * * ?', 'DO_NOTHING', 'ROUND', 'license_expired_handler', '', 'SERIAL_EXECUTION', '0', '0', 'BEAN', '', 'GLUE代码初始化', '2022-04-07 16:32:11', '', '1', '1651683600000', '1651770000000'), ('41', '2', '系统-定时更新中控台状态', '2022-04-23 11:27:26', '2022-04-23 12:55:36', '王兆迎', '', 'CRON', '0 */1 * * * ?', 'DO_NOTHING', 'ROUND', 'console_status_handler', '', 'SERIAL_EXECUTION', '0', '0', 'BEAN', '', 'GLUE代码初始化', '2022-04-23 11:27:26', '', '1', '1651737060000', '1651737120000'), ('42', '2', '同步云桌面', '2022-04-28 09:30:47', '2022-04-28 09:30:47', '马延毅', null, 'CRON', '00 30 09 28 04 ? 2022', 'DO_NOTHING', 'LAST', 'desktop_sync_handler', '{\"nowTimeFlag\":0,\"snapshotUuid\":\"368ca518-8445-41cf-9bea-edd9ff18a782\",\"syncMode\":\"existing\",\"syncTime\":1651109400000,\"uuid\":\"ad837965-881a-4bb0-82b5-4dd836374206\"}', 'SERIAL_EXECUTION', '0', '0', 'BEAN', '', 'GLUE代码初始化', '2022-04-28 09:30:47', null, '0', '0', '0'), ('43', '2', '模板机生成bt种子', '2022-04-28 11:25:45', '2022-05-02 16:49:23', '马延毅', '', 'CRON', '0 0/1 * * * ?', 'DO_NOTHING', 'FIRST', 'template_generate_torrent_handler', '', 'SERIAL_EXECUTION', '0', '0', 'BEAN', '', 'GLUE代码初始化', '2022-04-28 11:25:45', '', '0', '0', '0'), ('44', '2', '同步云桌面', '2022-04-28 16:35:11', '2022-04-28 16:35:11', '马延毅', null, 'CRON', '00 34 16 29 04 ? 2022', 'DO_NOTHING', 'LAST', 'desktop_sync_handler', '{\"nowTimeFlag\":0,\"snapshotUuid\":\"56f1ba73-5b04-4092-86e8-d6d9ced31b34\",\"syncMode\":\"existing\",\"syncTime\":1651221240000,\"uuid\":\"2b59630c-b777-44f7-9af9-a4c7a0ab76c3\"}', 'SERIAL_EXECUTION', '0', '0', 'BEAN', '', 'GLUE代码初始化', '2022-04-28 16:35:11', null, '0', '0', '0'), ('45', '2', '同步云桌面', '2022-04-28 16:38:03', '2022-04-28 16:38:47', '马延毅', '', 'CRON', '00 39 16 28 04 ? 2022', 'FIRE_ONCE_NOW', 'LAST', 'desktop_sync_handler', '{\"nowTimeFlag\":0,\"snapshotUuid\":\"7db856a3-7a8e-4e35-be9c-9aeda0a512e8\",\"syncMode\":\"existing\",\"syncTime\":1651135140000,\"uuid\":\"2b59630c-b777-44f7-9af9-a4c7a0ab76c3\"}', 'SERIAL_EXECUTION', '0', '0', 'BEAN', '', 'GLUE代码初始化', '2022-04-28 16:38:03', '', '0', '0', '0'), ('46', '2', '系统-VOI客户机定时计划', '2022-04-29 20:05:10', '2022-05-01 11:05:19', '王兆迎', '', 'CRON', '0 0,30 0-23 * * ?', 'DO_NOTHING', 'ROUND', 'client_plan_handler', '', 'SERIAL_EXECUTION', '0', '0', 'BEAN', '', 'GLUE代码初始化', '2022-04-29 20:05:10', '', '1', '1651735800000', '1651737600000'), ('47', '2', '同步云桌面', '2022-05-01 15:14:09', '2022-05-01 15:14:09', '马延毅', null, 'CRON', '57 13 15 01 05 ? 2022', 'FIRE_ONCE_NOW', 'LAST', 'desktop_sync_handler', '{\"nowTimeFlag\":0,\"snapshotUuid\":\"5cbd8797-cee1-4d59-82bc-ab29a3ae2d08\",\"syncMode\":\"existing\",\"syncTime\":1651389237000,\"uuid\":\"82ef9b8b-0d2d-4e58-a7d4-95f99d8be24d\"}', 'SERIAL_EXECUTION', '0', '0', 'BEAN', '', 'GLUE代码初始化', '2022-05-01 15:14:09', null, '0', '0', '0'), ('48', '2', '同步云桌面', '2022-05-01 15:15:07', '2022-05-01 15:15:07', '马延毅', null, 'CRON', '58 14 15 01 05 ? 2022', 'FIRE_ONCE_NOW', 'LAST', 'desktop_sync_handler', '{\"nowTimeFlag\":0,\"snapshotUuid\":\"fac11fa6-45c9-4847-b7ed-beac0b6b97c6\",\"syncMode\":\"existing\",\"syncTime\":1651389298000,\"uuid\":\"82ef9b8b-0d2d-4e58-a7d4-95f99d8be24d\"}', 'SERIAL_EXECUTION', '0', '0', 'BEAN', '', 'GLUE代码初始化', '2022-05-01 15:15:07', null, '0', '0', '0');
COMMIT;

-- ----------------------------
--  Table structure for `xxl_job_lock`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_lock`;
CREATE TABLE `xxl_job_lock` (
  `lock_name` varchar(50) NOT NULL COMMENT '锁名称',
  PRIMARY KEY (`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Records of `xxl_job_lock`
-- ----------------------------
BEGIN;
INSERT INTO `xxl_job_lock` VALUES ('schedule_lock');
COMMIT;

-- ----------------------------
--  Table structure for `xxl_job_log`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_log`;
CREATE TABLE `xxl_job_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_id` int(11) NOT NULL COMMENT '任务，主键ID',
  `executor_address` varchar(255) DEFAULT NULL COMMENT '执行器地址，本次执行的地址',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `executor_sharding_param` varchar(20) DEFAULT NULL COMMENT '执行器任务分片参数，格式如 1/2',
  `executor_fail_retry_count` int(11) NOT NULL DEFAULT 0 COMMENT '失败重试次数',
  `trigger_time` datetime DEFAULT NULL COMMENT '调度-时间',
  `trigger_code` int(11) NOT NULL COMMENT '调度-结果',
  `trigger_msg` text DEFAULT NULL COMMENT '调度-日志',
  `handle_time` datetime DEFAULT NULL COMMENT '执行-时间',
  `handle_code` int(11) NOT NULL COMMENT '执行-状态',
  `handle_msg` text DEFAULT NULL COMMENT '执行-日志',
  `alarm_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败',
  PRIMARY KEY (`id`),
  KEY `I_trigger_time` (`trigger_time`),
  KEY `I_handle_code` (`handle_code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Records of `xxl_job_log`
-- ----------------------------
BEGIN;
INSERT INTO `xxl_job_log` VALUES ('1', '2', '41', 'http://172.18.106.36:9999/', 'console_status_handler', '', null, '0', '2022-05-05 15:51:00', '200', '任务触发类型：Cron触发<br>调度机器：192.168.254.9<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://172.18.106.36:9999/, http://172.18.106.57:9999/, http://192.168.254.8:9999/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://172.18.106.36:9999/<br>code：200<br>msg：null', '2022-05-05 15:51:00', '200', '', '0');
COMMIT;

-- ----------------------------
--  Table structure for `xxl_job_log_report`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_log_report`;
CREATE TABLE `xxl_job_log_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trigger_day` datetime DEFAULT NULL COMMENT '调度-时间',
  `running_count` int(11) NOT NULL DEFAULT 0 COMMENT '运行中-日志数量',
  `suc_count` int(11) NOT NULL DEFAULT 0 COMMENT '执行成功-日志数量',
  `fail_count` int(11) NOT NULL DEFAULT 0 COMMENT '执行失败-日志数量',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `i_trigger_day` (`trigger_day`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Records of `xxl_job_log_report`
-- ----------------------------
BEGIN;
INSERT INTO `xxl_job_log_report` VALUES ('1', '2022-01-30 00:00:00', '0', '7', '0', null), ('2', '2022-01-29 00:00:00', '0', '0', '0', null), ('3', '2022-01-28 00:00:00', '0', '0', '0', null), ('4', '2022-02-07 00:00:00', '0', '10', '52', null), ('5', '2022-02-06 00:00:00', '0', '0', '0', null), ('6', '2022-02-05 00:00:00', '0', '0', '0', null), ('7', '2022-02-14 00:00:00', '0', '0', '0', null), ('8', '2022-02-13 00:00:00', '0', '0', '0', null), ('9', '2022-02-12 00:00:00', '0', '0', '0', null), ('10', '2022-02-15 00:00:00', '0', '0', '0', null), ('11', '2022-02-16 00:00:00', '0', '0', '0', null), ('12', '2022-02-17 00:00:00', '0', '0', '0', null), ('13', '2022-02-18 00:00:00', '0', '0', '9', null), ('14', '2022-02-19 00:00:00', '0', '0', '0', null), ('15', '2022-02-20 00:00:00', '0', '0', '0', null), ('16', '2022-02-21 00:00:00', '0', '0', '0', null), ('17', '2022-02-22 00:00:00', '0', '1386', '146', null), ('18', '2022-02-23 00:00:00', '0', '2817', '63', null), ('19', '2022-02-24 00:00:00', '0', '2854', '26', null), ('20', '2022-02-25 00:00:00', '0', '2875', '6', null), ('21', '2022-02-26 00:00:00', '0', '2880', '1', null), ('22', '2022-02-27 00:00:00', '0', '2881', '0', null), ('23', '2022-02-28 00:00:00', '0', '2877', '4', null), ('24', '2022-03-01 00:00:00', '0', '2877', '4', null), ('25', '2022-03-02 00:00:00', '0', '2873', '8', null), ('26', '2022-03-03 00:00:00', '0', '2872', '9', null), ('27', '2022-03-04 00:00:00', '0', '2880', '1', null), ('28', '2022-03-05 00:00:00', '0', '2880', '1', null), ('29', '2022-03-06 00:00:00', '0', '2881', '0', null), ('30', '2022-03-07 00:00:00', '0', '2877', '4', null), ('31', '2022-03-08 00:00:00', '0', '2878', '3', null), ('32', '2022-03-09 00:00:00', '0', '2868', '13', null), ('33', '2022-03-10 00:00:00', '0', '2872', '9', null), ('34', '2022-03-11 00:00:00', '0', '2869', '12', null), ('35', '2022-03-12 00:00:00', '0', '2880', '1', null), ('36', '2022-03-13 00:00:00', '0', '2880', '1', null), ('37', '2022-03-14 00:00:00', '0', '2872', '9', null), ('38', '2022-03-15 00:00:00', '0', '2866', '15', null), ('39', '2022-03-16 00:00:00', '0', '2871', '11', null), ('40', '2022-03-17 00:00:00', '0', '2870', '12', null), ('41', '2022-03-18 00:00:00', '0', '2870', '12', null), ('42', '2022-03-19 00:00:00', '0', '2880', '2', null), ('43', '2022-03-20 00:00:00', '0', '2880', '2', null), ('44', '2022-03-21 00:00:00', '0', '2868', '14', null), ('45', '2022-03-22 00:00:00', '0', '2876', '6', null), ('46', '2022-03-23 00:00:00', '0', '2872', '10', null), ('47', '2022-03-24 00:00:00', '0', '2874', '8', null), ('48', '2022-03-25 00:00:00', '0', '2869', '16', null), ('49', '2022-03-26 00:00:00', '0', '2881', '1', null), ('50', '2022-03-27 00:00:00', '0', '2880', '2', null), ('51', '2022-03-28 00:00:00', '0', '2651', '231', null), ('52', '2022-03-29 00:00:00', '0', '2880', '2', null), ('53', '2022-03-30 00:00:00', '0', '2878', '4', null), ('54', '2022-03-31 00:00:00', '0', '2869', '13', null), ('55', '2022-04-01 00:00:00', '0', '2869', '32', null), ('56', '2022-04-02 00:00:00', '0', '2903', '27', null), ('57', '2022-04-03 00:00:00', '0', '2915', '15', null), ('58', '2022-04-04 00:00:00', '0', '2927', '3', null), ('59', '2022-04-05 00:00:00', '0', '2796', '136', null), ('60', '2022-04-06 00:00:00', '0', '2906', '24', null), ('61', '2022-04-07 00:00:00', '0', '2920', '17', null), ('62', '2022-04-08 00:00:00', '0', '2895', '24', null), ('63', '2022-04-09 00:00:00', '0', '2910', '21', null), ('64', '2022-04-10 00:00:00', '0', '2928', '3', null), ('65', '2022-04-11 00:00:00', '0', '2896', '35', null), ('66', '2022-04-12 00:00:00', '0', '2905', '26', null), ('67', '2022-04-13 00:00:00', '0', '2879', '43', null), ('68', '2022-04-14 00:00:00', '1', '2909', '21', null), ('69', '2022-04-15 00:00:00', '0', '2914', '15', null), ('70', '2022-04-16 00:00:00', '0', '2919', '12', null), ('71', '2022-04-17 00:00:00', '0', '1473', '0', null), ('72', '2022-04-18 00:00:00', '0', '1832', '21', null), ('73', '2022-04-19 00:00:00', '0', '2899', '32', null), ('74', '2022-04-20 00:00:00', '0', '2846', '85', null), ('75', '2022-04-21 00:00:00', '0', '2910', '21', null), ('76', '2022-04-22 00:00:00', '0', '2906', '25', null), ('77', '2022-04-23 00:00:00', '0', '3400', '1237', null), ('78', '2022-04-24 00:00:00', '0', '3876', '372', null), ('79', '2022-04-25 00:00:00', '0', '3018', '48', null), ('80', '2022-04-27 00:00:00', '0', '1844', '51', null), ('81', '2022-04-26 00:00:00', '0', '2', '0', null), ('82', '2022-04-28 00:00:00', '0', '4991', '133', null), ('83', '2022-04-29 00:00:00', '0', '5766', '46', null), ('84', '2022-04-30 00:00:00', '0', '5795', '16', null), ('85', '2022-05-01 00:00:00', '0', '5818', '18', null), ('86', '2022-05-02 00:00:00', '0', '5391', '38', null), ('87', '2022-05-03 00:00:00', '0', '4306', '113', null), ('88', '2022-05-04 00:00:00', '0', '4374', '45', null), ('89', '2022-05-05 00:00:00', '0', '2897', '22', null);
COMMIT;

-- ----------------------------
--  Table structure for `xxl_job_logglue`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_logglue`;
CREATE TABLE `xxl_job_logglue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) NOT NULL COMMENT '任务，主键ID',
  `glue_type` varchar(50) DEFAULT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext DEFAULT NULL COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) NOT NULL COMMENT 'GLUE备注',
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `xxl_job_registry`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_registry`;
CREATE TABLE `xxl_job_registry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `registry_group` varchar(50) NOT NULL,
  `registry_key` varchar(255) NOT NULL,
  `registry_value` varchar(255) NOT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `i_g_k_v` (`registry_group`,`registry_key`,`registry_value`)
) ENGINE=InnoDB AUTO_INCREMENT=4333 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Records of `xxl_job_registry`
-- ----------------------------
BEGIN;
INSERT INTO `xxl_job_registry` VALUES ('4306', 'EXECUTOR', 'fsd-executor', 'http://172.18.106.36:9999/', '2022-05-05 15:50:59'), ('4329', 'EXECUTOR', 'fsd-executor', 'http://192.168.254.8:9999/', '2022-05-05 15:50:36'), ('4332', 'EXECUTOR', 'fsd-executor', 'http://172.18.106.57:9999/', '2022-05-05 15:50:59');
COMMIT;

-- ----------------------------
--  Table structure for `xxl_job_user`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_user`;
CREATE TABLE `xxl_job_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '账号',
  `password` varchar(50) NOT NULL COMMENT '密码',
  `role` tinyint(4) NOT NULL COMMENT '角色：0-普通用户、1-管理员',
  `permission` varchar(255) DEFAULT NULL COMMENT '权限：执行器ID列表，多个逗号分割',
  PRIMARY KEY (`id`),
  UNIQUE KEY `i_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Records of `xxl_job_user`
-- ----------------------------
BEGIN;
INSERT INTO `xxl_job_user` VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '1', null);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
