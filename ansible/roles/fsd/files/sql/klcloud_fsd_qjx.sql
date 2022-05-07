/*
 Navicat Premium Data Transfer

 Source Server         : 172.27.139.208
 Source Server Type    : MySQL
 Source Server Version : 100327
 Source Host           : 172.27.139.208:13306
 Source Schema         : klcloud_fsd

 Target Server Type    : MySQL
 Target Server Version : 100327
 File Encoding         : 65001

 Date: 15/04/2022 10:35:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for des_client
-- ----------------------------
DROP TABLE IF EXISTS `des_client`;
CREATE TABLE `des_client`
(
    `uuid`                 varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL COMMENT 'UUID',
    `name`                 varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL COMMENT '名称',
    `mac`                  varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '终端MAC地址',
    `type`                 varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '关联类型VOI/VDI',
    `ip`                   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'ip地址',
    `associated_user_uuid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联用户',
    `online_flag`          tinyint(2) NULL DEFAULT 0 COMMENT '是否在线 0否1是',
    `client_group_uuid`    varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL COMMENT '客户端组UUID',
    `resource_pool_uuid`   varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL COMMENT '资源池UUID',
    `connect_desktop_uuid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '当前接入云桌面UUID',
    `login_user_uuid`      varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '当前登录用户',
    `last_connect_time`    datetime(0) NULL DEFAULT NULL COMMENT '上一次连接时间',
    `last_disconnect_time` datetime(0) NULL DEFAULT NULL COMMENT '上一次断开时间',
    `last_login_user_uuid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '上一次登录用户',
    `byte_outgoing`        int(64) NULL DEFAULT 0 COMMENT '发送字节数',
    `byte_income`          int(64) NULL DEFAULT 0 COMMENT '接收字节数',
    `rate_outgoing`        int(64) NULL DEFAULT 0 COMMENT '发送速率',
    `rate_income`          int(64) NULL DEFAULT 0 COMMENT '接收速率',
    `description`          varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '描述',
    `cpu`                  int(4) NULL DEFAULT NULL COMMENT 'cpu',
    `memory`               int(4) NULL DEFAULT NULL COMMENT '内存',
    `disk`                 int(4) NULL DEFAULT NULL COMMENT '磁盘',
    `strategy_info`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '客户机策略',
    `createtime`           datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
    `createpin`            varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
    `updatetime`           datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
    `updatepin`            varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
    `yn`                   tinyint(2) NULL DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '客户机表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for des_client_group
-- ----------------------------
DROP TABLE IF EXISTS `des_client_group`;
CREATE TABLE `des_client_group`
(
    `uuid`               varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'UUID',
    `name`               varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '名称',
    `type`               varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '关联类型VOI/VDI',
    `resource_pool_uuid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源池UUID',
    `description`        varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '描述',
    `default_flag`       tinyint(2) NULL DEFAULT 0 COMMENT '是否为默认 0否 1是',
    `strategy_info`      text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '客户机策略',
    `createtime`         datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
    `createpin`          varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
    `updatetime`         datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
    `updatepin`          varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
    `yn`                 tinyint(2) NULL DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '客户机组表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for des_client_login_log
-- ----------------------------
DROP TABLE IF EXISTS `des_client_login_log`;
CREATE TABLE `des_client_login_log`
(
    `uuid`               varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `client_uuid`        varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户机uuid',
    `user_uuid`          varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户uuid',
    `connect_time`       datetime(0) NULL DEFAULT NULL COMMENT '连接时间',
    `disconnect_time`    datetime(0) NULL DEFAULT NULL COMMENT '断开时间',
    `time_to_use`        varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '使用时间',
    `resource_pool_uuid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '资源池uuid',
    `ip`                 varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'ip地址',
    `mac`                varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'mac地址',
    `createtime`         datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
    `createpin`          varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
    `updatetime`         datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
    `updatepin`          varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
    `yn`                 tinyint(2) NULL DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '客户机登录日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for des_client_queue_log
-- ----------------------------
DROP TABLE IF EXISTS `des_client_queue_log`;
CREATE TABLE `des_client_queue_log`
(
    `uuid`               varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `mac`                varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户机mac地址',
    `user_uuid`          varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户uuid',
    `resource_pool_uuid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源池uuid',
    `instance_uuid`      varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '桌面uuid',
    `createtime`         datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
    `createpin`          varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
    `updatetime`         datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
    `updatepin`          varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
    `yn`                 tinyint(2) NULL DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '客户机排队记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for des_client_user
-- ----------------------------
DROP TABLE IF EXISTS `des_client_user`;
CREATE TABLE `des_client_user`
(
    `uuid`        varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `client_uuid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户机uuid',
    `user_uuid`   varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户uuid',
    `createtime`  datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
    `createpin`   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
    `updatetime`  datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
    `updatepin`   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
    `yn`          tinyint(2) NULL DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '客户机用户关联表' ROW_FORMAT = Dynamic;
-- ----------------------------
-- Table structure for des_client_voi
-- ----------------------------
DROP TABLE IF EXISTS `des_client_voi`;
CREATE TABLE `des_client_voi` (
                                  `uuid` varchar(50) NOT NULL COMMENT 'UUID',
                                  `number_prefix` varchar(32) DEFAULT NULL COMMENT '序号前缀',
                                  `number` int(4) DEFAULT NULL COMMENT '序号',
                                  `name` varchar(50) DEFAULT NULL COMMENT '名称',
                                  `status` varchar(16) DEFAULT '' COMMENT ' 状态',
                                  `update_flag` tinyint(2) DEFAULT 0 COMMENT '编辑模式是否开启 0否1是',
                                  `mode` varchar(16) DEFAULT 'single' COMMENT '模式 单用户 single 多用户 mult 共享模式 share',
                                  `associated_user_uuid` varchar(50) DEFAULT NULL COMMENT '关联用户uuid',
                                  `mac` varchar(100) NOT NULL COMMENT '终端MAC地址',
                                  `conf_no` int(8) DEFAULT 0 COMMENT '配置版本号',
                                  `ip` varchar(16) DEFAULT '' COMMENT 'ip地址',
                                  `version` varchar(50) DEFAULT '' COMMENT '软件版本',
                                  `connect_desktop_uuid` varchar(50) DEFAULT NULL COMMENT '当前接入云桌面UUID',
                                  `disk` varchar(16) DEFAULT NULL COMMENT '磁盘',
                                  `disk_used` varchar(16) DEFAULT NULL COMMENT '磁盘已使用',
                                  `issue_status` varchar(16) DEFAULT '' COMMENT '下发状态',
                                  `command_status` varchar(16) DEFAULT '' COMMENT '命令状态',
                                  `subnet_mask` varchar(16) DEFAULT '' COMMENT '子网掩码',
                                  `default_gateway` varchar(16) DEFAULT '' COMMENT '默认网关',
                                  `first_dns` varchar(16) DEFAULT '' COMMENT '首选dns',
                                  `second_dns` varchar(16) DEFAULT '' COMMENT '备选dns',
                                  `resource_pool_uuid` varchar(50) DEFAULT NULL COMMENT '资源池UUID',
                                  `last_connect_time` datetime DEFAULT NULL COMMENT '上一次连接时间',
                                  `last_disconnect_time` datetime DEFAULT NULL COMMENT '上一次断开时间',
                                  `last_login_user_uuid` varchar(50) DEFAULT NULL COMMENT '上一次登录用户',
                                  `login_user_uuid` varchar(50) DEFAULT NULL COMMENT '当前用户登录用户',
                                  `network_rate`  varchar(32) DEFAULT NULL COMMENT '网卡速率',
                                  `memory` int(16) DEFAULT NULL COMMENT '内存',
                                  `cpu` int(16) DEFAULT NULL COMMENT 'cpu',
                                  `byte_outgoing` int(64) DEFAULT 0 COMMENT '发送字节数',
                                  `byte_income` int(64) DEFAULT 0 COMMENT '接收字节数',
                                  `rate_outgoing` int(64) DEFAULT 0 COMMENT '发送速率',
                                  `rate_income` int(64) DEFAULT 0 COMMENT '接收速率',
                                  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
                                  `createpin` varchar(100) DEFAULT NULL COMMENT '创建人',
                                  `updatetime` datetime DEFAULT NULL COMMENT '修改时间',
                                  `updatepin` varchar(100) DEFAULT NULL COMMENT '修改人',
                                  `yn` tinyint(2) DEFAULT 1 COMMENT '删除状态：1正常，0删除',
                                  `dhcp_flag` tinyint(2) DEFAULT NULL COMMENT '是否使用dhcp 0否1是',
                                  `run_ip` varchar(32) DEFAULT NULL COMMENT '运行时ip',
                                  `vnc_port` int(8) DEFAULT NULL COMMENT 'vnc默认端口号',
                                  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='客户机voi表';
-- ----------------------------
-- Table structure for des_resource_pool
-- ----------------------------
DROP TABLE IF EXISTS `des_resource_pool`;
CREATE TABLE `des_resource_pool`
(
    `uuid`             varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'UUID',
    `name`             varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '名称',
    `online_user_num`  int(4) NULL DEFAULT 0 COMMENT 'VDI最多在线用户数量',
    `vdi_desktop_num`  int(8) NULL DEFAULT 0 COMMENT 'VDI桌面数量',
    `vdi_cpu_num`      int(8) NULL DEFAULT 0 COMMENT 'VDI桌面CPU数量',
    `vdi_memory_num`   int(8) NULL DEFAULT 0 COMMENT 'VDI桌面内存数量',
    `vdi_storage_num`  int(8) NULL DEFAULT 0 COMMENT 'VDI桌面存储数量',
    `cloud_disk_num`   int(8) NULL DEFAULT 0 COMMENT '共享网盘数量',
    `voi_client_num`   int(8) NULL DEFAULT 0 COMMENT 'VOI客户机数量',
    `description`      varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '描述',
    `custom_user_flag` tinyint(2) NULL DEFAULT 0 COMMENT '是否为自定义用户类型 0否(全部用户)1是',
    `default_flag`     tinyint(2) NULL DEFAULT 0 COMMENT '是否为默认资源池 0否 1是',
    `createtime`       datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
    `createpin`        varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
    `updatetime`       datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
    `updatepin`        varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
    `yn`               tinyint(2) NULL DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '资源池表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for des_resource_pool_desktop_flavor
-- ----------------------------
DROP TABLE IF EXISTS `des_resource_pool_desktop_flavor`;
CREATE TABLE `des_resource_pool_desktop_flavor`
(
    `uuid`                varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'UUID',
    `resource_pool_uuid`  varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源池UUID',
    `desktop_flavor_uuid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '计算规格UUID',
    `desktop_type`        varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '关联类型voi/vdi',
    `createtime`          datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
    `createpin`           varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
    `updatetime`          datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
    `updatepin`           varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
    `yn`                  tinyint(2) NULL DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '资源池-计算规格关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for des_resource_pool_image
-- ----------------------------
DROP TABLE IF EXISTS `des_resource_pool_image`;
CREATE TABLE `des_resource_pool_image`
(
    `uuid`               varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'UUID',
    `resource_pool_uuid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源池UUID',
    `image_uuid`         varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '镜像UUID',
    `desktop_type`       varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '关联类型voi/vdi',
    `createtime`         datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
    `createpin`          varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
    `updatetime`         datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
    `updatepin`          varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
    `yn`                 tinyint(2) NULL DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '资源池-镜像关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for des_resource_pool_subnet
-- ----------------------------
DROP TABLE IF EXISTS `des_resource_pool_subnet`;
CREATE TABLE `des_resource_pool_subnet`
(
    `uuid`               varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'UUID',
    `resource_pool_uuid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源池UUID',
    `subnet_uuid`        varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '网络UUID',
    `desktop_type`       varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '关联类型voi/VDI',
    `createtime`         datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
    `createpin`          varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
    `updatetime`         datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
    `updatepin`          varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
    `yn`                 tinyint(2) NULL DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '资源池-子网关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for des_resource_pool_user
-- ----------------------------
DROP TABLE IF EXISTS `des_resource_pool_user`;
CREATE TABLE `des_resource_pool_user`
(
    `uuid`               varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'UUID',
    `resource_pool_uuid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源池UUID',
    `user_uuid`          varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户UUID',
    `createtime`         datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
    `createpin`          varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
    `updatetime`         datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
    `updatepin`          varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
    `yn`                 tinyint(2) NULL DEFAULT 1 COMMENT '删除状态：1正常，0删除',
    PRIMARY KEY (`uuid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '资源池-用户关联表' ROW_FORMAT = Dynamic;
-- ----------------------------
-- init data
-- ----------------------------
INSERT INTO `des_resource_pool`(`uuid`, `name`, `online_user_num`, `vdi_desktop_num`, `vdi_cpu_num`, `vdi_memory_num`, `vdi_storage_num`, `cloud_disk_num`, `voi_client_num`, `description`, `custom_user_flag`, `default_flag`, `createtime`, `createpin`, `updatetime`, `updatepin`, `yn`) VALUES ('0', 'total', 100, 100, 500, 1000, 10000, 100, 100, NULL, 0, 0, '2022-03-10 16:21:20', NULL, '2022-03-10 16:21:20', NULL, 0);
INSERT INTO `des_resource_pool`(`uuid`, `name`, `online_user_num`, `vdi_desktop_num`, `vdi_cpu_num`, `vdi_memory_num`, `vdi_storage_num`, `cloud_disk_num`, `voi_client_num`, `description`, `custom_user_flag`, `default_flag`, `createtime`, `createpin`, `updatetime`, `updatepin`, `yn`) VALUES ('00001e4f-0520-427a-866b-93ceb112144b', 'default', 100, 100, 500, 1000, 10000, 100, 100, '默认资源池', 0, 1, '2022-03-10 16:21:20', NULL, '2022-04-13 18:31:44', '4f24d3ad-7829-4f32-899a-86381bcdc20e', 1);
-- ----------------------------
-- init client group
-- ----------------------------
INSERT INTO `des_client_group`(`uuid`, `name`, `type`, `resource_pool_uuid`, `description`, `default_flag`, `strategy_info`, `createtime`, `createpin`, `updatetime`, `updatepin`, `yn`) VALUES ('00001e4f-0520-427a-866b-93ceb112144b', 'default', 'VDI', '00001e4f-0520-427a-866b-93ceb112144b', '', 1, '{\"autoCleanDelete\":1,\"canClientEdit\":1,\"clientWallpaperEdit\":1,\"shutdownIntegrationEdit\":0,\"configureResolution\":1,\"loginLogoStyle\":0,\"loginLogoUrl\":\"/client/loginLogo/\",\"protocolEdit\":1,\"resolutionRatio\":\"1920*1080\",\"setPassword\":1,\"taskEdit\":1,\"uuid\":\"\",\"wallpaperStyle\":0,\"wallpaperUrl\":\"/client/wallpaper/\",\"autoCleanDeleteTime\":30,\"password\":\"123456\",\"loginLogoName\":\"4285beda-acaa-4369-8eef-a0c5fe061688.png\",\"wallpaperName\":\"6f26cbc6-12c9-47fe-88e9-758304f24056.png\",\"defaultLoginLogoName\":\"980b5c45-955e-4532-9796-e054a271380a.png\",\"defaultWallpaperName\":\"0768db48-d4f5-43ca-8487-4d4461805bb8.jpg\"}', '2022-04-08 11:10:00', '95f86d44-32c0-4357-b1ef-1ed7f75a9c83', '2022-04-14 10:16:03', '77bcc7d5-aab5-4a73-a60e-a25ed91975ea', 1);

SET FOREIGN_KEY_CHECKS = 1;
