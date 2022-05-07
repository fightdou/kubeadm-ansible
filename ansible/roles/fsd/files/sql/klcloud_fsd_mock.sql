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

 Date: 04/15/2022 12:47:34 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `mock`
-- ----------------------------
DROP TABLE IF EXISTS `mock`;
CREATE TABLE `mock` (
  `uuid` varchar(50) NOT NULL DEFAULT '' COMMENT '演示UUID',
  `name` varchar(100) DEFAULT '' COMMENT '演示名称',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `createpin` varchar(100) DEFAULT '' COMMENT '创建人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `updatepin` varchar(255) DEFAULT '' COMMENT '修改人',
  `yn` tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='演示';

-- ----------------------------
--  Records of `mock`
-- ----------------------------
BEGIN;
INSERT INTO `mock` VALUES ('111', 'aaa', null, '', null, '', '1'), ('222', 'bbb', null, '', null, '', '1');
COMMIT;

-- ----------------------------
--  Table structure for `system_user`
-- ----------------------------
DROP TABLE IF EXISTS `system_user`;
CREATE TABLE `system_user` (
  `user_id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '编号ID',
  `user_pin` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `user_password` varchar(128) DEFAULT '' COMMENT '密码',
  `user_real_name` varchar(128) DEFAULT '' COMMENT '姓名',
  `user_sex` varchar(10) DEFAULT '' COMMENT '性别：1男，0女，2保密',
  `user_email` varchar(128) DEFAULT '' COMMENT '邮箱',
  `user_mobile` varchar(20) DEFAULT '' COMMENT '手机',
  `user_status` char(1) DEFAULT '' COMMENT '状态：1有效，0锁定 ',
  `user_avatar` varchar(500) DEFAULT '' COMMENT '头像',
  `user_remark` text DEFAULT '' COMMENT '描述',
  `user_org_id` bigint(64) DEFAULT NULL COMMENT '组织架构ID',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `createpin` varchar(50) DEFAULT '' COMMENT '创建人',
  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
  `updatepin` varchar(50) DEFAULT '' COMMENT '修改人',
  `yn` tinyint(2) DEFAULT NULL COMMENT '删除状态：1正常，0删除',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='用户表';

-- ----------------------------
--  Records of `system_user`
-- ----------------------------
BEGIN;
INSERT INTO `system_user` VALUES ('1', 'yuanwei', '$2a$10$oGO0DFRZzjFXWT9Vkjquf.FRAs.olKzL3mEGcmRC2L1wIAWjT9KM6', '袁玮', '1', '27792500@qq.com', '13752505011', '1', 'aaa', '管理员账号', '1', '2020-11-27 15:46:04', 'yuanwei', '2021-08-27 04:05:07', 'yuanwei', '1'), ('2', 'guest', '$2a$10$Ib3sMMTeMseyL3ILqmvvVeVoan5ewIyVXHi6SDyZ/OE7P0GgCL/P2', '访客', '1', '27792511@qq.com', '13752505012', '1', 'bbb', '访客账号', '2', '2021-08-25 09:34:40', 'yuanwei', null, null, '1');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
