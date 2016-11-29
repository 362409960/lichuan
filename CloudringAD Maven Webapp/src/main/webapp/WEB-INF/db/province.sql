/*
Navicat MySQL Data Transfer

Source Server         : 192.168.1.111
Source Server Version : 50533
Source Host           : 192.168.1.111:3306
Source Database       : cloudringesbwebdb

Target Server Type    : MYSQL
Target Server Version : 50533
File Encoding         : 65001

Date: 2015-12-22 17:55:37
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for province
-- ----------------------------
DROP TABLE IF EXISTS `province`;
CREATE TABLE `province` (
  `serialId` int(3) NOT NULL AUTO_INCREMENT,
  `provinceId` varchar(20) DEFAULT NULL,
  `provinceName` varchar(20) DEFAULT NULL,
  `provinceUpId` varchar(20) DEFAULT NULL,
  `provinceUpIdNum` int(11) DEFAULT NULL,
  `provincePath` varchar(100) DEFAULT NULL,
  `provinceType` varchar(20) DEFAULT NULL,
  `provinceTypeNum` int(11) DEFAULT NULL,
  `shortName` varchar(11) DEFAULT NULL,
  `spell` varchar(11) DEFAULT NULL,
  `areaId` varchar(11) DEFAULT NULL,
  `postCode` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`serialId`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of province
-- ----------------------------
INSERT INTO `province` VALUES ('1', '001001', '北京', '001', '0', '中国/北京', '市', '2', 'bj', 'beijing', '010', '100000');
INSERT INTO `province` VALUES ('2', '001002', '天津', '001', '0', '中国/天津', '市', '2', 'tj', 'tianjin', '022', '300000');
INSERT INTO `province` VALUES ('3', '001003', '河北', '001', '0', '中国/河北', '省', '2', 'hb', 'hebei', 'null', 'null');
INSERT INTO `province` VALUES ('4', '001004', '山西', '001', '0', '中国/山西', '省', '2', 'sx', 'shanxi', 'null', 'null');
INSERT INTO `province` VALUES ('5', '001005', '内蒙古', '001', '0', '中国/内蒙古', '自治区', '2', 'nmg', 'neimenggu', 'null', 'null');
INSERT INTO `province` VALUES ('6', '001006', '辽宁', '001', '0', '中国/辽宁', '省', '2', 'ln', 'liaoning', 'null', 'null');
INSERT INTO `province` VALUES ('7', '001007', '吉林', '001', '0', '中国/吉林', '省', '2', 'jl', 'jilin', 'null', 'null');
INSERT INTO `province` VALUES ('8', '001008', '黑龙江', '001', '0', '中国/黑龙江', '省', '2', 'hlj', 'heilongjian', 'null', 'null');
INSERT INTO `province` VALUES ('9', '001009', '上海', '001', '0', '中国/上海', '市', '2', 'sh', 'shanghai', '021', '200000');
INSERT INTO `province` VALUES ('10', '001010', '江苏', '001', '0', '中国/江苏', '省', '2', 'js', 'jiangsu', 'null', 'null');
INSERT INTO `province` VALUES ('11', '001011', '浙江', '001', '0', '中国/浙江', '省', '2', 'zj', 'zhejiang', 'null', 'null');
INSERT INTO `province` VALUES ('12', '001012', '安徽', '001', '0', '中国/安徽', '省', '2', 'ah', 'anhui', 'null', 'null');
INSERT INTO `province` VALUES ('13', '001013', '福建', '001', '0', '中国/福建', '省', '2', 'fj', 'fujian', 'null', 'null');
INSERT INTO `province` VALUES ('14', '001014', '江西', '001', '0', '中国/江西', '省', '2', 'jx', 'jiangxi', 'null', 'null');
INSERT INTO `province` VALUES ('15', '001015', '山东', '001', '0', '中国/山东', '省', '2', 'sd', 'shandong', 'null', 'null');
INSERT INTO `province` VALUES ('16', '001016', '河南', '001', '0', '中国/河南', '省', '2', 'hn', 'henan', 'null', 'null');
INSERT INTO `province` VALUES ('17', '001017', '湖北', '001', '0', '中国/湖北', '省', '2', 'hb', 'hubei', 'null', 'null');
INSERT INTO `province` VALUES ('18', '001018', '湖南', '001', '0', '中国/湖南', '省', '2', 'hn', 'hunan', 'null', 'null');
INSERT INTO `province` VALUES ('19', '001019', '广东', '001', '0', '中国/广东', '省', '2', 'gd', 'guangdong', 'null', 'null');
INSERT INTO `province` VALUES ('20', '001020', '广西', '001', '0', '中国/广西', '壮族自治区', '2', 'gx', 'guangxi', 'null', 'null');
INSERT INTO `province` VALUES ('21', '001021', '海南', '001', '0', '中国/海南', '省', '2', 'hn', 'hainan', 'null', 'null');
INSERT INTO `province` VALUES ('22', '001022', '重庆', '001', '0', '中国/重庆', '市', '2', 'cq', 'chongqing', '023', '400000');
INSERT INTO `province` VALUES ('23', '001023', '四川', '001', '0', '中国/四川', '省', '2', 'sc', 'sichuan', 'null', 'null');
INSERT INTO `province` VALUES ('24', '001024', '贵州', '001', '0', '中国/贵州', '省', '2', 'gz', 'guizhou', 'null', 'null');
INSERT INTO `province` VALUES ('25', '001025', '云南', '001', '0', '中国/云南', '省', '2', 'yn', 'yunnan', 'null', 'null');
INSERT INTO `province` VALUES ('26', '001026', '西藏', '001', '0', '中国/西藏', '自治区', '2', 'xc', 'xicang', 'null', 'null');
INSERT INTO `province` VALUES ('27', '001027', '陕西', '001', '0', '中国/陕西', '省', '2', 'sx', 'shanxi', 'null', 'null');
INSERT INTO `province` VALUES ('28', '001028', '甘肃', '001', '0', '中国/甘肃', '省', '2', 'gs', 'gansu', 'null', 'null');
INSERT INTO `province` VALUES ('29', '001029', '青海', '001', '0', '中国/青海', '省', '2', 'qh', 'qinghai', 'null', 'null');
INSERT INTO `province` VALUES ('30', '001030', '宁夏', '001', '0', '中国/宁夏', '回族自治区', '2', 'nx', 'ningxia', 'null', 'null');
INSERT INTO `province` VALUES ('31', '001031', '新疆', '001', '0', '中国/新疆', '维吾尔自治区', '2', 'xj', 'xinjiang', 'null', 'null');
INSERT INTO `province` VALUES ('32', '001032', '香港', '001', '0', '中国/香港', '特别行政区', '2', 'xg', 'xianggang', '852', 'null');
INSERT INTO `province` VALUES ('33', '001033', '澳门', '001', '0', '中国/澳门', '特别行政区', '2', 'am', 'aomen', '853', 'null');
INSERT INTO `province` VALUES ('34', '001034', '台湾', '001', '0', '中国/台湾', '省', '2', 'tw', 'taiwan', '886', 'null');
