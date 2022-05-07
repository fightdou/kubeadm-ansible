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
SET
FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`
(
    `uuid`                 varchar(50) NOT NULL COMMENT '用户UUID',
    `account`              varchar(50)                        DEFAULT NULL COMMENT '用户名',
    `password`             varchar(100)                       DEFAULT NULL COMMENT '密码',
    `name`                 varchar(50)                        DEFAULT NULL COMMENT '姓名',
    `phone`                varchar(50)                        DEFAULT NULL COMMENT '手机号',
    `email`                varchar(50)                        DEFAULT NULL COMMENT '邮箱',
    `description`          varchar(150)                       DEFAULT NULL COMMENT '描述',
    `user_group_uuid`      varchar(50)                        DEFAULT NULL COMMENT '所属用户组',
    `account_md5`          varchar(100) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '用户名md5值',
    `status`               tinyint(2) DEFAULT 1 COMMENT '用户状态:1启用，0禁用',
    `strategy_info`        text                               DEFAULT NULL COMMENT '用户策略',
    `first_login`          tinyint(2) DEFAULT 1 COMMENT '是否首次登陆：1是，0否',
    `update_password_time` datetime                           DEFAULT NULL COMMENT '用户最后修改密码时间',
    `last_login_time`      datetime                           DEFAULT NULL COMMENT '最后登录时间',
    `createtime`           datetime                           DEFAULT NULL COMMENT '创建时间',
    `createpin`            varchar(100)                       DEFAULT NULL COMMENT '创建人',
    `updatetime`           datetime                           DEFAULT NULL COMMENT '修改时间',
    `updatepin`            varchar(100)                       DEFAULT NULL COMMENT '修改人',
    `yn`                   tinyint(2) DEFAULT NULL COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `klcloud_fsd`.`sys_user` (`uuid`, `account`, `password`, `name`, `phone`, `email`, `description`,
                                      `user_group_uuid`, `account_md5`, `status`, `strategy_info`, `first_login`,
                                      `update_password_time`, `last_login_time`, `createtime`, `createpin`,
                                      `updatetime`, `updatepin`, `yn`)
VALUES ('00008ed4-0441-4373-8d6f-57188fb52bc1', 'super', 'e10adc3949ba59abbe56e057f20f883e', 'super', NULL, NULL, NULL,
        '-1', '1b3231655cebb7a1f783eddf27d254ca', '1',
        '{\"description\":1,\"disconnect\":0,\"email\":1,\"invalid\":0,\"logout\":0,\"notEnteredTime\":5,\"notEnteredUnit\":\"m\",\"notOperatedTime\":5,\"notOperatedUnit\":\"m\",\"phone\":1,\"recordLog\":0,\"unusedTime\":30,\"userEdit\":0,\"userName\":1,\"visit\":0,\"visitPeriod\":\"[[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]]\"}',
        '0', '2022-03-21 09:26:04', '2022-03-21 09:26:04', '2022-03-21 09:26:04', NULL, '2022-04-15 11:03:42', NULL,
        '1');
INSERT INTO `klcloud_fsd`.`sys_user` (`uuid`, `account`, `password`, `name`, `phone`, `email`, `description`,
                                      `user_group_uuid`, `account_md5`, `status`, `strategy_info`, `first_login`,
                                      `update_password_time`, `last_login_time`, `createtime`, `createpin`,
                                      `updatetime`, `updatepin`, `yn`)
VALUES ('0000f9ee-3ccc-4210-8839-54c676e3f7b1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', 'admin', NULL, NULL, NULL,
        '00001e4f-0520-427a-866b-93ceb112144b', '21232f297a57a5a743894a0e4a801fc3', '1',
        '{\"description\":1,\"disconnect\":1,\"email\":1,\"invalid\":1,\"logout\":1,\"notEnteredTime\":52,\"notEnteredUnit\":\"h\",\"notOperatedTime\":5,\"notOperatedUnit\":\"m\",\"phone\":1,\"recordLog\":1,\"unusedTime\":311,\"userEdit\":1,\"userName\":1,\"visit\":1,\"visitPeriod\":\"[[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]]\"}',
        '0', '2022-03-17 13:56:40', '2022-03-17 13:56:40', '2022-03-17 13:56:40', NULL, '2022-04-15 11:02:09', '', '1');


-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`
(
    `uuid`               varchar(50) NOT NULL COMMENT '主键UUID',
    `user_uuid`          varchar(50)  DEFAULT NULL COMMENT '用户UUID',
    `role_uuid`          varchar(50)  DEFAULT NULL COMMENT '角色UUID',
    `resource_pool_uuid` varchar(50)  DEFAULT NULL COMMENT '资源池UUID',
    `createtime`         datetime     DEFAULT NULL COMMENT '创建时间',
    `createpin`          varchar(100) DEFAULT NULL COMMENT '创建人',
    `updatetime`         datetime     DEFAULT NULL COMMENT '修改时间',
    `updatepin`          varchar(100) DEFAULT NULL COMMENT '修改人',
    `yn`                 tinyint(2) DEFAULT NULL COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `klcloud_fsd`.`sys_user_role` (`uuid`, `user_uuid`, `role_uuid`, `resource_pool_uuid`, `createtime`,
                                           `createpin`, `updatetime`, `updatepin`, `yn`)
VALUES ('0000bb89-5f83-43ac-90db-3bb3a8e1d2c1', '00008ed4-0441-4373-8d6f-57188fb52bc1',
        '00009906-02e0-4257-bc53-d5180308c3e1', NULL, now(), NULL, NULL, NULL, '1');
INSERT INTO `klcloud_fsd`.`sys_user_role` (`uuid`, `user_uuid`, `role_uuid`, `resource_pool_uuid`, `createtime`,
                                           `createpin`, `updatetime`, `updatepin`, `yn`)
VALUES ('0000bb89-5f83-43ac-90db-3bb3a8e1d002', '0000f9ee-3ccc-4210-8839-54c676e3f7b1',
        '00009906-02e0-4257-bc53-d5180308c3e2', NULL, now(), NULL, NULL, NULL, '1');


-- ----------------------------
-- Table structure for des_desktop_flavor
-- ----------------------------
DROP TABLE IF EXISTS `des_desktop_flavor`;
CREATE TABLE `des_desktop_flavor`
(
    `uuid`         varchar(50) NOT NULL COMMENT '主键UUID',
    `name`         varchar(50)  DEFAULT '' COMMENT '桌面规格名称',
    `publicity`    varchar(10)  DEFAULT '' COMMENT '公开性(public:公开,private:私有)',
    `cpu`          int(11) DEFAULT NULL COMMENT 'cpu',
    `memory`       int(11) DEFAULT NULL COMMENT '内存',
    `description`  varchar(150) DEFAULT '' COMMENT '描述',
    `type`         varchar(10)  DEFAULT '' COMMENT '类型(vdi,voi)',
    `default_flag` tinyint(2) DEFAULT 0 COMMENT '是否为默认桌面规格 0否 1是',
    `createtime`   datetime     DEFAULT NULL COMMENT '创建时间',
    `createpin`    varchar(100) DEFAULT '' COMMENT '创建人',
    `updatetime`   datetime     DEFAULT NULL COMMENT '修改时间',
    `updatepin`    varchar(100) DEFAULT '' COMMENT '修改人',
    `yn`           tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='桌面规格';

-- ----------------------------
-- Records of des_desktop_flavor
-- ----------------------------
INSERT INTO `klcloud_fsd`.`des_desktop_flavor` (`uuid`, `name`, `publicity`, `cpu`, `memory`, `description`, `type`,
                                                `default_flag`, `createtime`, `createpin`, `updatetime`, `updatepin`,
                                                `yn`)
VALUES ('0000a7f9-e5aa-4392-9a95-c3565af87201', '低配', 'public', '4', '4', '', 'VDI', '1', '2022-04-26 09:59:45',
        '00008ed4-0441-4373-8d6f-57188fb52bc1', NULL, '', '1');
INSERT INTO `klcloud_fsd`.`des_desktop_flavor` (`uuid`, `name`, `publicity`, `cpu`, `memory`, `description`, `type`,
                                                `default_flag`, `createtime`, `createpin`, `updatetime`, `updatepin`,
                                                `yn`)
VALUES ('0000a7f9-e5aa-4392-9a95-c3565af87202', '标配', 'public', '4', '8', '', 'VDI', '1', '2022-04-26 08:59:45',
        '00008ed4-0441-4373-8d6f-57188fb52bc1', NULL, '', '1');
INSERT INTO `klcloud_fsd`.`des_desktop_flavor` (`uuid`, `name`, `publicity`, `cpu`, `memory`, `description`, `type`,
                                                `default_flag`, `createtime`, `createpin`, `updatetime`, `updatepin`,
                                                `yn`)
VALUES ('0000a7f9-e5aa-4392-9a95-c3565af87203', '高配', 'public', '8', '8', '', 'VDI', '1', '2022-04-26 07:59:45',
        '00008ed4-0441-4373-8d6f-57188fb52bc1', NULL, '', '1');


-- ----------------------------
-- Table structure for des_image
-- ----------------------------
DROP TABLE IF EXISTS `des_image`;
CREATE TABLE `des_image`
(
    `uuid`           varchar(50) NOT NULL DEFAULT '' COMMENT '主键UUID',
    `name`           varchar(50)          DEFAULT '' COMMENT '名称',
    `publicity`      varchar(10)          DEFAULT '' COMMENT '公开性(public:公开,private:私有)',
    `format`         varchar(10)          DEFAULT '' COMMENT '镜像格式(qcow2,raw)',
    `platform`       varchar(10)          DEFAULT '' COMMENT '平台(win7,win10)',
    `description`    varchar(150)         DEFAULT '' COMMENT '描述',
    `size`           bigint(20) DEFAULT NULL COMMENT '镜像大小(byte)',
    `virtual_size`   bigint(20) DEFAULT NULL COMMENT '虚拟大小',
    `path`           varchar(150)         DEFAULT '' COMMENT '存储路径',
    `task_uuid`      bigint(20) DEFAULT NULL COMMENT '任务uuid',
    `torrent_status` varchar(20)          DEFAULT '' COMMENT '制作种子状态',
    `type`           varchar(10)          DEFAULT '' COMMENT '类型(vdi,voi)',
    `status`         varchar(50)          DEFAULT '' COMMENT '状态',
    `createtime`     datetime             DEFAULT NULL COMMENT '创建时间',
    `createpin`      varchar(100)         DEFAULT '' COMMENT '创建人',
    `updatetime`     datetime             DEFAULT NULL COMMENT '修改时间',
    `updatepin`      varchar(100)         DEFAULT '' COMMENT '修改人',
    `yn`             tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='镜像';

-- ----------------------------
-- Table structure for des_volume
-- ----------------------------
DROP TABLE IF EXISTS `des_volume`;
CREATE TABLE `des_volume`
(
    `uuid`               varchar(50) NOT NULL COMMENT '主键UUID',
    `name`               varchar(50)  DEFAULT '' COMMENT '名称',
    `size`               int(11) DEFAULT NULL COMMENT '数据盘大小(GB)',
    `status`             varchar(50)  DEFAULT '' COMMENT '状态',
    `desktop_uuid`       varchar(50)  DEFAULT '' COMMENT '云桌面UUID',
    `resource_pool_uuid` varchar(50)  DEFAULT '' COMMENT '所属资源池uuid',
    `type`               varchar(50)  DEFAULT '' COMMENT '类型(volume:数据盘,system_disk:系统盘)',
    `attached_index`     int(11) DEFAULT NULL COMMENT '标识卷的挂载的先后顺序',
    `createtime`         datetime     DEFAULT NULL COMMENT '创建时间',
    `createpin`          varchar(100) DEFAULT '' COMMENT '创建人',
    `updatetime`         datetime     DEFAULT NULL COMMENT '修改时间',
    `updatepin`          varchar(100) DEFAULT '' COMMENT '修改人',
    `yn`                 tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='数据盘';

-- ----------------------------
-- Table structure for des_cloud_disk
-- ----------------------------
DROP TABLE IF EXISTS `des_cloud_disk`;
CREATE TABLE `des_cloud_disk`
(
    `uuid`               varchar(50) NOT NULL COMMENT '主键UUID',
    `name`               varchar(50)                     DEFAULT NULL COMMENT '共享网盘名称',
    `resource_pool_uuid` varchar(50)                     DEFAULT '' COMMENT '资源池UUID',
    `host_path`          varchar(300)                    DEFAULT NULL COMMENT '服务器存储路径',
    `guest_path`         varchar(300)                    DEFAULT NULL COMMENT '虚拟机访问路径',
    `size`               int(11) DEFAULT NULL COMMENT '大小',
    `publicity`          varchar(20)                     DEFAULT '' COMMENT '公开性(public:公开,private:私有)',
    `parent_uuid`        varchar(50)                     DEFAULT '' COMMENT '所属网盘UUID',
    `description`        varchar(150)                    DEFAULT NULL COMMENT '描述',
    `createtime`         datetime                        DEFAULT NULL COMMENT '创建时间',
    `createpin`          varchar(100)                    DEFAULT NULL COMMENT '创建人',
    `updatetime`         datetime                        DEFAULT NULL COMMENT '修改时间',
    `updatepin`          varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '修改人',
    `yn`                 tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='共享网盘';

-- ----------------------------
-- Table structure for des_cloud_disk_desktop
-- ----------------------------
DROP TABLE IF EXISTS `des_cloud_disk_desktop`;
CREATE TABLE `des_cloud_disk_desktop`
(
    `uuid`                 varchar(50) NOT NULL DEFAULT '' COMMENT '主键UUID',
    `cloud_disk_uuid`      varchar(50) NOT NULL DEFAULT '' COMMENT '共享网盘UUID',
    `desktop_uuid`         varchar(50) NOT NULL DEFAULT '' COMMENT '云桌面UUID',
    `desktop_group_uuid`   varchar(50)          DEFAULT '' COMMENT '云桌面组UUID',
    `readwrite_permission` varchar(20)          DEFAULT '' COMMENT '读写权限:readwrite:读写,readonly: 只读',
    `createtime`           datetime             DEFAULT NULL COMMENT '创建时间',
    `createpin`            varchar(100)         DEFAULT NULL COMMENT '创建人',
    `updatetime`           datetime             DEFAULT NULL COMMENT '修改时间',
    `updatepin`            varchar(100)         DEFAULT NULL COMMENT '修改人',
    `yn`                   tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='共享网盘云桌面关联表';

-- ----------------------------
-- Table structure for des_cloud_disk_desktop_group
-- ----------------------------
DROP TABLE IF EXISTS `des_cloud_disk_desktop_group`;
CREATE TABLE `des_cloud_disk_desktop_group`
(
    `uuid`               varchar(50) NOT NULL COMMENT '主键UUID',
    `cloud_disk_uuid`    varchar(50)  DEFAULT NULL COMMENT '共享网盘UUID',
    `desktop_group_uuid` varchar(50)  DEFAULT NULL COMMENT '云桌面组UUID',
    `createtime`         datetime     DEFAULT NULL COMMENT '创建时间',
    `createpin`          varchar(100) DEFAULT NULL COMMENT '创建人',
    `updatetime`         datetime     DEFAULT NULL COMMENT '修改时间',
    `updatepin`          varchar(100) DEFAULT NULL COMMENT '修改人',
    `yn`                 tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='共享网盘桌面组关联表';

-- ----------------------------
-- Table structure for des_iso
-- ----------------------------
DROP TABLE IF EXISTS `des_iso`;
CREATE TABLE `des_iso`
(
    `uuid`       varchar(50) NOT NULL COMMENT 'uuid',
    `name`       varchar(20)  DEFAULT NULL COMMENT 'iso名称',
    `iso_type`   char(10)     DEFAULT NULL COMMENT 'iso类型 software：软件包 system：系统包 tool：工具包',
    `size`       bigint(20) DEFAULT NULL COMMENT '大小(字节)',
    `iso_path`   varchar(200) DEFAULT '' COMMENT '路径',
    `os`         varchar(50)  DEFAULT '' COMMENT '系统 win7 win10 linux 麒麟 统信',
    `createtime` datetime     DEFAULT NULL COMMENT '创建时间',
    `createpin`  varchar(255) DEFAULT '' COMMENT '创建人',
    `updatetime` datetime     DEFAULT NULL COMMENT '修改时间',
    `updatepin`  varchar(255) DEFAULT '' COMMENT '修改人',
    `yn`         tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='iso';

-- ----------------------------
-- Table structure for des_shared_disk
-- ----------------------------
DROP TABLE IF EXISTS `des_shared_disk`;
CREATE TABLE `des_shared_disk`
(
    `uuid`          varchar(50) NOT NULL COMMENT '主键UUID',
    `name`          varchar(100) DEFAULT NULL COMMENT '名称',
    `size`          int(11) DEFAULT NULL COMMENT '大小',
    `template_uuid` varchar(50)  DEFAULT NULL COMMENT '模板uuid',
    `path`          varchar(200) DEFAULT '' COMMENT '存储路径',
    `type`          varchar(20)  DEFAULT NULL COMMENT '类型',
    `client_uuid`   varchar(50)  DEFAULT NULL COMMENT '客户端uuid',
    `desktop_uuid`  varchar(50)  DEFAULT NULL COMMENT '云桌面uuid',
    `user_uuid`     varchar(50)  DEFAULT NULL COMMENT '用户uuid',
    `createtime`    datetime     DEFAULT NULL COMMENT '创建时间',
    `createpin`     varchar(100) DEFAULT NULL COMMENT '创建人',
    `updatetime`    datetime     DEFAULT NULL COMMENT '修改时间',
    `updatepin`     varchar(100) DEFAULT NULL COMMENT '修改人',
    `yn`            tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='共享盘表';

-- ----------------------------
-- Table structure for des_shared_disk_desktop
-- ----------------------------
DROP TABLE IF EXISTS `des_shared_disk_desktop`;
CREATE TABLE `des_shared_disk_desktop`
(
    `uuid`             varchar(50) NOT NULL,
    `shared_disk_uuid` varchar(50) NOT NULL DEFAULT '' COMMENT '共享盘uuid',
    `client_uuid`      varchar(50)          DEFAULT '' COMMENT '客户机uuid',
    `desktop_uuid`     varchar(50) NOT NULL DEFAULT '' COMMENT '云桌面uuid',
    `createtime`       datetime             DEFAULT NULL COMMENT '创建时间',
    `createpin`        varchar(50)          DEFAULT NULL COMMENT '创建人',
    `updatetime`       datetime             DEFAULT NULL COMMENT '修改时间',
    `updatepin`        varchar(50)          DEFAULT '' COMMENT '修改人',
    `yn`               tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='共享盘云桌面关联关系表';

-- ----------------------------
-- Table structure for des_shared_disk_file
-- ----------------------------
DROP TABLE IF EXISTS `des_shared_disk_file`;
CREATE TABLE `des_shared_disk_file`
(
    `uuid`             varchar(50) CHARACTER SET utf8mb4 NOT NULL COMMENT '主键uuid',
    `shared_disk_uuid` varchar(50) CHARACTER SET utf8mb4  DEFAULT '' COMMENT '所属共享盘',
    `name`             varchar(60) CHARACTER SET utf8mb4  DEFAULT '' COMMENT '名称',
    `path`             varchar(200) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '文件路径',
    `size`             bigint(20) DEFAULT 0 COMMENT '文件大小',
    `type`             varchar(50) CHARACTER SET utf8mb4  DEFAULT '' COMMENT '类型',
    `torrent_status`   varchar(20) CHARACTER SET utf8mb4  DEFAULT '',
    `task_uuid`        bigint(20) DEFAULT NULL,
    `conf_no`          int(11) DEFAULT 0 COMMENT '配置版本号',
    `createtime`       datetime                           DEFAULT NULL COMMENT '创建时间',
    `createpin`        varchar(100) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '创建人',
    `updatetime`       datetime                           DEFAULT NULL COMMENT '修改时间',
    `updatepin`        varchar(100) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '修改人',
    `yn`               tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='共享盘文件详细信息';

-- ----------------------------
-- Table structure for des_shared_disk_template
-- ----------------------------
DROP TABLE IF EXISTS `des_shared_disk_template`;
CREATE TABLE `des_shared_disk_template`
(
    `uuid`         varchar(50) NOT NULL COMMENT '主键UUID',
    `name`         varchar(50)  DEFAULT NULL COMMENT '名称',
    `size`         int(11) DEFAULT NULL COMMENT '大小',
    `path`         varchar(200) DEFAULT '' COMMENT '存储路径',
    `default_flag` tinyint(2) DEFAULT 0 COMMENT '是否为默认共享盘模板 0否 1是',
    `createtime`   datetime     DEFAULT NULL COMMENT '创建时间',
    `createpin`    varchar(100) DEFAULT NULL COMMENT '创建人',
    `updatetime`   datetime     DEFAULT NULL COMMENT '修改时间',
    `updatepin`    varchar(100) DEFAULT NULL COMMENT '修改人',
    `yn`           tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='voi共享盘模板表';

-- ----------------------------
-- Records of des_shared_disk_template
-- ----------------------------
INSERT INTO `klcloud_fsd`.`des_shared_disk_template` (`uuid`, `name`, `size`, `path`, `default_flag`, `createtime`,
                                                      `createpin`, `updatetime`, `updatepin`, `yn`)
VALUES ('00001', '低配', '5', '', '1', '2022-04-26 12:58:48', NULL, NULL, NULL, '1');
INSERT INTO `klcloud_fsd`.`des_shared_disk_template` (`uuid`, `name`, `size`, `path`, `default_flag`, `createtime`,
                                                      `createpin`, `updatetime`, `updatepin`, `yn`)
VALUES ('00002', '标准', '10', '', '1', '2022-04-26 11:59:57', NULL, NULL, NULL, '1');
INSERT INTO `klcloud_fsd`.`des_shared_disk_template` (`uuid`, `name`, `size`, `path`, `default_flag`, `createtime`,
                                                      `createpin`, `updatetime`, `updatepin`, `yn`)
VALUES ('00003', '高配', '50', '', '1', '2022-04-26 11:01:17', NULL, NULL, NULL, '1');


-- ----------------------------
-- Table structure for des_desktop_backup
-- ----------------------------
DROP TABLE IF EXISTS `des_desktop_backup`;
CREATE TABLE `des_desktop_backup`
(
    `uuid`             varchar(50) NOT NULL COMMENT '主键UUID',
    `desktop_uuid`     varchar(50)  DEFAULT '' COMMENT '云桌面UUID',
    `name`             varchar(100) DEFAULT '' COMMENT '备份文件名称',
    `path`             varchar(150) DEFAULT '' COMMENT '备份文件存储路径',
    `size`             int(11) DEFAULT NULL COMMENT '大小',
    `description`      varchar(150) DEFAULT '' COMMENT '描述',
    `is_forced_reboot` tinyint(2) DEFAULT 0 COMMENT '是否强制重启:0-否 1-是',
    `status`           varchar(30)  DEFAULT '' COMMENT '状态',
    `createtime`       datetime     DEFAULT NULL COMMENT '创建时间',
    `createpin`        varchar(100) DEFAULT NULL COMMENT '创建人',
    `updatetime`       datetime     DEFAULT NULL COMMENT '修改时间',
    `updatepin`        varchar(100) DEFAULT NULL COMMENT '修改人',
    `yn`               tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='备份共享盘文件表';