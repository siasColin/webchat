/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50527
 Source Host           : localhost:3306
 Source Schema         : webchatnew

 Target Server Type    : MySQL
 Target Server Version : 50527
 File Encoding         : 65001

 Date: 10/12/2019 11:00:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for friend
-- ----------------------------
DROP TABLE IF EXISTS `friend`;
CREATE TABLE `friend`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `friend_id` int(11) NULL DEFAULT NULL COMMENT '好友id',
  `build_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立时间',
  `type_id` int(11) NULL DEFAULT NULL COMMENT '好友分组id',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '好友备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 92 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '好友表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of friend
-- ----------------------------
INSERT INTO `friend` VALUES (72, 12, 11, '2019-12-09 11:08:16', 26, ' ');
INSERT INTO `friend` VALUES (73, 11, 12, '2019-12-09 11:08:16', 37, ' ');
INSERT INTO `friend` VALUES (74, 12, 13, '2019-12-09 11:09:59', 27, ' ');
INSERT INTO `friend` VALUES (75, 13, 12, '2019-12-09 11:09:59', 39, ' ');
INSERT INTO `friend` VALUES (76, 12, 10, '2019-12-09 11:11:09', 28, ' ');
INSERT INTO `friend` VALUES (77, 10, 12, '2019-12-09 11:11:09', 40, ' ');
INSERT INTO `friend` VALUES (80, 104, 13, '2019-12-09 11:16:45', 31, '');
INSERT INTO `friend` VALUES (81, 13, 104, '2019-12-09 11:16:45', 38, ' ');
INSERT INTO `friend` VALUES (82, 104, 12, '2019-12-09 11:17:35', 33, ' ');
INSERT INTO `friend` VALUES (83, 12, 104, '2019-12-09 11:17:35', 29, ' ');
INSERT INTO `friend` VALUES (88, 104, 10, '2019-12-09 11:41:32', 34, '');
INSERT INTO `friend` VALUES (90, 104, 11, '2019-12-09 18:40:49', 32, '');
INSERT INTO `friend` VALUES (91, 11, 104, '2019-12-09 18:40:49', 36, '');

-- ----------------------------
-- Table structure for friend_message
-- ----------------------------
DROP TABLE IF EXISTS `friend_message`;
CREATE TABLE `friend_message`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_user_id` int(11) NULL DEFAULT NULL COMMENT '发消息的人的id',
  `to_user_id` int(11) NULL DEFAULT NULL COMMENT '收消息的人的id',
  `content` varchar(4000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '消息内容',
  `send_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
  `is_read` int(11) NULL DEFAULT NULL COMMENT '是否已读，1是0否',
  `is_del` int(11) NULL DEFAULT NULL COMMENT '是否删除，1是0否',
  `is_back` int(11) NULL DEFAULT NULL COMMENT '是否撤回，1是0否',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '好友消息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for friend_type
-- ----------------------------
DROP TABLE IF EXISTS `friend_type`;
CREATE TABLE `friend_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键\r\n            ',
  `type_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分组名',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `build_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_default` int(11) NULL DEFAULT 0 COMMENT '是否为默认分组：1为默认，0为不是默认分组',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '好友分组' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of friend_type
-- ----------------------------
INSERT INTO `friend_type` VALUES (1, '研发中心', 10, '2017-01-16 21:11:45', 1);
INSERT INTO `friend_type` VALUES (2, '财务中心', 11, '2017-01-16 21:12:12', 1);
INSERT INTO `friend_type` VALUES (3, '人力资源部', 12, '2017-01-16 21:12:25', 1);
INSERT INTO `friend_type` VALUES (4, '销售部', 13, '2017-01-16 21:12:35', 1);
INSERT INTO `friend_type` VALUES (26, '财务中心', 12, '2019-12-09 11:07:50', 0);
INSERT INTO `friend_type` VALUES (27, '销售部', 12, '2019-12-09 11:10:14', 0);
INSERT INTO `friend_type` VALUES (28, '研发中心', 12, '2019-12-09 11:11:25', 0);
INSERT INTO `friend_type` VALUES (29, '管理中心', 12, '2019-12-09 11:12:04', 0);
INSERT INTO `friend_type` VALUES (30, '管理中心', 104, '2019-12-09 11:14:14', 0);
INSERT INTO `friend_type` VALUES (31, '销售部', 104, '2019-12-09 11:15:04', 0);
INSERT INTO `friend_type` VALUES (32, '财务中心', 104, '2019-12-09 11:15:10', 0);
INSERT INTO `friend_type` VALUES (33, '人力资源部', 104, '2019-12-09 11:15:17', 0);
INSERT INTO `friend_type` VALUES (34, '研发中心', 104, '2019-12-09 11:15:25', 0);
INSERT INTO `friend_type` VALUES (35, '杭州气象局', 16, '2019-12-09 11:21:45', 0);
INSERT INTO `friend_type` VALUES (36, '管理中心', 11, '2019-12-09 11:43:08', 0);
INSERT INTO `friend_type` VALUES (37, '人力资源部', 11, '2019-12-09 11:43:25', 0);
INSERT INTO `friend_type` VALUES (38, '管理中心', 13, '2019-12-09 11:45:10', 0);
INSERT INTO `friend_type` VALUES (39, '销售部', 13, '2019-12-09 11:45:16', 0);
INSERT INTO `friend_type` VALUES (40, '人力资源部', 10, '2019-12-09 11:46:14', 0);

-- ----------------------------
-- Table structure for group_message
-- ----------------------------
DROP TABLE IF EXISTS `group_message`;
CREATE TABLE `group_message`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `group_id` int(11) NULL DEFAULT NULL COMMENT '群id',
  `content` varchar(4000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '群消息内容',
  `is_del` int(11) NULL DEFAULT NULL COMMENT '是否删除，1是 0否',
  `is_read` int(11) NULL DEFAULT NULL COMMENT '是否已读，1是，0否。',
  `send_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_back` int(11) NULL DEFAULT NULL COMMENT '是否撤回，1是 0否',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '群消息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for group_user
-- ----------------------------
DROP TABLE IF EXISTS `group_user`;
CREATE TABLE `group_user`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `group_id` int(11) NULL DEFAULT NULL COMMENT '群id\r\n            ',
  `join_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入群时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '我的群昵称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '群成员表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of group_user
-- ----------------------------
INSERT INTO `group_user` VALUES (56, 10, 24, '2019-12-09 11:28:30', '研发中心管理员');
INSERT INTO `group_user` VALUES (57, 11, 24, '2019-12-09 11:28:30', '财务中心管理员');
INSERT INTO `group_user` VALUES (58, 12, 24, '2019-12-09 11:28:30', '人力资源部管理员');
INSERT INTO `group_user` VALUES (59, 13, 24, '2019-12-09 11:28:30', '销售部管理员');
INSERT INTO `group_user` VALUES (60, 104, 24, '2019-12-09 11:28:38', '超级管理员');

-- ----------------------------
-- Table structure for t_group
-- ----------------------------
DROP TABLE IF EXISTS `t_group`;
CREATE TABLE `t_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键\r\n            ',
  `group_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '群号',
  `group_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '群名称',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `build_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '群' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_group
-- ----------------------------
INSERT INTO `t_group` VALUES (23, 'tflsyjhs', '台风蓝色预警会商', '/images/boy-01.png', 1, '2019-12-09 10:34:44', '会议讨论', NULL);
INSERT INTO `t_group` VALUES (24, 'tflsyjhs', '台风蓝色预警会商', '/images/boy-01.png', 104, '2019-12-09 11:28:16', '讨论群组', NULL);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '帐号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `nick_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `gender` int(11) NULL DEFAULT 0 COMMENT '性别：0为男，1为女',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮箱',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `role_code` int(11) NULL DEFAULT 1 COMMENT '角色code：1为用户，2为管理员',
  `version` varchar(0) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sign` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `systemuserid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关系业务平台登录用户ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 108 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (9, 'sxf', '0', 'sxf', 0, '/images/boy-02.png', NULL, NULL, 1, NULL, '个性签名', '355247153091706880');
INSERT INTO `t_user` VALUES (10, 'yf', '0', '研发中心管理员', 0, '/images/boy-03.png', NULL, NULL, 1, NULL, '个性签名', '359574822549716992');
INSERT INTO `t_user` VALUES (11, 'cw', '0', '财务中心管理员', 0, '/images/boy-01.png', NULL, NULL, 1, NULL, '个性签名', '359575208929001472');
INSERT INTO `t_user` VALUES (12, 'rl', '0', '人力资源部管理员', 0, '/images/boy-01.png', NULL, NULL, 1, NULL, '个性签名', '359575690774839296');
INSERT INTO `t_user` VALUES (13, 'xs', '0', '销售部管理员', 0, '/images/boy-03.png', NULL, NULL, 1, NULL, '个性签名', '359575982824226816');
INSERT INTO `t_user` VALUES (104, 'admin', '0', '超级管理员', 0, '/images/boy-17.png', NULL, NULL, 2, NULL, '个性签名', '1');

SET FOREIGN_KEY_CHECKS = 1;
