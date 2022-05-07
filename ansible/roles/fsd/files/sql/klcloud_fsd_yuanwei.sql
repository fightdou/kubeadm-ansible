/*
 Navicat Premium Data Transfer

 Source Server         : FSD-1.0.0开发环境
 Source Server Type    : MySQL
 Source Server Version : 50505
 Source Host           : 172.27.139.208
 Source Database       : klcloud_fsd

 Target Server Type    : MySQL
 Target Server Version : 50505
 File Encoding         : utf-8

 Date: 04/11/2022 15:22:03 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `des_network`
-- ----------------------------
DROP TABLE IF EXISTS `des_network`;
CREATE TABLE `des_network` (
  `uuid` varchar(50) NOT NULL DEFAULT '' COMMENT '网络uuid',
  `name` varchar(100) DEFAULT '' COMMENT '网络名称',
  `network_desktop_type` varchar(20) DEFAULT '' COMMENT '桌面类型：【vdi】【voi】【all】',
  `network_type` varchar(20) DEFAULT '' COMMENT '网络类型：【vlan】【flat】',
  `physical` varchar(50) DEFAULT '' COMMENT 'vlan，flat指定的物理网卡名称，vxlan不需要',
  `vlan_id` int(11) DEFAULT NULL COMMENT 'vlanid： 1～4094',
  `description` text DEFAULT '' COMMENT '描述',
  `resouce_status` varchar(50) DEFAULT '' COMMENT '资源状态',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `createpin` varchar(100) DEFAULT '' COMMENT '创建人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `updatepin` varchar(100) DEFAULT '' COMMENT '修改人',
  `yn` tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='网络';

-- ----------------------------
--  Table structure for `des_network_card`
-- ----------------------------
DROP TABLE IF EXISTS `des_network_card`;
CREATE TABLE `des_network_card` (
  `uuid` varchar(50) NOT NULL DEFAULT '' COMMENT '网卡uuid',
  `name` varchar(100) DEFAULT '' COMMENT '网卡名称',
  `subnet_uuid` varchar(50) DEFAULT '' COMMENT '子网uuid',
  `description` text DEFAULT '' COMMENT '描述',
  `ip` varchar(100) DEFAULT '' COMMENT 'ip地址',
  `mac` varchar(100) DEFAULT '' COMMENT 'mac地址',
  `purpose` varchar(20) DEFAULT '' COMMENT '用途',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `createpin` varchar(100) DEFAULT '' COMMENT '创建人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `updatepin` varchar(100) DEFAULT '' COMMENT '修改人',
  `yn` tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='网卡';

-- ----------------------------
--  Table structure for `des_subnet`
-- ----------------------------
DROP TABLE IF EXISTS `des_subnet`;
CREATE TABLE `des_subnet` (
  `uuid` varchar(50) NOT NULL DEFAULT '' COMMENT '子网uuid',
  `name` varchar(100) DEFAULT '' COMMENT '子网名称',
  `network_uuid` varchar(50) DEFAULT '' COMMENT '网络uuid',
  `publicity` varchar(10) DEFAULT '' COMMENT '公开性：【public】公开【private】私有',
  `cidr` varchar(100) DEFAULT '' COMMENT '网段(包含子网掩码)',
  `cidr_desktop_type` varchar(20) DEFAULT '' COMMENT 'cidr桌面类型：【vdi】【voi】【all】',
  `ip_pool` text DEFAULT '' COMMENT 'IP地址池：x.x.x.x,x.x.x.y',
  `gateway_ip` varchar(100) DEFAULT '' COMMENT '网关',
  `dns` varchar(200) DEFAULT '' COMMENT 'NDS服务器地址,多个以逗号隔开',
  `dhcp` varchar(11) DEFAULT '' COMMENT '是否开启dhcp：【on】【off】',
  `description` text DEFAULT '' COMMENT '描述',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `createpin` varchar(100) DEFAULT '' COMMENT '创建人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `updatepin` varchar(100) DEFAULT '' COMMENT '修改人',
  `yn` tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='子网';

-- ----------------------------
--  Table structure for `mon_alarm_log`
-- ----------------------------
DROP TABLE IF EXISTS `mon_alarm_log`;
CREATE TABLE `mon_alarm_log` (
  `uuid` varchar(50) NOT NULL DEFAULT '' COMMENT '告警日志uuid',
  `module` varchar(50) DEFAULT '' COMMENT '告警模块',
  `type` varchar(50) DEFAULT '' COMMENT '类型【alarm】【recovery】',
  `message` text DEFAULT '' COMMENT '告警信息',
  `messageExtra` text DEFAULT '' COMMENT '告警信息附加参数',
  `target_uuid` varchar(50) DEFAULT '' COMMENT '告警对象UUID或IP',
  `target_name` varchar(100) DEFAULT '' COMMENT '告警对象名称',
  `trigger_time` datetime DEFAULT NULL COMMENT '触发时间',
  `description` varchar(500) DEFAULT '' COMMENT '描述',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `createpin` varchar(100) DEFAULT '' COMMENT '创建人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `updatepin` varchar(100) DEFAULT '' COMMENT '修改人',
  `yn` tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='告警日志';

-- ----------------------------
--  Table structure for `mon_alarm_receive`
-- ----------------------------
DROP TABLE IF EXISTS `mon_alarm_receive`;
CREATE TABLE `mon_alarm_receive` (
  `uuid` varchar(50) NOT NULL DEFAULT '' COMMENT '告警接收端uuid',
  `name` varchar(100) DEFAULT '' COMMENT '告警接收端名称',
  `able` varchar(20) DEFAULT '' COMMENT '告警接收端可用性【enable】【disable】',
  `period` varchar(20) DEFAULT '' COMMENT '告警接收端告警时间间隔',
  `type` varchar(20) DEFAULT '' COMMENT '告警接收端分类【default】【custom】',
  `notify_type` varchar(20) DEFAULT '' COMMENT '告警接收端通知类型【alarm】【alarm_recovery】',
  `receiver_type` varchar(20) DEFAULT '' COMMENT '告警接收端类型【webhook】【log】【message】【mail】【ding】',
  `receiver_params` text DEFAULT '' COMMENT '告警接收端参数',
  `receiver_target` text DEFAULT '' COMMENT '告警接收端目标',
  `sort` int(10) DEFAULT NULL COMMENT '排序',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `createpin` varchar(100) DEFAULT '' COMMENT '创建人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `updatepin` varchar(100) DEFAULT '' COMMENT '修改人',
  `yn` tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='告警接收端';

-- ----------------------------
--  Records of `mon_alarm_receive`
-- ----------------------------
BEGIN;
INSERT INTO `mon_alarm_receive` VALUES ('0afc6fc3-7599-4683-8fcd-15d31ecac6b7', 'mail', 'enable', '10m', 'custom', 'alarm', 'mail', '{\"encrypt\":\"SSL/TLS\",\"password\":\"ELGXEESTJBIQSYLA\",\"port\":465,\"smtp\":\"smtp.163.com\",\"username\":\"testfsd@163.com\"}', '[\"27792500@qq.com\"]', '3', '2022-03-22 19:11:31', '', '2022-04-08 15:16:45', '00008ed4-0441-4373-8d6f-57188fb52bc1', '1'), ('a707f31e-6237-4570-89a4-5ae5944642e2', 'message', 'enable', '10m', 'default', 'alarm_recovery', 'message', '', '', '2', '2022-03-22 19:10:47', '', null, '', '1'), ('d1ac3ec0-5083-4d99-8252-fb785c2544d5', 'log', 'enable', '10m', 'default', 'alarm_recovery', 'log', '', '', '1', '2022-03-22 19:08:21', '', null, '', '1');
COMMIT;

-- ----------------------------
--  Table structure for `mon_alarm_rule`
-- ----------------------------
DROP TABLE IF EXISTS `mon_alarm_rule`;
CREATE TABLE `mon_alarm_rule` (
  `uuid` varchar(50) NOT NULL DEFAULT '' COMMENT '告警规则uuid',
  `name` varchar(100) DEFAULT '' COMMENT '告警规则名称',
  `type` varchar(20) DEFAULT '' COMMENT '告警规则类型【server】【desktop】【fsd】',
  `able` varchar(20) DEFAULT '' COMMENT '告警接收端可用性【enable】【disable】',
  `target` varchar(100) DEFAULT '' COMMENT '告警规则目标',
  `formula` text DEFAULT '' COMMENT '告警规则公式',
  `sort` int(10) DEFAULT NULL COMMENT '排序',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `createpin` varchar(100) DEFAULT '' COMMENT '创建人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `updatepin` varchar(100) DEFAULT '' COMMENT '修改人',
  `yn` tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='告警规则';

-- ----------------------------
--  Records of `mon_alarm_rule`
-- ----------------------------
BEGIN;
INSERT INTO `mon_alarm_rule` VALUES ('08bc8179-902f-4760-9d2a-a954f4055a86', 'fsd_auth', 'fsd', 'disable', 'fsd_auth', '{\"extra\":\"30\"}', '15', '2022-04-09 16:17:23', '00008ed4-0441-4373-8d6f-57188fb52bc1', null, '', '1'), ('1ad9d725-9fa7-42e5-b7fb-4d55f4a76e9a', 'server_offline', 'server', 'disable', 'server_offline', '{}', '7', '2022-04-09 16:17:23', '00008ed4-0441-4373-8d6f-57188fb52bc1', null, '', '1'), ('20624eee-ffe4-4584-b2fa-9527edaf6ad7', 'server_cpu_temperature', 'server', 'disable', 'server_cpu_temperature', '{\"period\":\"10m\"}', '4', '2022-04-09 16:17:23', '00008ed4-0441-4373-8d6f-57188fb52bc1', null, '', '1'), ('222f9cae-d894-44a8-a84b-f4112de872cf', 'server_storage_exception', 'server', 'disable', 'server_storage_exception', '{}', '12', '2022-04-09 16:17:23', '00008ed4-0441-4373-8d6f-57188fb52bc1', null, '', '1'), ('280866ca-e54a-4bf8-95bb-7444150e38e3', 'server_network_card_exception', 'server', 'disable', 'server_network_card_exception', '{\"period\":\"10m\"}', '5', '2022-04-09 16:17:23', '00008ed4-0441-4373-8d6f-57188fb52bc1', null, '', '1'), ('3074701c-2714-4279-b7e0-6633e5e41e0c', 'server_port_offline', 'server', 'disable', 'server_port_offline', '{}', '8', '2022-04-09 16:17:23', '00008ed4-0441-4373-8d6f-57188fb52bc1', null, '', '1'), ('4508fb87-cdc4-411f-981b-c1f3f558f1e0', 'desktop_memory_use', 'desktop', 'disable', 'desktop_memory_use', '{\"extra\":\"00001e4f-0520-427a-866b-93ceb112144b\",\"operator\":\">\",\"percent\":90,\"period\":\"10m\"}', '14', '2022-04-09 16:17:23', '00008ed4-0441-4373-8d6f-57188fb52bc1', null, '', '1'), ('5c7b7f36-bba0-4785-b05e-8c839b80d570', 'fsd_password', 'fsd', 'disable', 'fsd_password', '{}', '17', '2022-04-09 16:17:23', '00008ed4-0441-4373-8d6f-57188fb52bc1', null, '', '1'), ('632b9484-5b86-450c-b032-a92db459b565', 'server_cpu_use', 'server', 'disable', 'server_cpu_use', '{\"operator\":\">\",\"percent\":90,\"period\":\"10m\"}', '1', '2022-04-09 16:17:23', '00008ed4-0441-4373-8d6f-57188fb52bc1', null, '', '1'), ('929ff8c0-6ab7-4d06-b271-2beeafb4430c', 'server_storage_io_busy', 'server', 'disable', 'server_storage_io_busy', '{\"period\":\"10m\"}', '9', '2022-04-09 16:17:23', '00008ed4-0441-4373-8d6f-57188fb52bc1', null, '', '1'), ('93dfef3f-41e1-441d-8d29-495fc6bacf67', 'fsd_client_breake', 'fsd', 'disable', 'fsd_client_breake', '{}', '18', '2022-04-09 16:17:23', '00008ed4-0441-4373-8d6f-57188fb52bc1', null, '', '1'), ('9b107416-e57e-4c38-8449-b7665f3690d6', 'server_swap_use', 'server', 'disable', 'server_swap_use', '{\"operator\":\">\",\"percent\":10,\"period\":\"10m\"}', '3', '2022-04-09 16:17:23', '00008ed4-0441-4373-8d6f-57188fb52bc1', null, '', '1'), ('9f627fdd-00f3-4861-947d-0262cedaa6fb', 'fsd_login', 'fsd', 'disable', 'fsd_login', '{}', '16', '2022-04-09 16:17:23', '00008ed4-0441-4373-8d6f-57188fb52bc1', null, '', '1'), ('beb65374-df01-4d9b-b60e-3744b37f2515', 'desktop_cpu_use', 'desktop', 'disable', 'desktop_cpu_use', '{\"extra\":\"00001e4f-0520-427a-866b-93ceb112144b\",\"operator\":\">\",\"percent\":90,\"period\":\"10m\"}', '13', '2022-04-09 16:17:23', '00008ed4-0441-4373-8d6f-57188fb52bc1', null, '', '1'), ('cdf12059-759e-40bb-b34f-4f67f205ef22', 'server_storage_io_delay', 'server', 'disable', 'server_storage_io_delay', '{\"period\":\"10m\"}', '10', '2022-04-09 16:17:23', '00008ed4-0441-4373-8d6f-57188fb52bc1', null, '', '1'), ('dedba942-ec2f-486a-ba51-f31f7d476e08', 'server_storage_use', 'server', 'disable', 'server_storage_use', '{\"operator\":\">\",\"percent\":90}', '11', '2022-04-09 16:17:23', '00008ed4-0441-4373-8d6f-57188fb52bc1', null, '', '1'), ('f7051fc5-ac29-4fe6-ba7a-6a0ffde59daf', 'server_raid_exception', 'server', 'disable', 'server_raid_exception', '{}', '6', '2022-04-09 16:17:23', '00008ed4-0441-4373-8d6f-57188fb52bc1', null, '', '1'), ('ffb650dd-5650-4708-ad0f-92bd07c8d51b', 'server_memory_use', 'server', 'disable', 'server_memory_use', '{\"operator\":\">\",\"percent\":90,\"period\":\"10m\"}', '2', '2022-04-09 16:17:23', '00008ed4-0441-4373-8d6f-57188fb52bc1', null, '', '1');
COMMIT;

-- ----------------------------
--  Table structure for `sys_log_client`
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_client`;
CREATE TABLE `sys_log_client` (
  `uuid` varchar(50) NOT NULL DEFAULT '' COMMENT '客户机日志UUID',
  `user_account` varchar(50) DEFAULT '' COMMENT '用户名',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户姓名',
  `client` varchar(30) DEFAULT '' COMMENT '客户端mac',
  `module` varchar(50) DEFAULT '' COMMENT '操作模块',
  `action` varchar(50) DEFAULT '' COMMENT '执行动作',
  `target` varchar(50) DEFAULT '' COMMENT '执行动作目标',
  `target_uuid` varchar(50) DEFAULT '' COMMENT '操作对象UUID',
  `target_name` varchar(100) DEFAULT '' COMMENT '操作对象名称',
  `status` varchar(10) DEFAULT '' COMMENT '状态【success】【pending】【fail】',
  `desktop_type` varchar(10) DEFAULT '' COMMENT '桌面类型【voi】【vdi】',
  `message` text DEFAULT '' COMMENT '错误信息',
  `messageExtra` text DEFAULT '' COMMENT '错误信息附加参数',
  `ip` varchar(20) DEFAULT '' COMMENT '客户端访问IP',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `createpin` varchar(100) DEFAULT '' COMMENT '创建人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `updatepin` varchar(100) DEFAULT '' COMMENT '修改人',
  `yn` tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='客户机日志';

-- ----------------------------
--  Table structure for `sys_log_operation`
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_operation`;
CREATE TABLE `sys_log_operation` (
  `uuid` varchar(50) NOT NULL DEFAULT '' COMMENT '操作日志UUID',
  `user_account` varchar(50) DEFAULT '' COMMENT '用户名',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户姓名',
  `module` varchar(50) DEFAULT '' COMMENT '操作模块',
  `action` varchar(50) DEFAULT '' COMMENT '执行动作',
  `target` varchar(50) DEFAULT '' COMMENT '执行动作目标',
  `target_uuid` varchar(50) DEFAULT '' COMMENT '操作对象UUID',
  `target_name` varchar(100) DEFAULT '' COMMENT '操作对象名称',
  `status` varchar(10) DEFAULT '' COMMENT '状态【success】【pending】【fail】',
  `message` text DEFAULT '' COMMENT '错误信息',
  `messageExtra` text DEFAULT '' COMMENT '错误信息附加参数',
  `ip` varchar(20) DEFAULT '' COMMENT '客户端访问IP',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `createpin` varchar(100) DEFAULT '' COMMENT '创建人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `updatepin` varchar(100) DEFAULT '' COMMENT '修改人',
  `yn` tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统操作日志';

-- ----------------------------
--  Table structure for `sys_log_system`
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_system`;
CREATE TABLE `sys_log_system` (
  `uuid` varchar(50) NOT NULL DEFAULT '' COMMENT '系统日志UUID',
  `user_account` varchar(50) DEFAULT '' COMMENT '用户名',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户姓名',
  `module` varchar(50) DEFAULT '' COMMENT '操作模块',
  `action` varchar(50) DEFAULT '' COMMENT '执行动作',
  `target` varchar(50) DEFAULT '' COMMENT '执行动作目标',
  `target_uuid` varchar(50) DEFAULT '' COMMENT '操作对象UUID',
  `target_name` varchar(100) DEFAULT '' COMMENT '操作对象名称',
  `status` varchar(10) DEFAULT '' COMMENT '状态【success】【pending】【fail】',
  `message` text DEFAULT '' COMMENT '错误信息',
  `messageExtra` text DEFAULT '' COMMENT '错误信息附加参数',
  `ip` varchar(20) DEFAULT '' COMMENT '客户端访问IP',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `createpin` varchar(100) DEFAULT '' COMMENT '创建人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `updatepin` varchar(100) DEFAULT '' COMMENT '修改人',
  `yn` tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统日志';

SET FOREIGN_KEY_CHECKS = 1;
