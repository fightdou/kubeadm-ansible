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
-- Table structure for sys_user_group
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_group`;
CREATE TABLE `sys_user_group` (
  `uuid` varchar(50) NOT NULL COMMENT '主键UUID',
  `parent_uuid` varchar(50) DEFAULT NULL COMMENT '父用户组UUID',
  `strategy_info` text DEFAULT NULL COMMENT '策略数据',
  `belong_group` varchar(2000) DEFAULT '' COMMENT '所属用户组（所有上层用户组名称通过/拼接）',
  `index` varchar(2000) DEFAULT NULL COMMENT '组索引',
  `name` varchar(50) DEFAULT NULL COMMENT '用户组名称',
  `description` varchar(200) DEFAULT NULL COMMENT '描述',
  `extend` tinyint(1) DEFAULT 1 COMMENT '子组是否继承：1 是 0 否',
  `lock` tinyint(1) DEFAULT 0 COMMENT '是否锁定 ： 1是 0否',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `createpin` varchar(100) DEFAULT NULL COMMENT '创建人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `updatepin` varchar(100) DEFAULT NULL COMMENT '修改人',
  `yn` tinyint(2) DEFAULT NULL COMMENT '删除状态：1正常，0删除',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户组';
INSERT INTO `sys_user_group` VALUES ('00001e4f-0520-427a-866b-93ceb112144b', null, '{"description":1,"disconnect":1,"email":1,"invalid":1,"logout":1,"notEnteredTime":5,"notEnteredUnit":"m","notOperatedTime":5,"notOperatedUnit":"m","phone":1,"recordLog":1,"unusedTime":30,"userEdit":1,"userName":1,"visit":1,"visitPeriod":"[[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]]"}', null, '1', 'default', null, '1', '0', now(), null, null, null, '1');


-- ----------------------------
-- Table structure for sys_license
-- ----------------------------
DROP TABLE IF EXISTS `sys_license`;
CREATE TABLE `sys_license` (
  `uuid` varchar(50) NOT NULL,
  `status` char(12) DEFAULT '' COMMENT '状态 effective:生效中 unEffective:已失效  unauthorized:未授权',
  `code` text DEFAULT NULL COMMENT '授权码',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `createpin` varchar(100) DEFAULT NULL COMMENT '创建人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `updatepin` varchar(100) DEFAULT NULL COMMENT '修改人',
  `yn` tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='授权表';

-- ----------------------------
-- Table structure for des_snapshot
-- ----------------------------
DROP TABLE IF EXISTS `des_snapshot`;
CREATE TABLE `des_snapshot` (
  `uuid` varchar(50) NOT NULL,
  `desktop_uuid` varchar(50) DEFAULT '' COMMENT '所属虚拟机',
  `group_uuid` varchar(50) DEFAULT '' COMMENT '桌面组',
  `name` varchar(60) DEFAULT NULL COMMENT '名称',
  `visible` int(11) DEFAULT 1 COMMENT '可见性 0:不可见\n(初始化快照) 1:可见',
  `type` varchar(20) DEFAULT NULL COMMENT '快照：snapshot  快照组：snapshot_group',
  `init_flag` tinyint(4) DEFAULT 1 COMMENT '初始化快照（1：是  0 ：否）',
  `status` varchar(30) DEFAULT '' COMMENT '状态',
  `size` int(11) DEFAULT 0 COMMENT '备份文件大小(GB)',
  `description` varchar(200) DEFAULT NULL,
  `restore_point` tinyint(4) DEFAULT 0 COMMENT '是否为最新的还原点（0否  1是）',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `createpin` varchar(100) DEFAULT NULL COMMENT '创建人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `updatepin` varchar(100) DEFAULT NULL COMMENT '修改人',
  `yn` tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='快照表';

-- ----------------------------
-- Table structure for des_desktop
-- ----------------------------
DROP TABLE IF EXISTS `des_desktop`;
CREATE TABLE `des_desktop` (
  `uuid` varchar(50) NOT NULL COMMENT 'uuid',
  `name` varchar(60) NOT NULL COMMENT '云桌面名称',
  `type` varchar(10) DEFAULT NULL COMMENT '机器类型 template：代表模板机，desktop：代表云桌面',
  `desktop_type` char(3) NOT NULL COMMENT '桌面类型 VDI  VOI',
  `group_uuid` varchar(50) DEFAULT NULL COMMENT '桌面组',
  `mode` varchar(10) DEFAULT NULL COMMENT '桌面模式 exclusive：专属 share ：共享  single ：单用户 multi ：多用户',
  `recovery_mode` tinyint(2) DEFAULT NULL COMMENT '还原模式 0:非还原模式 1：还原模式',
  `recovery_type` varchar(50) DEFAULT '' COMMENT '还原类型  systemDisk-系统盘，dataDisk-数据盘，shareDisk-共享盘',
  `exclusive_mode` tinyint(2) DEFAULT NULL COMMENT '独占模式  0:非独占模式 1：独占模式',
  `description` varchar(200) DEFAULT NULL COMMENT '描述',
  `os` varchar(10) NOT NULL DEFAULT '' COMMENT '操作系统 image：镜像，template：模板机，ISO:ISO',
  `template_uuid` varchar(50) DEFAULT NULL COMMENT '模板机uuid',
  `snapshot_uuid` varchar(50) DEFAULT NULL COMMENT '快照uuid',
  `image_uuid` varchar(50) DEFAULT NULL COMMENT '镜像uuid',
  `iso_uuid` varchar(50) DEFAULT '' COMMENT 'iso  UUID',
  `platform` varchar(10) DEFAULT NULL COMMENT '平台(win7,win10)',
  `cpu` int(11) DEFAULT 0 COMMENT 'CPU数量',
  `memory` int(11) DEFAULT 0 COMMENT '内存 (GB)',
  `system_disk` int(11) DEFAULT 0 COMMENT '系统盘 (GB)',
  `ip` varchar(20) DEFAULT NULL COMMENT '桌面ip',
  `mac` varchar(100) DEFAULT NULL COMMENT 'MAC地址',
  `network_uuid` varchar(50) DEFAULT NULL COMMENT '网络uuid',
  `host_uuid` varchar(50) DEFAULT NULL COMMENT '所属服务器uuid',
  `status` varchar(30) DEFAULT '' COMMENT '桌面状态 stopped:已关机  active:运行中 error:失败 deleted:已删除',
  `mount_disk` tinyint(2) DEFAULT NULL COMMENT '挂载数据盘 1：挂载 0 不挂载	',
  `last_boot_time` datetime DEFAULT NULL COMMENT '最近开机时间',
  `last_shutdown_time` datetime DEFAULT NULL COMMENT '最近关机时间',
  `recovery_time` datetime DEFAULT NULL COMMENT '进入回收站时间',
  `current_access_user_name` varchar(50) DEFAULT '' COMMENT '当前接入用户（当桌面事还原模式的时候，挂当前接入用户）',
  `current_access_user_uuid` varchar(50) DEFAULT NULL COMMENT '当前接入用户uuid',
  `strategy_info` text DEFAULT NULL COMMENT '策略数据',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  `resource_pool_uuid` varchar(50) DEFAULT NULL COMMENT '资源池uuid',
  `disconnect_status` varchar(20) DEFAULT '' COMMENT '断开状态（disconnect：断开 connect：未断开 error: 异常断开）',
  `connection_time` datetime DEFAULT NULL COMMENT '连接时间',
  `disconnect_time` datetime DEFAULT NULL COMMENT '断开时间',
  `last_connected_user_uuid` varchar(50) DEFAULT NULL COMMENT '上一次连接人（超过1小时还原）',
  `client_voi_uuid` varchar(50) DEFAULT '' COMMENT 'voi客户机uuid',
  `update_flag` tinyint(4) DEFAULT NULL COMMENT '编辑模式是否开启 0否1是',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `createpin` varchar(100) DEFAULT NULL COMMENT '创建人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `updatepin` varchar(100) DEFAULT NULL COMMENT '修改人',
  `yn` tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
  PRIMARY KEY (`uuid`),
  KEY `idx_resource_pool_uuid` (`resource_pool_uuid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='云桌面和模板机表（虚拟机表）';


-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission` (
  `uuid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键uuid',
  `parent_uuid` int(11) DEFAULT NULL COMMENT '父主键uuid',
  `name` varchar(255) DEFAULT NULL COMMENT '权限名称',
  `code` varchar(60) DEFAULT NULL COMMENT '权限code',
  `visible` tinyint(2) DEFAULT NULL COMMENT '显示状态（1显示 0隐藏）',
  `sort` int(11) DEFAULT 0 COMMENT '排序',
  `description` varchar(255) DEFAULT NULL COMMENT '权限描述',
  `type` char(4) DEFAULT NULL COMMENT '权限类型（menu目录 func按钮）',
  `icon` varchar(32) DEFAULT NULL COMMENT '图标',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `createpin` varchar(100) DEFAULT NULL COMMENT '创建人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `updatepin` varchar(255) DEFAULT NULL COMMENT '修改人',
  `yn` tinyint(2) DEFAULT NULL COMMENT '删除状态：1正常，0删除',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=463 DEFAULT CHARSET=utf8mb4 COMMENT='权限表';

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES ('1', '0', '系统配置', 'system:config', '1', '1', null, 'func', '', '2022-02-21 08:39:51', '23df86ad-a812-4575-8e7c-6998d64438b1', '2022-03-05 00:42:56', '10447693-cdce-46e9-8a59-47600b9c9eb2', '1');
INSERT INTO `sys_permission` VALUES ('2', '1', '用户组', 'system:userGroup', '1', '1', null, 'func', '', '2022-02-21 08:42:33', '23df86ad-a812-4575-8e7c-6998d64438b1', null, null, '1');
INSERT INTO `sys_permission` VALUES ('3', '2', '创建用户组', 'system:userGroup:create', '1', '1', null, 'func', '', '2022-02-21 08:43:25', '23df86ad-a812-4575-8e7c-6998d64438b1', '2022-03-05 00:43:05', null, '1');
INSERT INTO `sys_permission` VALUES ('4', '2', '编辑用户组', 'system:userGroup:update', '1', '4', null, 'func', '', '2022-02-21 08:43:44', '23df86ad-a812-4575-8e7c-6998d64438b1', '2022-02-24 17:25:00', null, '1');
INSERT INTO `sys_permission` VALUES ('5', '2', '删除用户组', 'system:userGroup:delete', '1', '3', null, 'func', '', '2022-02-21 08:44:05', '23df86ad-a812-4575-8e7c-6998d64438b1', null, null, '1');
INSERT INTO `sys_permission` VALUES ('6', '2', '查询用户组', 'system:userGroup:get', '1', '2', null, 'func', '', '2022-02-21 08:44:28', '23df86ad-a812-4575-8e7c-6998d64438b1', '2022-04-28 15:07:25', null, '1');
INSERT INTO `sys_permission` VALUES ('7', '2', '移动用户组', 'system:userGroup:move', '1', '5', null, 'func', '', '2022-02-21 08:44:46', '23df86ad-a812-4575-8e7c-6998d64438b1', null, null, '1');
INSERT INTO `sys_permission` VALUES ('46', '0', '桌面', 'Desktop', '1', '2', '', 'menu', null, '2022-02-24 14:09:20', 'b3668cc8-afe7-4a14-9794-b280b81b0add', '2022-04-28 11:17:32', '06e38ed4-0441-4373-8d6f-57188fb52bc8', '0');
INSERT INTO `sys_permission` VALUES ('47', '0', '客户机', 'Client', '1', '3', '', 'menu', null, '2022-02-24 14:09:30', 'b3668cc8-afe7-4a14-9794-b280b81b0add', '2022-04-28 10:11:28', '06e38ed4-0441-4373-8d6f-57188fb52bc8', '0');
INSERT INTO `sys_permission` VALUES ('48', '0', '系统配置', 'SystemConfig', '1', '4', '', 'menu', null, '2022-02-24 14:09:40', 'b3668cc8-afe7-4a14-9794-b280b81b0add', '2022-04-13 09:58:53', '06e38ed4-0441-4373-8d6f-57188fb52bc8', '1');
INSERT INTO `sys_permission` VALUES ('49', '48', '用户组', 'SystemUserGroup', '1', '1', '', 'menu', null, '2022-02-24 14:10:00', 'b3668cc8-afe7-4a14-9794-b280b81b0add', '2022-02-24 16:06:47', null, '1');
INSERT INTO `sys_permission` VALUES ('51', '48', '策略管理', 'SystemStrategic', '1', '6', '', 'menu', null, '2022-02-24 15:20:38', '06e38ed4-0441-4373-8d6f-57188fb52bc8', '2022-03-08 10:04:54', null, '1');
INSERT INTO `sys_permission` VALUES ('52', '48', '全局设置', 'SystemGlobal', '1', '8', '', 'menu', null, '2022-02-24 15:20:56', '06e38ed4-0441-4373-8d6f-57188fb52bc8', '2022-04-08 09:27:35', null, '1');
INSERT INTO `sys_permission` VALUES ('53', '48', '日志管理', 'SystemLog', '1', '9', '', 'menu', null, '2022-02-24 15:21:11', '06e38ed4-0441-4373-8d6f-57188fb52bc8', '2022-04-08 09:27:26', null, '1');
INSERT INTO `sys_permission` VALUES ('57', '0', '工作台', 'Workbench', '1', '1', '', 'menu', null, '2022-02-24 15:58:30', '06e38ed4-0441-4373-8d6f-57188fb52bc8', '2022-04-06 13:55:37', null, '1');
INSERT INTO `sys_permission` VALUES ('61', '1', '用户', 'system:user', '1', '1', '', 'func', null, '2022-02-24 16:13:27', null, '2022-02-24 16:14:29', null, '1');
INSERT INTO `sys_permission` VALUES ('62', '61', '创建用户', 'system:user:create', '1', '3', '', 'func', null, '2022-02-24 16:18:17', null, '2022-04-28 15:15:28', null, '1');
INSERT INTO `sys_permission` VALUES ('63', '61', '编辑用户', 'system:user:update', '1', '5', '', 'func', null, '2022-02-24 16:19:06', null, '2022-04-28 15:15:38', null, '1');
INSERT INTO `sys_permission` VALUES ('64', '61', '删除用户', 'system:user:delete', '1', '7', '', 'func', null, '2022-02-24 16:19:40', null, '2022-04-28 15:15:46', null, '1');
INSERT INTO `sys_permission` VALUES ('65', '61', '获取用户信息', 'system:user:get', '1', '9', '', 'func', null, '2022-02-24 16:20:24', null, '2022-04-28 15:15:53', null, '1');
INSERT INTO `sys_permission` VALUES ('66', '61', '重置密码', 'system:user:resetPwd', '1', '11', '', 'func', null, '2022-02-24 16:20:58', null, '2022-04-28 15:16:02', null, '1');
INSERT INTO `sys_permission` VALUES ('67', '61', '启用用户', 'system:user:enableUser', '1', '13', '', 'func', null, '2022-02-24 16:21:28', null, '2022-04-28 15:16:08', null, '1');
INSERT INTO `sys_permission` VALUES ('68', '61', '禁用用户', 'system:user:disableUser', '1', '15', '', 'func', null, '2022-02-24 16:22:05', null, '2022-04-28 15:16:14', null, '1');
INSERT INTO `sys_permission` VALUES ('69', '61', '更换角色', 'system:user:updateRole', '1', '17', '', 'func', null, '2022-02-24 16:24:35', null, '2022-04-28 15:16:20', null, '1');
INSERT INTO `sys_permission` VALUES ('70', '61', '获取用户策略', 'system:user:get:strategy', '1', '19', '', 'func', null, '2022-02-24 16:25:07', null, '2022-04-28 15:16:29', null, '1');
INSERT INTO `sys_permission` VALUES ('71', '57', '首页', 'WorkbenchOverView', '1', '1', '', 'menu', null, '2022-02-24 16:25:23', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('72', '61', '修改用户策略', 'system:user:update:strategy', '1', '21', '', 'func', null, '2022-02-24 16:25:38', null, '2022-04-28 15:16:37', null, '1');
INSERT INTO `sys_permission` VALUES ('73', '61', '同步用户策略', 'system:user:sync:strategy', '1', '25', '', 'func', null, '2022-02-24 16:26:24', null, '2022-04-28 15:16:47', null, '1');
INSERT INTO `sys_permission` VALUES ('74', '46', '云桌面', 'DesktopVirtual', '1', '1', '云桌面', 'menu', null, '2022-02-24 16:29:44', null, '2022-04-28 11:17:32', null, '0');
INSERT INTO `sys_permission` VALUES ('75', '51', '桌面策略', 'SystemStrategicDesktop', '1', '1', '桌面策略', 'menu', null, '2022-02-24 16:33:49', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('76', '51', '用户策略', 'SystemStrategicUsers', '1', '2', '用户策略', 'menu', null, '2022-02-24 16:34:09', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('77', '51', '客户机策略', 'SystemStrategiClient', '1', '3', '', 'menu', null, '2022-02-24 16:34:23', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('78', '53', '操作日志', 'SystemLogOperation', '1', '1', '操作日志', 'menu', null, '2022-02-24 16:38:18', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('79', '1', '角色权限', 'system:role', '1', '40', '', 'func', null, '2022-02-25 10:25:39', null, '2022-03-03 10:53:35', null, '1');
INSERT INTO `sys_permission` VALUES ('80', '79', '查看角色列表', 'system:role:page', '1', '1', '', 'func', null, '2022-02-25 10:31:56', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('81', '79', '查询角色详情', 'system:role:detail', '1', '2', '', 'func', null, '2022-02-25 10:32:36', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('82', '79', '创建角色', 'system:role:create', '1', '3', '', 'func', null, '2022-02-25 10:33:10', null, '2022-03-09 10:34:37', null, '1');
INSERT INTO `sys_permission` VALUES ('83', '79', '编辑角色', 'system:role:update', '1', '4', '', 'func', null, '2022-02-25 10:33:52', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('84', '79', '复制角色', 'system:role:clone', '1', '5', '', 'func', null, '2022-02-25 10:34:37', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('85', '79', '启用/禁用角色', 'system:role:operation', '1', '6', '', 'func', null, '2022-02-25 10:35:19', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('86', '79', '删除角色', 'system:role:delete', '1', '7', '', 'func', null, '2022-02-25 10:35:55', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('87', '79', '查询角色功能授权', 'system:role:permission', '1', '8', '', 'func', null, '2022-02-25 10:36:55', null, '2022-03-03 10:20:04', null, '1');
INSERT INTO `sys_permission` VALUES ('88', '79', '编辑角色功能授权', 'system:role:permission:update', '1', '9', '', 'func', null, '2022-02-25 10:37:59', null, '2022-03-03 10:20:21', null, '1');
INSERT INTO `sys_permission` VALUES ('89', '1', '全局设置', 'system:global', '1', '7', '', 'func', null, '2022-02-25 10:39:55', null, '2022-02-25 10:45:10', null, '1');
INSERT INTO `sys_permission` VALUES ('90', '1', '策略管理', 'system:policy', '1', '6', '', 'func', null, '2022-02-25 10:45:05', null, '2022-02-25 10:48:30', null, '1');
INSERT INTO `sys_permission` VALUES ('91', '1', '安全认证', 'system:safetyCertification', '1', '41', '', 'func', null, '2022-02-25 10:46:13', null, '2022-03-22 08:08:06', null, '1');
INSERT INTO `sys_permission` VALUES ('92', '90', '查询用户策略', 'system:userPolicy:detail', '1', '1', '', 'func', null, '2022-02-25 10:47:23', null, '2022-03-22 09:08:17', null, '1');
INSERT INTO `sys_permission` VALUES ('93', '90', '编辑用户策略', 'system:userPolicy:update', '1', '2', '', 'func', null, '2022-02-25 10:48:19', null, '2022-03-22 08:52:08', null, '1');
INSERT INTO `sys_permission` VALUES ('94', '90', '同步用户策略', 'system:userPolicy:synchronize', '1', '3', '', 'func', null, '2022-02-25 10:50:44', null, '2022-03-22 08:51:49', null, '1');
INSERT INTO `sys_permission` VALUES ('95', '91', '查询安全认证信息', 'system:safetyCertification:detail', '1', '1', '', 'func', null, '2022-02-25 10:52:39', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('96', '91', '查询密码策略信息', 'system:safetyCertification:password', '1', '3', '', 'func', null, '2022-02-25 10:53:11', null, '2022-04-14 11:23:41', null, '0');
INSERT INTO `sys_permission` VALUES ('97', '91', '编辑安全认证信息', 'system:safetyCertification:update', '1', '2', '', 'func', null, '2022-02-25 10:53:37', null, '2022-02-25 10:53:59', null, '1');
INSERT INTO `sys_permission` VALUES ('98', '52', '角色权限', 'SystemGlobalRole', '1', '1', '', 'menu', null, '2022-02-25 10:56:08', null, '2022-04-27 15:15:58', null, '1');
INSERT INTO `sys_permission` VALUES ('99', '52', '安全认证', 'SystemSafetyCertification', '1', '2', '', 'menu', null, '2022-02-25 10:56:44', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('100', '2', '下载用户信息导入模板', 'system:user:downloadTemplate', '1', '12', '', 'func', null, '2022-02-25 11:03:32', null, '2022-02-25 11:10:52', null, '1');
INSERT INTO `sys_permission` VALUES ('101', '2', '批量上传用户', 'system:user:uploadTemplate', '1', '13', '', 'func', null, '2022-02-25 11:04:02', null, '2022-02-25 11:10:07', null, '1');
INSERT INTO `sys_permission` VALUES ('102', '2', '下载错误报告', 'system:user:downloadErrorReport', '1', '14', '', 'func', null, '2022-02-25 11:04:29', null, '2022-02-25 11:10:01', null, '1');
INSERT INTO `sys_permission` VALUES ('103', '2', '导出用户信息', 'system:userGroup:exportByUserGroup', '1', '6', '根据用户组uuid集合导出用户信息', 'func', null, '2022-02-25 11:06:26', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('104', '2', '导出用户详情', 'system:user:exportByUser', '1', '15', '根据用户Uuid导出用户信息', 'func', null, '2022-02-25 11:07:33', null, '2022-02-25 11:09:56', null, '1');
INSERT INTO `sys_permission` VALUES ('105', '1', '日志管理', 'system:log:operation', '1', '60', '', 'func', null, '2022-02-25 17:49:36', null, '2022-03-03 10:54:50', null, '1');
INSERT INTO `sys_permission` VALUES ('106', '105', '日志导出', 'system:log:operation:export', '1', '1', '', 'func', null, '2022-02-25 17:50:15', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('107', '105', '日志列表', 'system:log:operation:page', '1', '2', '', 'func', null, '2022-02-25 17:53:00', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('108', '79', '查询全部功能授权', 'system:role:permissionAll', '1', '10', '', 'func', null, '2022-03-03 10:19:46', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('109', '1', '资源池', 'des:resourcepool', '1', '2', '', 'func', null, '2022-03-07 13:01:17', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('110', '109', '创建资源池', 'des:resourcepool:create', '1', '10', '', 'func', null, '2022-03-07 13:02:16', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('111', '109', '查询资源池列表', 'des:resourcepool:list', '1', '20', '', 'func', null, '2022-03-07 13:03:12', null, '2022-04-28 13:40:26', null, '1');
INSERT INTO `sys_permission` VALUES ('112', '109', '查询资源池详情', 'des:resourcepool:detail', '1', '30', '', 'func', null, '2022-03-07 13:03:38', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('113', '109', '删除资源池', 'des:resourcepool:delete', '1', '40', '', 'func', null, '2022-03-07 13:04:13', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('114', '109', '用户关联资源池', 'des:resourcepool:associateduser', '1', '50', '', 'func', null, '2022-03-07 13:04:54', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('115', '48', '资源池', 'SystemResourcesPool', '1', '2', '', 'menu', null, '2022-03-07 13:05:17', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('116', '48', '桌面规格', 'SystemSpecification', '1', '5', '', 'menu', null, '2022-03-07 13:07:20', null, '2022-03-08 10:05:39', null, '1');
INSERT INTO `sys_permission` VALUES ('117', '109', '查询资源池关联用户信息', 'des:resourcepool:userinfo', '1', '35', '', 'func', null, '2022-03-07 13:56:59', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('118', '116', ' 桌面规格', 'SystemSpecificationDesktop', '1', '1', '', 'menu', null, '2022-03-08 09:47:00', null, '2022-03-08 09:58:05', null, '1');
INSERT INTO `sys_permission` VALUES ('119', '48', '镜像', 'SystemImage', '1', '3', '', 'menu', null, '2022-03-08 10:02:53', null, '2022-04-26 11:26:09', null, '1');
INSERT INTO `sys_permission` VALUES ('120', '48', '网络', 'SystemNetwork', '1', '4', '', 'menu', null, '2022-03-08 10:03:21', null, '2022-03-21 15:29:36', null, '1');
INSERT INTO `sys_permission` VALUES ('121', '46', '模板机', 'DesktopTemplate', '0', '2', '', 'menu', null, '2022-03-08 10:17:27', null, '2022-04-28 11:17:32', null, '0');
INSERT INTO `sys_permission` VALUES ('122', '46', '数据盘', 'DesktopDataDisk', '1', '3', '', 'menu', null, '2022-03-08 10:17:44', null, '2022-04-28 11:17:32', null, '0');
INSERT INTO `sys_permission` VALUES ('123', '46', '回收站', 'DesktopRecycle', '1', '4', '', 'menu', null, '2022-03-08 10:18:19', null, '2022-04-28 11:17:32', null, '0');
INSERT INTO `sys_permission` VALUES ('124', '1', '资源池模式', 'system:resourcePool', '1', '39', '', 'func', null, '2022-03-10 13:34:16', null, '2022-03-22 08:07:45', null, '1');
INSERT INTO `sys_permission` VALUES ('125', '124', '查询资源池模式', 'system:resourcePoolMode:detail', '1', '1', '', 'func', null, '2022-03-10 13:35:37', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('126', '124', '切换资源池模式', 'system:resourcePoolMode:update', '1', '2', '', 'func', null, '2022-03-10 13:36:26', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('127', '48', '网络详情', 'SystemNetworkSubnet', '1', '4', '', 'menu', null, '2022-03-10 14:39:26', null, '2022-03-21 15:29:49', null, '1');
INSERT INTO `sys_permission` VALUES ('128', '109', '查询当前用户资源池列表', 'des:resourcepool:manage', '1', '25', '桌面/组页面使用', 'func', null, '2022-03-10 16:12:29', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('129', '116', '物理GPU规格', 'SystemSpecificationPhysics', '1', '2', '', 'menu', null, '2022-03-11 15:31:38', null, '2022-04-28 13:34:14', null, '0');
INSERT INTO `sys_permission` VALUES ('130', '116', 'vGPU规格', 'SystemSpecificationVirtualize', '1', '3', '', 'menu', null, '2022-03-11 15:32:11', null, '2022-04-28 13:34:20', null, '0');
INSERT INTO `sys_permission` VALUES ('131', '109', '查询当前可使用资源', 'des:resourcepool:resource', '1', '38', '', 'func', null, '2022-03-11 17:35:22', null, '2022-03-11 17:35:44', null, '1');
INSERT INTO `sys_permission` VALUES ('132', '61', '获取用户信息列表', 'system:user:list', '1', '28', '', 'func', null, '2022-03-11 18:41:09', null, '2022-04-28 15:16:57', null, '1');
INSERT INTO `sys_permission` VALUES ('133', null, '云桌面', 'desktop', '1', '1', '', 'func', null, '2022-03-15 14:42:14', null, '2022-03-23 22:11:20', null, '1');
INSERT INTO `sys_permission` VALUES ('134', '133', '数据盘', 'desktop:volume', '1', '10', '', 'func', null, '2022-03-15 14:42:47', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('135', '134', '查询数据盘列表分页', 'desktop:volume:page', '1', '10', '', 'func', null, '2022-03-15 14:43:26', null, '2022-03-16 16:29:52', null, '1');
INSERT INTO `sys_permission` VALUES ('136', '135', '编辑数据盘', 'desktop:volume:update', '1', '20', '', 'func', null, '2022-03-15 14:44:10', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('137', '134', '编辑数据盘', 'desktop:volume:update', '1', '20', '', 'func', null, '2022-03-15 14:44:44', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('138', '134', '挂载数据盘', 'desktop:volume:attach', '1', '30', '', 'func', null, '2022-03-15 14:45:18', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('139', '134', '卸载数据盘', 'desktop:volume:detach', '1', '40', '', 'func', null, '2022-03-15 14:45:49', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('140', '134', '删除数据盘', 'desktop:volume:delete', '1', '50', '', 'func', null, '2022-03-15 14:46:39', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('141', '133', '云桌面', 'desktop:desktop', '1', '20', '', 'func', null, '2022-03-16 13:37:53', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('142', '141', '云桌面列表', 'desktop:desktop:list', '1', '10', '', 'func', null, '2022-03-16 13:38:57', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('143', '141', '查询云桌面详情', 'desktop:desktop:detail', '1', '20', '', 'func', null, '2022-03-16 13:40:18', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('144', '141', '创建云桌面', 'desktop:desktop:create', '1', '30', '', 'func', null, '2022-03-16 13:41:23', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('145', '141', '修改云桌面', 'desktop:desktop:update', '1', '40', '', 'func', null, '2022-03-16 13:41:43', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('146', '141', '开机云桌面', 'desktop:desktop:start', '1', '50', '', 'func', null, '2022-03-16 13:49:11', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('147', '141', '关机云桌面', 'desktop:desktop:shutdown', '1', '60', '', 'func', null, '2022-03-16 13:49:32', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('148', '141', '软重启云桌面', 'desktop:desktop:softReboot', '1', '70', '', 'func', null, '2022-03-16 13:49:55', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('149', '141', '硬重启云桌面', 'desktop:desktop:reboot', '1', '80', '', 'func', null, '2022-03-16 13:50:16', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('150', '141', '移动云桌面', 'desktop:desktop:move', '1', '90', '', 'func', null, '2022-03-16 13:50:38', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('151', '141', '创建快照', 'desktop:desktop:snapshot', '1', '100', '', 'func', null, '2022-03-16 13:51:04', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('152', '141', '重建云桌面', 'desktop:desktop:rebuild', '1', '110', '', 'func', null, '2022-03-16 13:51:25', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('153', '141', '资源扩容', 'desktop:desktop:resize', '1', '120', '', 'func', null, '2022-03-16 13:51:50', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('154', '141', '热扩容', 'desktop:desktop:liveResize', '1', '130', '', 'func', null, '2022-03-16 13:52:10', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('155', '141', '迁移云桌面', 'desktop:desktop:migrate', '1', '140', '', 'func', null, '2022-03-16 13:52:34', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('156', '141', '克隆云桌面', 'desktop:desktop:clone', '1', '150', '', 'func', null, '2022-03-16 13:53:25', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('157', '141', '关联用户', 'desktop:desktop:user', '1', '160', '', 'func', null, '2022-03-16 13:55:08', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('158', '141', '转为模板机', 'desktop:desktop:template', '1', '170', '', 'func', null, '2022-03-16 13:55:39', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('159', '141', '保存策略', 'desktop:desktop:policy', '1', '180', '', 'func', null, '2022-03-16 13:56:13', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('160', '141', '同步策略', 'desktop:desktop:sync:policy', '1', '190', '', 'func', null, '2022-03-16 13:56:53', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('161', '141', '远程登录', 'desktop:desktop:remote', '1', '200', '', 'func', null, '2022-03-16 13:57:12', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('162', '141', '删除云桌面', 'desktop:desktop:delete', '1', '210', '', 'func', null, '2022-03-16 13:57:39', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('163', '141', '彻底删除云桌面', 'desktop:desktop:delete:forever', '1', '220', '', 'func', null, '2022-03-16 13:58:05', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('164', '134', '扩容数据盘', 'desktop:volume:resize', '1', '60', '', 'func', null, '2022-03-16 16:27:58', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('165', '134', '查询数据盘列表', 'desktop:volume:list', '1', '11', '', 'func', null, '2022-03-16 16:29:28', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('166', '1', '桌面规格', 'desktop:flavor', '1', '70', '', 'func', null, '2022-03-17 14:45:54', null, '2022-03-24 13:11:26', null, '1');
INSERT INTO `sys_permission` VALUES ('167', '166', '桌面规格列表分页', 'desktop:flavor:page', '1', '0', '', 'func', null, '2022-03-17 14:47:39', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('168', '166', '新增桌面规格', 'desktop:flavor:create', '1', '0', '', 'func', null, '2022-03-17 14:48:26', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('169', '166', '修改桌面规格', 'desktop:flavor:update', '1', '0', '', 'func', null, '2022-03-17 14:49:11', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('170', '166', '删除桌面规格', 'desktop:flavor:delete', '1', '0', '', 'func', null, '2022-03-17 14:49:52', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('171', '1', '网络', '', '1', '1', '', 'func', null, '2022-03-21 09:32:28', null, '2022-04-28 16:58:39', null, '1');
INSERT INTO `sys_permission` VALUES ('172', '171', '新增网络', 'desktop:network:network:create', '1', '2', '', 'func', null, '2022-03-21 09:33:35', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('173', '171', '修改网络', 'desktop:network:network:update', '1', '3', '', 'func', null, '2022-03-21 09:33:59', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('174', '171', '删除网络', 'desktop:network:network:delete', '1', '4', '', 'func', null, '2022-03-21 09:34:18', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('175', '171', '子网列表', 'desktop:network:subnet:page', '1', '5', '', 'func', null, '2022-03-21 09:34:39', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('176', '171', '新建子网', 'desktop:network:subnet:create', '1', '6', '', 'func', null, '2022-03-21 09:35:00', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('177', '171', '修改子网', 'desktop:network:subnet:update', '1', '7', '', 'func', null, '2022-03-21 09:35:19', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('178', '171', '修改子网可见性', 'desktop:network:subnet:update:publicity', '1', '8', '', 'func', null, '2022-03-21 09:35:40', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('179', '171', '删除子网', 'desktop:network:subnet:delete', '1', '9', '', 'func', null, '2022-03-21 09:36:01', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('180', '171', '网卡列表', 'desktop:network:card:page', '1', '10', '', 'func', null, '2022-03-21 09:36:20', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('181', '133', '模板机', 'desktop:template', '1', '70', '', 'func', null, '2022-03-21 18:44:06', null, '2022-03-21 18:59:58', null, '1');
INSERT INTO `sys_permission` VALUES ('182', '181', '模板机列表分页', 'desktop:template:page', '1', '10', '', 'func', null, '2022-03-21 18:45:56', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('183', '181', '模板机列表(包括快照)', 'desktop:template:list', '1', '20', '', 'func', null, '2022-03-21 18:46:55', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('184', '181', '模板机列表', 'desktop:template:resourcePool:list', '1', '30', '', 'func', null, '2022-03-21 18:47:43', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('185', '181', '查询模板机详情', 'desktop:template:detail', '1', '40', '', 'func', null, '2022-03-21 18:48:15', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('186', '181', '创建模板机', 'desktop:template:create', '1', '50', '', 'func', null, '2022-03-21 18:48:48', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('187', '181', '编辑模板机', 'desktop:template:update', '1', '60', '', 'func', null, '2022-03-21 18:49:14', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('188', '181', '删除模板机', 'desktop:template:delete', '1', '70', '', 'func', null, '2022-03-21 18:49:39', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('189', '181', '启动模板机', 'desktop:template:start', '1', '80', '', 'func', null, '2022-03-21 18:49:56', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('190', '181', '关机模板机', 'desktop:template:shutdown', '1', '90', '', 'func', null, '2022-03-21 18:50:14', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('191', '181', '软重启模板机', 'desktop:template:softReboot', '1', '100', '', 'func', null, '2022-03-21 18:50:33', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('192', '181', '硬重启模板机', 'desktop:template:reboot', '1', '110', '', 'func', null, '2022-03-21 18:50:52', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('193', '181', '创建快照', 'desktop:template:snapshot', '1', '120', '', 'func', null, '2022-03-21 18:51:19', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('194', '181', '资源扩容', 'desktop:template:resize', '1', '130', '', 'func', null, '2022-03-21 18:52:30', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('195', '181', '热扩容', 'desktop:template:liveResize', '1', '140', '', 'func', null, '2022-03-21 18:52:56', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('196', '181', '迁移模板机', 'desktop:template:migrate', '1', '150', '', 'func', null, '2022-03-21 18:56:54', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('197', '181', '克隆模板机', 'desktop:template:clone', '1', '160', '', 'func', null, '2022-03-21 18:57:18', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('198', '181', '同步云桌面', 'desktop:template:syncDesktop', '1', '170', '', 'func', null, '2022-03-21 18:57:47', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('199', '181', '保存策略', 'desktop:template:update:policy', '1', '180', '', 'func', null, '2022-03-21 18:58:38', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('200', '181', '同步策略', 'desktop:template:sync:policy', '1', '190', '', 'func', null, '2022-03-21 18:59:16', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('201', '181', '远程登录', 'desktop:template:remote', '1', '200', '', 'func', null, '2022-03-21 18:59:38', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('202', '133', '快照', 'desktop:storage:snapshot', '1', '90', '', 'func', null, '2022-03-21 19:02:06', null, '2022-03-21 19:04:21', null, '1');
INSERT INTO `sys_permission` VALUES ('203', '202', '快照列表', 'desktop:storage:snapshot:list', '1', '10', '', 'func', null, '2022-03-21 19:02:33', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('204', '202', '创建快照', 'desktop:storage:snapshot:create', '1', '20', '', 'func', null, '2022-03-21 19:03:07', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('205', '202', '编辑快照', 'desktop:storage:snapshot:update', '1', '30', '', 'func', null, '2022-03-21 19:03:31', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('206', '202', '恢复快照', 'desktop:storage:snapshot:restore', '1', '40', '', 'func', null, '2022-03-21 19:03:53', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('207', '202', '删除快照', 'desktop:storage:snapshot:delete', '1', '50', '', 'func', null, '2022-03-21 19:04:14', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('208', '1', '清理机制', 'system:recycleBin', '1', '35', '', 'func', null, '2022-03-22 08:01:50', null, '2022-03-22 08:07:25', null, '1');
INSERT INTO `sys_permission` VALUES ('209', '208', '查询清理机制', 'system:recycleBin:detail', '1', '1', '', 'func', null, '2022-03-22 08:03:05', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('210', '208', '修改清理机制', 'system:recycleBin:update', '1', '2', '', 'func', null, '2022-03-22 08:03:58', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('211', '133', '桌面组', 'desktop:group', '1', '5', '', 'func', null, '2022-03-22 08:11:40', null, '2022-03-22 08:11:55', null, '1');
INSERT INTO `sys_permission` VALUES ('212', '211', '查询桌面组', 'desktop:group:tree', '1', '1', '', 'func', null, '2022-03-22 08:28:54', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('213', '211', '创建桌面组', 'desktop:group:create', '1', '2', '', 'func', null, '2022-03-22 08:29:32', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('214', '211', '编辑桌面组', 'desktop:group:update', '1', '3', '', 'func', null, '2022-03-22 08:30:11', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('215', '211', '保存桌面组策略', 'desktop:group:update:policy', '1', '6', '', 'func', null, '2022-03-22 08:30:56', null, '2022-04-28 16:11:48', null, '1');
INSERT INTO `sys_permission` VALUES ('216', '211', '同步桌面组策略', 'desktop:group:sync:policy', '1', '7', '', 'func', null, '2022-03-22 08:31:35', null, '2022-04-28 16:11:57', null, '1');
INSERT INTO `sys_permission` VALUES ('217', '211', '开机桌面组', 'desktop:group:startup', '1', '8', '', 'func', null, '2022-03-22 08:32:22', null, '2022-04-28 16:12:03', null, '1');
INSERT INTO `sys_permission` VALUES ('218', '211', '关机桌面组', 'desktop:group:shutdown', '1', '9', '', 'func', null, '2022-03-22 08:33:42', null, '2022-04-28 16:12:09', null, '1');
INSERT INTO `sys_permission` VALUES ('219', '211', '软重启桌面组', 'desktop:group:softReboot', '1', '10', '', 'func', null, '2022-03-22 08:35:38', null, '2022-04-28 16:12:16', null, '1');
INSERT INTO `sys_permission` VALUES ('220', '211', '硬重启桌面组', 'desktop:group:reboot', '1', '11', '', 'func', null, '2022-03-22 08:36:09', null, '2022-04-28 16:12:23', null, '1');
INSERT INTO `sys_permission` VALUES ('221', '211', '删除桌面组', 'desktop:group:delete', '1', '4', '', 'func', null, '2022-03-22 08:37:00', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('222', '133', '回收站', 'desktop:recycle', '1', '95', '', 'func', null, '2022-03-22 08:44:43', null, '2022-03-22 08:49:56', null, '1');
INSERT INTO `sys_permission` VALUES ('223', '222', '查看回收站列表', 'desktop:recycle:page', '1', '1', '', 'func', null, '2022-03-22 08:45:22', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('224', '222', '彻底删除云桌面', 'desktop:recycle:delete', '1', '2', '', 'func', null, '2022-03-22 08:46:27', null, '2022-03-22 08:48:51', null, '1');
INSERT INTO `sys_permission` VALUES ('225', '222', '还原云桌面', 'desktop:recycle:reduce', '1', '3', '', 'func', null, '2022-03-22 08:47:17', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('226', '222', '清空回收站', 'desktop:recycle:empty', '1', '4', '', 'func', null, '2022-03-22 08:48:39', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('227', '90', '查询桌面策略', 'system:desktopPolicy:detail', '1', '4', '', 'func', null, '2022-03-22 09:10:51', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('228', '90', '编辑桌面策略', 'system:desktopPolicy:update', '1', '5', '', 'func', null, '2022-03-22 09:13:57', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('229', '90', '同步桌面策略', 'system:desktopPolicy:synchronize', '1', '6', '', 'func', null, '2022-03-22 09:14:37', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('230', '90', '查询客户机策略', 'system:clientPolicy:detail', '1', '7', '', 'func', null, '2022-03-22 09:17:06', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('231', '90', '编辑客户机策略', 'system:clientPolicy:update', '1', '8', '', 'func', null, '2022-03-22 09:17:30', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('232', '90', '同步客户机策略', 'system:clientPolicy:synchronize', '1', '9', '', 'func', null, '2022-03-22 09:17:51', null, '2022-03-22 09:18:02', null, '1');
INSERT INTO `sys_permission` VALUES ('233', '0', '客户机', 'desktop:cl', '1', '1', '', 'func', null, '2022-03-23 22:11:11', null, '2022-04-08 15:28:13', null, '1');
INSERT INTO `sys_permission` VALUES ('234', '233', '客户机组', 'desktop:clientgroup', '1', '10', '', 'func', null, '2022-03-23 22:12:31', null, '2022-03-23 22:23:58', null, '1');
INSERT INTO `sys_permission` VALUES ('235', '233', '客户机', 'desktop:client', '1', '0', '', 'func', null, '2022-03-23 22:13:06', null, '2022-03-23 22:24:01', null, '1');
INSERT INTO `sys_permission` VALUES ('236', '234', '创建客户机组', 'desktop:clientgroup:create', '1', '10', '', 'func', null, '2022-03-23 22:15:28', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('237', '234', '查询客户机组列表', 'desktop:clientgroup:list', '1', '20', '', 'func', null, '2022-03-23 22:16:17', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('238', '234', '查询客户机组列表带全部选项', 'desktop:clientgroup:listwithall', '1', '30', '', 'func', null, '2022-03-23 22:16:44', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('239', '234', '查询客户机组详情', 'desktop:clientgroup:get', '1', '40', '', 'func', null, '2022-03-23 22:17:59', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('240', '234', '查询客户机组策略', 'desktop:clientgroup:getstrategy', '1', '50', '', 'func', null, '2022-03-23 22:18:49', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('241', '234', '删除客户机组', 'desktop:clientgroup:delete', '1', '60', '', 'func', null, '2022-03-23 22:19:54', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('242', '234', '编辑客户机组', 'desktop:clientgroup:update', '1', '70', '', 'func', null, '2022-03-23 22:21:13', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('243', '234', '编辑客户机组策略', 'desktop:clientgroup:updatestrategy', '1', '80', '', 'func', null, '2022-03-23 22:21:59', null, '2022-03-23 22:23:20', null, '1');
INSERT INTO `sys_permission` VALUES ('244', '234', '同步客户机组策略', 'desktop:clientgroup:syncstrategy', '1', '90', '', 'func', null, '2022-03-23 22:22:49', null, '2022-03-23 22:23:33', null, '1');
INSERT INTO `sys_permission` VALUES ('245', '235', '创建客户机', 'desktop:client:create', '1', '10', '', 'func', null, '2022-03-23 22:24:41', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('246', '235', '创建客户机', 'desktop:client:create', '1', '20', '', 'func', null, '2022-03-23 22:24:41', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('247', '235', '批量导入客户机', 'desktop:client:import', '1', '20', '', 'func', null, '2022-03-23 22:24:41', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('248', '235', '查询客户机列表分页', 'desktop:client:page', '1', '20', '', 'func', null, '2022-03-23 22:24:41', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('249', '235', '查询客户机策略', 'desktop:client:getstrategy', '1', '20', '', 'func', null, '2022-03-23 22:24:41', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('250', '235', '查询客户机关联用户', 'desktop:client:getassociateduser', '1', '20', '', 'func', null, '2022-03-23 22:24:41', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('251', '235', '下载导入模板', 'desktop:client:downloadtemplate', '1', '20', '', 'func', null, '2022-03-23 22:24:41', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('252', '235', '下载错误报告', 'desktop:client:downloaderrorreport', '1', '20', '', 'func', null, '2022-03-23 22:24:41', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('253', '235', '批量删除客户机', 'desktop:client:delete', '1', '20', '', 'func', null, '2022-03-23 22:24:41', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('254', '235', '编辑客户机', 'desktop:client:update', '1', '20', '', 'func', null, '2022-03-23 22:24:41', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('255', '235', '编辑客户机策略', 'desktop:client:updatestrategy', '1', '20', '', 'func', null, '2022-03-23 22:24:41', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('256', '235', '更新客户机所属范围', 'desktop:client:updaterange', '1', '20', '', 'func', null, '2022-03-23 22:24:41', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('257', '235', '同步客户机策略', 'desktop:client:syncstrategy', '1', '20', '', 'func', null, '2022-03-23 22:24:41', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('258', '235', '关联用户', 'desktop:client:associateduser', '1', '20', '', 'func', null, '2022-03-23 22:24:41', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('259', '235', '批量重启客户机', 'desktop:client:restart', '1', '20', '', 'func', null, '2022-03-23 22:24:41', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('260', '235', '批量关闭客户机', 'desktop:client:close', '1', '20', '', 'func', null, '2022-03-23 22:24:41', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('261', '235', '批量移动客户机', 'desktop:client:move', '1', '20', '', 'func', null, '2022-03-23 22:24:41', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('262', '109', '编辑资源池', 'des:resourcepool:update', '1', '45', '', 'func', null, '2022-03-24 13:02:20', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('263', '2', '保存策略', 'system:userGroup:strategy', '1', '20', '', 'func', null, '2022-03-28 12:41:22', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('264', '2', '同步策略', 'system:userGroup:sync:strategy', '1', '30', '', 'func', null, '2022-03-28 12:41:53', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('265', '52', '自定义UI', 'SystemGlobalCustomUi', '1', '0', '', 'menu', null, '2022-03-29 11:09:14', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('266', '1', '镜像', 'system:image', '1', '42', '', 'func', null, '2022-03-30 15:51:56', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('267', '266', '创建镜像', 'system:image:create', '1', '2', '', 'func', null, '2022-03-30 15:53:35', null, '2022-04-06 19:14:46', null, '1');
INSERT INTO `sys_permission` VALUES ('268', '266', '编辑镜像', 'system:image:update', '1', '5', '', 'func', null, '2022-03-30 15:54:32', null, '2022-04-06 19:33:54', null, '1');
INSERT INTO `sys_permission` VALUES ('269', '266', '删除镜像', 'system:image:delete', '1', '11', '', 'func', null, '2022-03-30 15:55:03', null, '2022-04-06 19:35:32', null, '1');
INSERT INTO `sys_permission` VALUES ('270', '266', '更新所属范围', 'system:image:scope', '1', '8', '', 'func', null, '2022-03-30 15:55:31', null, '2022-04-06 19:30:58', null, '1');
INSERT INTO `sys_permission` VALUES ('271', '141', '云桌面修改快照', 'desktop:desktop:snapshot:update', '1', '230', '', 'func', null, '2022-04-01 11:03:05', null, '2022-04-01 12:01:41', null, '1');
INSERT INTO `sys_permission` VALUES ('272', '141', '云桌面恢复快照', 'desktop:desktop:snapshot:restore', '1', '240', '', 'func', null, '2022-04-01 11:03:31', null, '2022-04-01 12:01:47', null, '1');
INSERT INTO `sys_permission` VALUES ('273', '141', '云桌面删除快照', 'desktop:desktop:snapshot:delete', '1', '250', '', 'func', null, '2022-04-01 11:03:59', null, '2022-04-01 12:01:52', null, '1');
INSERT INTO `sys_permission` VALUES ('274', '181', '派生云桌面', 'desktop:desktop:derive', '1', '210', '', 'func', null, '2022-04-01 11:04:30', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('275', '181', '模板机修改快照', 'desktop:template:snapshot:update', '1', '220', '', 'func', null, '2022-04-01 11:05:06', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('276', '181', '模板机恢复快照', 'desktop:template:snapshot:restore', '1', '230', '', 'func', null, '2022-04-01 11:05:29', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('277', '181', '模板机删除快照', 'desktop:template:snapshot:delete', '1', '240', '', 'func', null, '2022-04-01 11:05:58', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('278', '48', '服务器', 'SystemServer', '1', '9', '', 'menu', null, '2022-04-01 14:20:23', null, '2022-04-01 14:20:56', null, '1');
INSERT INTO `sys_permission` VALUES ('279', '1', '自定义配置', 'system:customConfig', '1', '43', '', 'func', null, '2022-04-01 15:29:49', null, '2022-04-01 15:33:53', null, '1');
INSERT INTO `sys_permission` VALUES ('280', '279', '查询自定义配置', 'system:customConfig:detail', '1', '1', '', 'func', null, '2022-04-01 15:31:10', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('281', '279', '修改自定义配置', 'system:customConfig:update', '1', '2', '', 'func', null, '2022-04-01 15:32:54', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('282', '235', '导出客户机', 'desktop:clientgroup:export', '1', '50', '客户组导出和客户机导出是一个接口', 'func', null, '2022-04-06 13:23:57', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('283', '266', '镜像分页列表', 'system:image:page', '1', '1', '', 'func', null, '2022-04-06 19:12:51', null, '2022-04-06 19:14:28', null, '1');
INSERT INTO `sys_permission` VALUES ('284', '266', '查询镜像信息', 'system:image:get', '1', '3', '', 'func', null, '2022-04-06 19:19:43', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('285', '48', '运维告警', 'SystemAlarm', '1', '7', '', 'menu', null, '2022-04-08 09:28:33', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('286', '105', '系统日志列表', 'system:log:system:page', '1', '3', '', 'func', null, '2022-04-08 14:50:58', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('287', '105', '系统日志导出', 'system:log:system:export', '1', '4', '', 'func', null, '2022-04-08 14:51:28', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('288', '105', '告警日志列表', 'alarm:log:page', '1', '5', '', 'func', null, '2022-04-08 14:53:09', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('289', '105', '告警日志导出', 'alarm:log:export', '1', '6', '', 'func', null, '2022-04-08 14:53:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('290', '1', '运维告警', 'alarm:rule:detail', '1', '100', '', 'func', null, '2022-04-08 14:57:44', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('291', '290', '修改告警规则', 'alarm:rule:update', '1', '2', '', 'func', null, '2022-04-08 14:58:54', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('292', '290', '告警策略详情', 'alarm:receive:detail', '1', '3', '', 'func', null, '2022-04-08 15:00:30', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('293', '290', '修改告警策略', 'alarm:receive:update', '1', '4', '', 'func', null, '2022-04-08 15:00:50', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('294', '290', '邮件服务器详情', 'alarm:receive:mail:detail', '1', '5', '', 'func', null, '2022-04-08 15:01:20', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('295', '290', '修改邮件服务器', 'alarm:receive:mail:update', '1', '6', '', 'func', null, '2022-04-08 15:01:45', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('296', null, '工作台', 'workbench', '1', '0', '', 'func', null, '2022-04-08 15:28:05', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('297', '296', '在线用户', 'workbench:online', '1', '20', '', 'func', null, '2022-04-08 15:28:42', null, '2022-04-28 13:56:42', null, '1');
INSERT INTO `sys_permission` VALUES ('298', '297', '在线用户列表', 'workbench:online:list', '1', '30', '', 'func', null, '2022-04-08 15:29:15', null, '2022-04-28 13:38:49', null, '0');
INSERT INTO `sys_permission` VALUES ('299', '297', '在线用户下线', 'workbench:online:close', '1', '40', '', 'func', null, '2022-04-08 15:30:08', null, '2022-04-08 15:30:21', null, '1');
INSERT INTO `sys_permission` VALUES ('300', '290', '监控指标', 'monitor:metric:all', '1', '7', '', 'func', null, '2022-04-08 16:29:00', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('301', '1', '授权中心', 'system:license', '1', '20', '', 'func', null, '2022-04-08 16:32:20', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('302', '301', '导入授权', 'system:license:import', '1', '10', '', 'func', null, '2022-04-08 16:32:57', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('303', '301', '授权详情', 'system:license:detail', '1', '20', '', 'func', null, '2022-04-08 16:33:18', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('304', '301', '下载请求码', 'system:license:download', '1', '30', '', 'func', null, '2022-04-08 16:34:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('305', '1', '服务器', 'desktop:physical', '1', '1', '', 'func', null, '2022-04-11 19:08:17', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('306', '305', '查询服务器列表', 'desktop:physical:list', '1', '1', '', 'func', null, '2022-04-11 19:09:28', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('307', '305', '编辑服务器', 'desktop:physical:update', '1', '3', '', 'func', null, '2022-04-11 19:10:14', null, '2022-04-11 19:10:47', null, '1');
INSERT INTO `sys_permission` VALUES ('308', '305', '查询服务器详情', 'desktop:physical:detail', '1', '2', '', 'func', null, '2022-04-11 19:10:40', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('309', '305', '开机服务器', 'desktop:physical:startup', '1', '5', '', 'func', null, '2022-04-11 19:12:55', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('310', '305', '关机服务器', 'desktop:physical:shutdown', '1', '6', '', 'func', null, '2022-04-11 19:13:28', null, '2022-04-11 19:14:11', null, '1');
INSERT INTO `sys_permission` VALUES ('311', '305', '软重启服务器', 'desktop:physical:softReboot', '1', '7', '', 'func', null, '2022-04-11 19:13:59', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('312', '305', '硬重启服务器', 'desktop:physical:reboot', '1', '8', '', 'func', null, '2022-04-11 19:14:44', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('313', '46', '共享网盘', 'DesktopCloudDisk', '1', '5', '共享网盘', 'menu', null, '2022-04-12 14:34:25', null, '2022-04-28 11:17:32', null, '0');
INSERT INTO `sys_permission` VALUES ('314', '105', '客户机日志列表', 'system:log:client:page', '1', '7', '', 'func', null, '2022-04-16 16:17:32', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('315', '105', '客户机日志导出', 'system:log:client:export', '1', '8', '', 'func', null, '2022-04-16 16:17:57', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('316', '233', '客户机VOI', 'desktop:voi', '1', '20', '', 'func', null, '2022-04-18 09:16:20', null, '2022-04-18 09:16:38', null, '1');
INSERT INTO `sys_permission` VALUES ('317', '316', '查新客户机VOI列表分页', 'desktop:voi:page', '1', '10', '', 'func', null, '2022-04-18 09:17:15', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('318', '316', '查询客户机详情(编辑)', 'desktop:voi:detail', '1', '20', '', 'func', null, '2022-04-18 09:17:51', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('319', '316', '查询客户机下桌面', 'desktop:voi:desktop', '1', '30', '', 'func', null, '2022-04-18 09:18:14', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('320', '316', '编辑客户机VOI', 'desktop:voi:update', '1', '40', '', 'func', null, '2022-04-18 09:18:51', null, '2022-04-18 09:18:58', null, '1');
INSERT INTO `sys_permission` VALUES ('321', '316', '编辑客户机VOI名称', 'desktop:voi:updatename', '1', '50', '', 'func', null, '2022-04-18 09:19:34', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('322', '316', '批量删除客户机VOI', 'desktop:voi:del', '1', '60', '', 'func', null, '2022-04-18 09:20:03', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('323', '316', '批量开启VOI客户机', 'desktop:voi:start', '1', '70', '', 'func', null, '2022-04-18 09:42:19', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('324', '316', '批量重启VOI客户机', 'desktop:voi:restart', '1', '80', '', 'func', null, '2022-04-18 09:43:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('325', '316', '批量关闭VOI客户机', 'desktop:voi:close', '1', '90', null, 'func', null, '2022-04-18 09:43:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('326', '316', '批量操作VOI客户机进入维护模式', 'desktop:voi:maintainEntry', '1', '100', null, 'func', null, '2022-04-18 09:43:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('327', '316', '批量操作VOI客户机下发桌面', 'desktop:voi:maintainIssue', '1', '110', null, 'func', null, '2022-04-18 09:43:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('328', '316', '批量操作VOI客户机取消下发桌面', 'desktop:voi:maintainCancel', '1', '120', null, 'func', null, '2022-04-18 09:43:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('329', '316', '操作VOI客户机删除桌面', 'desktop:voi:deleteDesktop', '1', '130', null, 'func', null, '2022-04-18 09:43:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('330', '316', '操作VOI客户机进入编辑模式', 'desktop:voi:entryEditMode', '1', '140', null, 'func', null, '2022-04-18 09:43:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('331', '316', '操作VOI客户机退出编辑模式', 'desktop:voi:exitEditMode', '1', '150', null, 'func', null, '2022-04-18 09:43:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('332', '316', '操作VOI客户机切换桌面', 'desktop:voi:switchDesktop', '1', '160', null, 'func', null, '2022-04-18 09:43:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('333', '316', '操作VOI客户机远程登录', 'desktop:voi:remote', '1', '170', null, 'func', null, '2022-04-18 09:43:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('334', '316', '操作VOI格式化客户机', 'desktop:voi:cleanDataDisk', '1', '180', null, 'func', null, '2022-04-18 09:43:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('335', '316', '批量操作VOI客户机发送消息', 'desktop:voi:operateSendMsg', '1', '190', null, 'func', null, '2022-04-18 09:43:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('336', '316', '批量操作VOI客户机排序', 'desktop:voi:sort', '1', '200', null, 'func', null, '2022-04-18 09:43:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('337', '316', '批量操作VOI客户机取消排序', 'desktop:voi:sortCancel', '1', '210', null, 'func', null, '2022-04-18 09:43:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('338', '48', 'ISO', 'SystemIso', '1', '3', '', 'menu', null, '2022-04-18 15:55:07', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('339', '316', '查询voi桌面关联客户机', 'desktop:voi:list', '1', '15', '', 'func', null, '2022-04-18 19:36:06', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('340', '316', '解绑客户机', 'desktop:voi:unbind', '1', '220', '', 'func', null, '2022-04-18 19:36:57', null, '2022-04-18 19:37:08', null, '1');
INSERT INTO `sys_permission` VALUES ('341', '133', 'voi云桌面', 'desktop:desktop:voi', '1', '10', '', 'func', null, '2022-04-18 20:58:22', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('342', '341', 'VOI云桌面列表', 'desktop:desktop:voi:list', '1', '10', '', 'func', null, '2022-04-18 20:59:23', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('343', '341', 'VOI云桌面详情', 'desktop:desktop:voi:detail', '1', '20', '', 'func', null, '2022-04-18 20:59:56', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('344', '341', '新增voi云桌面', 'desktop:desktop:voi:create', '1', '30', '', 'func', null, '2022-04-18 21:01:05', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('345', '341', '修改voi云桌面', 'desktop:desktop:voi:update', '1', '40', '', 'func', null, '2022-04-18 21:01:44', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('346', '341', '启动voi云桌面', 'desktop:desktop:voi:start', '1', '50', '', 'func', null, '2022-04-18 21:02:07', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('347', '341', '关机voi云桌面', 'desktop:desktop:voi:shutdown', '1', '60', '', 'func', null, '2022-04-18 21:02:23', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('348', '341', '软重启voi云桌面', 'desktop:desktop:voi:softReboot', '1', '70', '', 'func', null, '2022-04-18 21:02:41', null, '2022-04-22 10:03:58', null, '0');
INSERT INTO `sys_permission` VALUES ('349', '341', '重启voi云桌面', 'desktop:desktop:voi:reboot', '1', '80', '', 'func', null, '2022-04-18 21:02:58', null, '2022-04-22 10:04:07', null, '1');
INSERT INTO `sys_permission` VALUES ('350', '341', '移动voi云桌面', 'desktop:desktop:voi:move', '1', '90', '', 'func', null, '2022-04-18 21:03:18', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('351', '341', '关联用户', 'desktop:desktop:voi:user', '1', '100', '', 'func', null, '2022-04-18 21:03:35', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('352', '341', '转为模板机', 'desktop:desktop:voi:template', '1', '110', '', 'func', null, '2022-04-18 21:03:59', null, '2022-04-19 14:05:28', null, '1');
INSERT INTO `sys_permission` VALUES ('353', '341', '更新桌面策略', 'desktop:desktop:voi:policy', '1', '120', '', 'func', null, '2022-04-18 21:04:19', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('354', '341', '同步桌面策略', 'desktop:desktop:voi:sync:policy', '1', '130', '', 'func', null, '2022-04-18 21:04:36', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('355', '341', '远程登录', 'desktop:desktop:voi:remote', '1', '140', '', 'func', null, '2022-04-18 21:04:59', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('356', '341', '删除voi云桌面', 'desktop:desktop:voi:delete', '1', '150', '', 'func', null, '2022-04-18 21:05:37', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('357', '341', '新增voi云桌面备份', 'desktop:desktop:voi:backupCreate', '1', '160', '', 'func', null, '2022-04-18 21:05:55', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('358', '341', '修改voi云桌面备份', 'desktop:desktop:voi:backupUpdate', '1', '170', '', 'func', null, '2022-04-18 21:06:12', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('359', '341', '删除voi云桌面备份', 'desktop:desktop:voi:backupDelete', '1', '180', '', 'func', null, '2022-04-18 21:06:32', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('360', '341', '查询voi云桌面备份', 'desktop:desktop:voi:backupList', '1', '190', '', 'func', null, '2022-04-18 21:06:54', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('361', '133', 'voi模板机', 'desktop:template:voi', '1', '200', '', 'func', null, '2022-04-18 21:07:40', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('362', '361', 'voi模板机列表', 'desktop:template:voi:page', '1', '10', '', 'func', null, '2022-04-18 21:08:04', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('363', '361', '新增voi模板机', 'desktop:template:voi:create', '1', '20', '', 'func', null, '2022-04-18 21:08:26', null, '2022-04-18 21:10:06', null, '1');
INSERT INTO `sys_permission` VALUES ('364', '361', '查询voi模板机详情', 'desktop:template:voi:detail', '1', '30', '', 'func', null, '2022-04-18 21:09:47', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('365', '361', '修改voi模板机', 'desktop:template:voi:update', '1', '40', '', 'func', null, '2022-04-18 21:10:25', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('366', '361', '删除voi模板机', 'desktop:template:voi:delete', '1', '50', '', 'func', null, '2022-04-18 21:10:43', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('367', '361', '启动voi模板机', 'desktop:template:voi:start', '1', '60', '', 'func', null, '2022-04-18 21:11:00', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('368', '361', '关机voi模板机', 'desktop:template:voi:shutdown', '1', '70', '', 'func', null, '2022-04-18 21:11:16', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('369', '361', '软重启voi模板机', 'desktop:template:voi:softReboot', '1', '80', '', 'func', null, '2022-04-18 21:11:32', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('370', '361', '硬重启voi模板机', 'desktop:template:voi:reboot', '1', '90', '', 'func', null, '2022-04-18 21:11:48', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('371', '361', '迁移voi模板机', 'desktop:template:voi:migrate', '1', '100', '', 'func', null, '2022-04-18 21:12:05', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('372', '361', '同步云桌面', 'desktop:template:voi:syncDesktop', '1', '110', '', 'func', null, '2022-04-18 21:12:29', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('373', '361', '更新voi模板机策略', 'desktop:template:voi:updatePolicy', '1', '120', '', 'func', null, '2022-04-18 21:12:49', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('374', '361', '同步voi模板机策略', 'desktop:template:voi:syncPolicy', '1', '130', '', 'func', null, '2022-04-18 21:13:07', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('375', '361', '生成BT种子', 'desktop:template:voi:generateBT', '1', '140', '', 'func', null, '2022-04-18 21:13:26', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('376', '361', '强制关机voi模板机', 'desktop:template:voi:forceShutdown', '1', '150', '', 'func', null, '2022-04-18 21:13:45', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('377', '361', '下载', 'desktop:template:voi:download', '1', '160', '', 'func', null, '2022-04-18 21:14:11', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('378', '361', '重置', 'desktop:template:voi:reset', '1', '170', '', 'func', null, '2022-04-18 21:14:29', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('379', '361', '配置ISO', 'desktop:template:voi:configureIso', '1', '180', '', 'func', null, '2022-04-18 21:14:47', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('380', '361', '新增更新点', 'desktop:template:voi:updatePointCreate', '1', '190', '', 'func', null, '2022-04-18 21:15:05', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('381', '361', '修改更新点', 'desktop:template:voi:updatePointUpdate', '1', '200', '', 'func', null, '2022-04-18 21:15:25', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('382', '361', '删除更新点', 'desktop:template:voi:updatePointDelete', '1', '210', '', 'func', null, '2022-04-18 21:15:47', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('383', '361', '查询云桌面更新点', 'desktop:template:voi:updatePointList', '1', '220', '', 'func', null, '2022-04-18 21:16:08', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('384', '361', '挂载数据盘', 'desktop:template:voi:volumeAttach', '1', '230', '', 'func', null, '2022-04-18 21:16:29', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('385', '361', '删除数据盘', 'desktop:template:voi:volumeDelete', '1', '240', '', 'func', null, '2022-04-18 21:16:51', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('386', '361', '复制voi模板机', 'desktop:template:voi:copy', '1', '250', '', 'func', null, '2022-04-18 21:17:11', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('387', '361', '进入voi模板机', 'desktop:template:voi:enter', '1', '260', '', 'func', null, '2022-04-18 21:17:32', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('388', '361', '获取voi数据盘列表', 'desktop:template:voi:volumeList', '1', '270', '', 'func', null, '2022-04-18 21:17:53', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('389', '316', '导出客户机信息', 'desktop:voi:export', '1', '221', '', 'func', null, '2022-04-19 15:09:34', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('390', '316', 'VOI客户端升级', 'desktop:voi:upload', '1', '222', null, 'func', null, '2022-04-18 09:43:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('391', '316', '获取VOI客户端升级信息', 'desktop:voi:packInfo', '1', '223', null, 'func', null, '2022-04-18 09:43:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('392', '46', '本地共享盘模板列表', 'DesktopShareDiskTemplate', '1', '6', '', 'menu', null, '2022-04-20 10:57:40', null, '2022-04-20 17:21:11', null, '0');
INSERT INTO `sys_permission` VALUES ('393', '133', '本地共享盘模板', 'desktop:sharedisk:template', '1', '100', '', 'func', null, '2022-04-20 13:39:56', null, '2022-04-28 18:48:46', null, '1');
INSERT INTO `sys_permission` VALUES ('394', '393', '删除本地共享盘模板', 'desktop:sharedisk:template:delete', '1', '15', '', 'func', null, '2022-04-20 13:40:51', null, '2022-04-28 18:56:36', null, '1');
INSERT INTO `sys_permission` VALUES ('395', '393', '本地共享盘模板列表分页', 'desktop:sharedisk:template:page', '1', '1', '', 'func', null, '2022-04-20 13:43:21', null, '2022-04-28 18:50:54', null, '1');
INSERT INTO `sys_permission` VALUES ('396', '141', '开始协助', 'desktop:desktop:startAssist', '1', '260', '', 'func', null, '2022-04-20 15:11:09', null, '2022-04-20 15:11:27', null, '1');
INSERT INTO `sys_permission` VALUES ('397', '141', '拒绝协助', 'desktop:desktop:refuseAssist', '1', '270', '', 'func', null, '2022-04-20 15:11:46', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('398', '52', '邮件服务器', 'SystemGlobalMail', '1', '3', '', 'menu', null, '2022-04-22 13:07:01', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('399', '341', '创建共享盘', 'desktop:sharedisk:voi:exclusivegroup:create', '1', '200', '', 'func', null, '2022-04-22 14:02:14', null, '2022-04-22 14:03:52', null, '1');
INSERT INTO `sys_permission` VALUES ('400', '341', '删除共享盘', 'desktop:sharedisk:voi:exclusivegroup:delete', '1', '210', '', 'func', null, '2022-04-22 14:03:06', null, '2022-04-22 14:03:36', null, '1');
INSERT INTO `sys_permission` VALUES ('401', '341', '扩容共享盘', 'desktop:sharedisk:voi:exclusivegroup:resize', '1', '220', '', 'func', null, '2022-04-22 14:04:31', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('402', '316', '创建共享盘', 'desktop:sharedisk:voi:sharegroup:create', '1', '230', '', 'func', null, '2022-04-22 14:07:01', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('403', '316', '删除共享盘', 'desktop:sharedisk:voi:sharegroup:delete', '1', '240', '', 'func', null, '2022-04-22 14:07:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('404', '316', '扩容共享盘', 'desktop:sharedisk:voi:sharegroup:resize', '1', '250', '', 'func', null, '2022-04-22 14:08:32', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('405', '133', '共享网盘', 'desktop:clouddisk', '1', '98', '', 'func', null, '2022-04-22 15:23:03', null, '2022-04-22 15:26:49', null, '1');
INSERT INTO `sys_permission` VALUES ('406', '405', '共享网盘列表', 'desktop:clouddisk:page', '1', '1', '', 'func', null, '2022-04-22 15:28:05', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('407', '405', '创建共享网盘', 'desktop:clouddisk:create', '1', '5', '', 'func', null, '2022-04-22 15:30:28', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('408', '405', '修改共享网盘', 'desktop:clouddisk:update', '1', '8', '', 'func', null, '2022-04-22 15:31:47', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('409', '405', '删除共享网盘', 'desktop:clouddisk:delete', '1', '12', '', 'func', null, '2022-04-22 15:32:26', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('410', '405', '扩容共享网盘', 'desktop:clouddisk:resize', '1', '15', '', 'func', null, '2022-04-22 15:34:29', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('411', '405', '配置读写权限', 'desktop:clouddisk:readwrite', '1', '18', '', 'func', null, '2022-04-22 15:35:18', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('412', '405', '子网盘列表', 'desktop:clouddisk:child:page', '1', '20', '', 'func', null, '2022-04-22 15:36:17', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('413', '405', '创建子网盘', 'desktop:clouddisk:child:create', '1', '25', '', 'func', null, '2022-04-22 15:37:07', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('414', '405', '修改子网盘', 'desktop:clouddisk:child:update', '1', '30', '', 'func', null, '2022-04-22 15:38:06', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('415', '405', '扩容子网盘', 'desktop:clouddisk:child:resize', '1', '35', '', 'func', null, '2022-04-22 15:38:57', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('416', '405', '子网盘关联桌面组', 'desktop:clouddisk:child:relate:group', '1', '40', '', 'func', null, '2022-04-22 15:40:19', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('417', '405', '子网盘移除桌面组', 'desktop:clouddisk:child:remove:group', '1', '45', '', 'func', null, '2022-04-22 15:52:58', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('418', '405', '子网盘关联云桌面', 'desktop:clouddisk:child:relate:desktop', '1', '50', '', 'func', null, '2022-04-22 15:54:08', null, '2022-04-22 15:55:06', null, '1');
INSERT INTO `sys_permission` VALUES ('419', '405', '子网盘移除桌面', 'desktop:clouddisk:child:remove:desktop', '1', '55', '', 'func', null, '2022-04-22 15:58:16', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('420', '405', '删除子网盘', 'desktop:clouddisk:child:delete', '1', '60', '', 'func', null, '2022-04-22 15:59:24', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('421', '405', '共享网盘关联云桌面列表', 'desktop:clouddisk:associate:desktop:list', '1', '65', '', 'func', null, '2022-04-22 16:01:39', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('422', '1', '中控台', 'desktop:centerconsole', '1', '1', '', 'func', null, '2022-04-24 09:43:28', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('423', '422', '查询中控台列表', 'desktop:centerconsole:page', '1', '1', '', 'func', null, '2022-04-24 09:49:07', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('424', '422', '重启中控台', 'desktop:centerconsole:reboot', '1', '2', '', 'func', null, '2022-04-24 09:49:51', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('425', '422', '关联客户机', 'desktop:centerconsole:bindClient', '1', '3', '', 'func', null, '2022-04-24 09:50:17', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('426', '48', '中控台', 'SystemConsole', '1', '10', '', 'menu', null, '2022-04-24 11:18:10', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('427', '0', '工作台', 'workbench', '1', '1', '', 'menu', null, '2022-04-24 13:10:54', null, '2022-04-28 10:17:12', null, '0');
INSERT INTO `sys_permission` VALUES ('428', '0', '云桌面', 'Desktop', '1', '2', '', 'menu', null, '2022-04-24 13:11:31', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('430', '427', '在线用户', 'WorkbenchOverView', '1', '2', '', 'menu', null, '2022-04-24 13:13:27', null, '2022-04-28 10:17:12', null, '0');
INSERT INTO `sys_permission` VALUES ('431', '428', '云桌面', 'DesktopVirtual', '1', '1', '', 'menu', null, '2022-04-24 13:13:49', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('432', '428', '模板机', 'DesktopTemplate', '1', '2', '', 'menu', null, '2022-04-24 13:14:06', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('433', '428', '共享网盘', 'DesktopCloudDisk', '1', '3', '', 'menu', null, '2022-04-24 13:14:22', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('434', '428', '数据盘', 'DesktopDataDisk', '1', '4', '', 'menu', null, '2022-04-24 13:14:45', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('435', '428', '回收站', 'DesktopRecycle', '1', '5', '', 'menu', null, '2022-04-24 13:15:00', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('436', '428', '本地共享盘模板', 'DesktopShareDiskTemplate', '1', '6', '', 'menu', null, '2022-04-24 13:15:16', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('437', '1', 'ISO', 'system:iso', '1', '42', '', 'func', null, '2022-04-24 15:21:36', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('438', '437', 'ISO分页列表', 'system:iso:page', '1', '1', '', 'func', null, '2022-04-24 15:22:11', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('439', '437', '创建ISO', 'system:iso:create', '1', '2', '', 'func', null, '2022-04-24 15:22:35', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('440', '437', '编辑ISO', 'system:iso:update', '1', '5', '', 'func', null, '2022-04-24 15:23:25', null, '2022-04-27 09:32:39', null, '1');
INSERT INTO `sys_permission` VALUES ('441', '437', '删除ISO', 'system:iso:delete', '1', '11', '', 'func', null, '2022-04-24 15:23:50', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('442', '437', '下载ISO', 'system:iso:download', '1', '10', '', 'func', null, '2022-04-24 15:24:34', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('443', '316', '关联客户机', 'desktop:desktop:voi:associatedClient', '1', '260', '', 'func', null, '2022-04-24 17:34:22', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('444', '316', '移除客户机', 'desktop:desktop:voi:removeClient', '1', '270', '', 'func', null, '2022-04-24 17:34:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('445', '316', '批量修改dhcp开关', 'desktop:voi:dhcpflag', '1', '280', '', 'func', null, '2022-04-25 09:24:27', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('446', '235', '解绑用户', 'desktop:client:unbinduser', '1', '60', '', 'func', null, '2022-04-25 10:07:45', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('447', '133', 'voi桌面组', 'desktop:group:voi', '1', '1', '', 'func', null, '2022-04-25 14:12:30', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('448', '447', '查询voi桌面组列表', 'desktop:group:voi:list', '1', '1', '', 'func', null, '2022-04-25 14:13:55', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('449', '447', '新增voi桌面组', 'desktop:group:voi:create', '1', '2', '', 'func', null, '2022-04-25 14:14:31', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('450', '447', '编辑voi桌面组', 'desktop:group:voi:update', '1', '3', '', 'func', null, '2022-04-25 14:15:07', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('451', '447', '删除voi桌面组', 'desktop:group:voi:delete', '1', '4', '', 'func', null, '2022-04-25 14:15:38', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('452', '316', '批量操作VOI客户机进入编辑模式--云桌面', 'desktop:voi:entryEditModeByDesktop', '1', '225', null, 'func', null, '2022-04-18 09:43:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('453', '316', '批量操作VOI客户机退出编辑模式--云桌面', 'desktop:voi:exitEditModeByDesktop', '1', '226', null, 'func', null, '2022-04-18 09:43:42', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('454', '0', '客户机', 'Client', '1', '3', '', 'menu', null, '2022-04-28 11:18:15', null, '2022-04-28 11:18:42', null, '1');
INSERT INTO `sys_permission` VALUES ('455', '297', '查询vdi在线用户', 'workbench:online:list', '1', '60', '', 'func', null, '2022-04-28 13:58:02', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('456', '297', '查询voi在线', 'workbench:online:voilist', '1', '70', '', 'func', null, '2022-04-28 14:14:13', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('457', '61', '获取用户列表分页', 'system:user:page', '1', '1', '', 'func', null, '2022-04-28 15:15:18', null, '2022-04-28 15:17:17', null, '1');
INSERT INTO `sys_permission` VALUES ('458', '211', '查询桌面组策略', 'desktop:group:policy:detail', '1', '5', '', 'func', null, '2022-04-28 16:11:38', null, '2022-04-28 16:13:43', null, '1');
INSERT INTO `sys_permission` VALUES ('459', '171', '网络列表', 'desktop:network:network:page', '1', '1', '', 'func', null, '2022-04-28 16:59:11', null, '2022-04-28 16:59:25', null, '1');
INSERT INTO `sys_permission` VALUES ('460', '171', '网络详情', 'desktop:network:network:detail', '1', '11', '', 'func', null, '2022-04-28 17:00:09', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('461', '393', '创建本地共享盘模板', 'desktop:sharedisk:template:create', '1', '5', '', 'func', null, '2022-04-28 18:52:18', null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('462', '393', '修改本地共享盘模板', 'desktop:sharedisk:template:update', '1', '10', '', 'func', null, '2022-04-28 18:54:41', null, null, null, '1');

-- ----------------------------
-- Table structure for sys_field
-- ----------------------------
DROP TABLE IF EXISTS `sys_field`;
CREATE TABLE `sys_field` (
  `uuid` varchar(50) NOT NULL COMMENT 'uuid',
  `user_uuid` varchar(50) NOT NULL COMMENT '用户uuid',
  `show_fields` varchar(100) DEFAULT NULL COMMENT '用户显示字段',
  `hidden_fields` varchar(100) DEFAULT NULL COMMENT '用户不显示字段',
  `type` varchar(10) DEFAULT NULL COMMENT '所属列表 desktop',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `createpin` varchar(100) DEFAULT NULL COMMENT '创建人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `updatepin` varchar(100) DEFAULT NULL COMMENT '修改人',
  `yn` tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户自定义列表表';

-- ----------------------------
-- Table structure for des_monitor
-- ----------------------------
DROP TABLE IF EXISTS `des_monitor`;
CREATE TABLE `des_monitor` (
  `uuid` varchar(50) NOT NULL,
  `desktop_uuid` varchar(50) NOT NULL,
  `cpu_usage` double(5,2) DEFAULT 0.00 COMMENT 'CUP使用率(%)',
  `memory_usage` double(5,2) DEFAULT 0.00 COMMENT '内存使用率(%)',
  `system_disk_usage` double(5,2) DEFAULT 0.00 COMMENT '系统盘使用率(%)',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `createpin` varchar(100) DEFAULT NULL COMMENT '创建人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `updatepin` varchar(100) DEFAULT NULL COMMENT '修改人',
  `yn` tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='云桌面监控数据';

-- ----------------------------
-- Table structure for des_desktop_update_point
-- ----------------------------
DROP TABLE IF EXISTS `des_desktop_update_point`;
CREATE TABLE `des_desktop_update_point` (
  `uuid` varchar(50) NOT NULL,
  `desktop_uuid` varchar(50) DEFAULT '' COMMENT '所属虚拟机',
  `name` varchar(60) DEFAULT NULL COMMENT '名称',
  `size` bigint(20) DEFAULT 0 COMMENT '备份文件大小(byte)',
  `description` varchar(200) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `createpin` varchar(100) DEFAULT NULL COMMENT '创建人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `updatepin` varchar(100) DEFAULT NULL COMMENT '修改人',
  `yn` tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='更新点表';

-- ----------------------------
-- Table structure for des_desktop_volume_plan
-- ----------------------------
DROP TABLE IF EXISTS `des_desktop_disk`;
CREATE TABLE `des_desktop_disk` (
  `uuid` varchar(50) NOT NULL,
  `desktop_uuid` varchar(50) DEFAULT '' COMMENT '所属虚拟机',
  `name` varchar(60) DEFAULT NULL COMMENT '名称',
  `path` varchar(200) DEFAULT '' COMMENT '文件路径',
  `type` varchar(30) DEFAULT '' COMMENT '类型',
  `size` bigint(20) DEFAULT 0 COMMENT '文件大小(GB)',
  `torrent_status` varchar(20) DEFAULT '',
  `index` int(11) DEFAULT 0 COMMENT '0代表系统盘，后面的代表数据盘',
  `conf_no` int(11) DEFAULT 0 COMMENT '配置版本号',
  `task_uuid` bigint(20) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `createpin` varchar(100) DEFAULT NULL COMMENT '创建人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `updatepin` varchar(100) DEFAULT NULL COMMENT '修改人',
  `yn` tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='voi 模板机  虚机磁盘详细信息';



-- ----------------------------
-- Table structure for des_desktop_user
-- ----------------------------
DROP TABLE IF EXISTS `des_desktop_user`;
CREATE TABLE `des_desktop_user` (
  `uuid` varchar(50) NOT NULL,
  `desktop_uuid` varchar(50) NOT NULL COMMENT '虚拟机表uuid',
  `user_uuid` varchar(50) NOT NULL COMMENT '用户uuid',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `createpin` varchar(100) DEFAULT NULL COMMENT '创建人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `updatepin` varchar(100) DEFAULT NULL COMMENT '修改人',
  `yn` tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='云桌面或模板机与用户的关联表';



SET FOREIGN_KEY_CHECKS = 1;
