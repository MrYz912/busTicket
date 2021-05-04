/*
 Navicat Premium Data Transfer

 Source Server         : bus_ticket
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : localhost:3306
 Source Schema         : bus_ticket

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : 65001

 Date: 04/05/2021 13:55:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for advice
-- ----------------------------
DROP TABLE IF EXISTS `advice`;
CREATE TABLE `advice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `userId` int(11) NOT NULL,
  `userName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `time` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE,
  CONSTRAINT `advice_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of advice
-- ----------------------------
INSERT INTO `advice` VALUES (1, 'hello world', 1, '杨振', '省汽车站-佛山汽车站', '2021-04-06 17:30:00.000000', '18200897562', '2021-04-06 18:12:27.285008', '2021-04-06 18:19:55.958972');
INSERT INTO `advice` VALUES (2, '你好，反馈问题，你们车站有非常大的问题', 1, '杨振', '省汽车站-佛山汽车站', '2021-04-06 20:00:00.000000', '18200897562', '2021-04-09 18:22:35.358138', '2021-04-09 18:36:10.877104');
INSERT INTO `advice` VALUES (3, '有个留言', 1, '杨振', '省汽车站-佛山汽车站', '2021-04-10 12:30:00.000000', '18200897562', '2021-04-11 09:00:44.882904', '2021-04-11 09:00:44.882904');

-- ----------------------------
-- Table structure for bus
-- ----------------------------
DROP TABLE IF EXISTS `bus`;
CREATE TABLE `bus`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license_plate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `seat` int(11) NULL DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bus
-- ----------------------------

-- ----------------------------
-- Table structure for bus2driver
-- ----------------------------
DROP TABLE IF EXISTS `bus2driver`;
CREATE TABLE `bus2driver`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `busId` int(11) NULL DEFAULT NULL,
  `driverId` int(11) NULL DEFAULT NULL,
  `created_at` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `busId`(`busId`) USING BTREE,
  INDEX `driverId`(`driverId`) USING BTREE,
  CONSTRAINT `bus2driver_ibfk_1` FOREIGN KEY (`busId`) REFERENCES `bus` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `bus2driver_ibfk_2` FOREIGN KEY (`driverId`) REFERENCES `driver` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bus2driver
-- ----------------------------

-- ----------------------------
-- Table structure for busstation
-- ----------------------------
DROP TABLE IF EXISTS `busstation`;
CREATE TABLE `busstation`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cityId` int(11) NOT NULL,
  `station` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cityId`(`cityId`) USING BTREE,
  CONSTRAINT `busstation_ibfk_1` FOREIGN KEY (`cityId`) REFERENCES `city` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 107 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of busstation
-- ----------------------------
INSERT INTO `busstation` VALUES (1, 1, '省汽车站', '越秀区环市西路145-149号', '2021-04-01 22:05:52.000000', '2021-04-01 22:05:54.000000');
INSERT INTO `busstation` VALUES (2, 1, '广州东站汽车站', '天河区禺东西路43号', '2021-04-01 22:06:51.000000', '2021-04-01 22:06:53.000000');
INSERT INTO `busstation` VALUES (3, 1, '罗冲围客运站', '广州市增槎路251-255号', '2021-04-01 22:07:41.000000', '2021-04-01 22:07:43.000000');
INSERT INTO `busstation` VALUES (4, 1, '滘口客运站', '荔湾区广佛路口芳村大道西533号', '2021-04-01 22:08:30.000000', '2021-04-01 22:08:32.000000');
INSERT INTO `busstation` VALUES (5, 1, '广州市汽车客运站', '越秀区环市西路158号', '2021-04-01 22:09:35.000000', '2021-04-01 22:09:38.000000');
INSERT INTO `busstation` VALUES (6, 1, '芳村汽车客运站', '荔湾区花地大道中51号', '2021-04-01 22:10:25.000000', '2021-04-01 22:10:27.000000');
INSERT INTO `busstation` VALUES (7, 1, '广州南站汽车站', '番禺区钟村南站南路', '2021-04-01 22:11:14.000000', '2021-04-01 22:11:16.000000');
INSERT INTO `busstation` VALUES (8, 1, '海珠客运站', '海珠区南洲路182号', '2021-04-01 22:12:54.000000', '2021-04-01 22:12:55.000000');
INSERT INTO `busstation` VALUES (9, 2, '西乡汽车站', '宝安区宝安大道4006号', '2021-04-01 22:20:03.000000', '2021-04-01 22:27:04.288994');
INSERT INTO `busstation` VALUES (10, 2, '坪山汽车站', '坪山新区深汕路119号', '2021-04-01 22:24:10.000000', '2021-04-01 22:24:13.000000');
INSERT INTO `busstation` VALUES (11, 2, '罗湖客运站', '罗湖区火车站东广场商业城1,2楼', '2021-04-01 22:24:55.000000', '2021-04-01 22:24:57.000000');
INSERT INTO `busstation` VALUES (12, 2, '福田汽车站', '深南大道福安大厦1,2楼', '2021-04-01 22:25:55.000000', '2021-04-01 22:29:08.039597');
INSERT INTO `busstation` VALUES (13, 2, '松岗汽车站', '宝安区松白路37号', '2021-04-01 22:26:53.000000', '2021-04-01 22:26:55.000000');
INSERT INTO `busstation` VALUES (14, 3, '佛山汽车站', '禅城区汾江中路6号', '2021-04-02 14:11:11.000000', '2021-04-02 14:11:13.000000');
INSERT INTO `busstation` VALUES (15, 3, '容桂客运站', '顺德区容桂街道文海中路2号', '2021-04-02 14:19:15.000000', '2021-04-02 14:19:17.000000');
INSERT INTO `busstation` VALUES (16, 3, '高明客运站', '高明区荷城街道高明大道东123号', '2021-04-02 14:20:02.000000', '2021-04-02 14:20:05.000000');
INSERT INTO `busstation` VALUES (17, 3, '石湾汽车客运站', '石湾江湾二路9号', '2021-04-02 14:22:47.000000', '2021-04-02 14:22:49.000000');
INSERT INTO `busstation` VALUES (18, 3, '顺德汽车客运总站', '顺德区南国中路与105国道交汇处', '2021-04-02 14:23:59.000000', '2021-04-02 14:24:01.000000');
INSERT INTO `busstation` VALUES (19, 4, '东莞南城汽车站', '南城区车站路', '2021-04-02 14:25:14.000000', '2021-04-02 14:25:16.000000');
INSERT INTO `busstation` VALUES (20, 4, '东莞汽车站', '万江曲海四环路与新万道道路交汇处', '2021-04-02 14:25:50.000000', '2021-04-02 14:25:52.000000');
INSERT INTO `busstation` VALUES (21, 4, '虎门汽车客运站', '虎门镇人民北路博美路段81号', '2021-04-02 14:35:55.000000', '2021-04-02 14:35:57.000000');
INSERT INTO `busstation` VALUES (22, 4, '长安汽车站', '长安镇358省道2号金钟大厦', '2021-04-02 14:51:25.000000', '2021-04-02 14:51:27.000000');
INSERT INTO `busstation` VALUES (23, 4, '樟木头汽车站', '樟木头镇维多利大道旁', '2021-04-02 14:52:16.000000', '2021-04-02 14:52:18.000000');
INSERT INTO `busstation` VALUES (24, 5, '拱北汽车客运站', '拱北莲花路1号', '2021-04-02 15:21:54.000000', '2021-04-02 15:21:56.000000');
INSERT INTO `busstation` VALUES (25, 5, '香洲长途汽车站', '香洲区紫荆路142号', '2021-04-02 15:23:34.000000', '2021-04-02 15:23:36.000000');
INSERT INTO `busstation` VALUES (26, 5, '吉大汽车站', '吉大国贸海天城侧', '2021-04-02 15:24:46.000000', '2021-04-02 15:24:48.000000');
INSERT INTO `busstation` VALUES (27, 5, '平沙汽车客运站', '金湾区迎雁路141号', '2021-04-02 15:26:02.000000', '2021-04-02 15:26:05.000000');
INSERT INTO `busstation` VALUES (28, 5, '斗门汽车客运站', '金湾区连桥路389号', '2021-04-02 15:29:50.000000', '2021-04-02 15:29:52.000000');
INSERT INTO `busstation` VALUES (29, 6, '中山汽车总站', '石岐本西区富华道与105国道交汇处', '2021-04-02 15:44:38.000000', '2021-04-02 15:44:39.000000');
INSERT INTO `busstation` VALUES (30, 6, '中山城东汽车站', '火炬开发区逸仙公路口北侧边架围', '2021-04-02 15:45:33.000000', '2021-04-02 15:45:36.000000');
INSERT INTO `busstation` VALUES (31, 6, '中山南朗汽车站', '中山市南岐中路', '2021-04-02 15:47:28.000000', '2021-04-02 15:47:30.000000');
INSERT INTO `busstation` VALUES (32, 6, '中山小榄汽车站', '中山市小榄大道北', '2021-04-02 15:49:43.000000', '2021-04-02 15:49:45.000000');
INSERT INTO `busstation` VALUES (33, 1, '天河客运站', '天河区上元岗广汕公路旁', '2021-04-14 22:00:39.000000', '2021-04-14 22:03:25.789261');
INSERT INTO `busstation` VALUES (34, 1, '广园客运站', '白云区广园中路283号', '2021-04-14 22:03:07.000000', '2021-04-14 22:03:09.000000');
INSERT INTO `busstation` VALUES (35, 7, '英德汽车站', '英城浈阳中路1号', '2021-04-24 14:20:18.000000', '2021-04-24 14:20:20.000000');
INSERT INTO `busstation` VALUES (36, 7, '连南汽车站', '顺德大道(近府前路)', '2021-04-24 14:27:51.000000', '2021-04-24 14:27:53.000000');
INSERT INTO `busstation` VALUES (37, 7, '清新汽车站', '清新县清和大道162号', '2021-04-24 14:29:30.000000', '2021-04-24 14:29:31.000000');
INSERT INTO `busstation` VALUES (38, 7, '佛冈汽车站', '园山街与福田路交叉口旁', '2021-04-24 14:30:10.000000', '2021-04-24 14:30:12.000000');
INSERT INTO `busstation` VALUES (39, 7, '阳山汽车客运站', '韩愈路22号', '2021-04-24 14:32:39.000000', '2021-04-24 14:32:40.000000');
INSERT INTO `busstation` VALUES (40, 8, '翁源汽车站', '翁源县建设一路76号', '2021-04-24 14:35:29.000000', '2021-04-24 14:35:31.000000');
INSERT INTO `busstation` VALUES (41, 8, '乳源汽车客运站', '乳源县城鲜明南路一号', '2021-04-24 14:46:08.000000', '2021-04-24 14:46:10.000000');
INSERT INTO `busstation` VALUES (42, 8, '仁化汽车客运站', '仁化县其他建设路135-2号', '2021-04-24 14:46:49.000000', '2021-04-24 14:46:51.000000');
INSERT INTO `busstation` VALUES (43, 8, '乐昌汽车客运站', '乐昌市人民南路9号', '2021-04-24 14:48:34.000000', '2021-04-24 14:48:36.000000');
INSERT INTO `busstation` VALUES (44, 8, '南雄汽车站', '南雄市雄州街道站前路16号', '2021-04-24 14:49:18.000000', '2021-04-24 14:49:20.000000');
INSERT INTO `busstation` VALUES (45, 9, '江门汽车总站', '蓬江区建设路42号', '2021-04-24 14:50:21.000000', '2021-04-24 14:50:22.000000');
INSERT INTO `busstation` VALUES (46, 9, '恩平汽车总站', '恩平市恩城镇新平中路49号', '2021-04-24 14:51:00.000000', '2021-04-24 14:51:02.000000');
INSERT INTO `busstation` VALUES (47, 9, '开平汽车站', '开平市长沙西郊28号', '2021-04-24 14:52:04.000000', '2021-04-24 14:52:06.000000');
INSERT INTO `busstation` VALUES (48, 9, '台山汽车总站', '台城镇桥湖路41号', '2021-04-24 14:52:51.000000', '2021-04-24 14:52:52.000000');
INSERT INTO `busstation` VALUES (49, 9, '鹤山汽车总站', '鹤山市鹤山大道1098号', '2021-04-24 14:53:36.000000', '2021-04-24 14:53:37.000000');
INSERT INTO `busstation` VALUES (50, 10, '汕头汽车站', '潮汕路2号', '2021-04-24 14:54:26.000000', '2021-04-24 14:54:28.000000');
INSERT INTO `busstation` VALUES (51, 10, '潮阳汽车站', '棉城棉西路44号', '2021-04-24 14:55:18.000000', '2021-04-24 14:55:20.000000');
INSERT INTO `busstation` VALUES (52, 10, '汕头岐山汽车站', '潮汕路136号', '2021-04-24 14:56:39.000000', '2021-04-24 14:56:40.000000');
INSERT INTO `busstation` VALUES (53, 10, '潮南峡山客运站', '潮南区三二四国道', '2021-04-24 15:12:23.000000', '2021-04-24 15:12:25.000000');
INSERT INTO `busstation` VALUES (54, 10, '澄海汽车客运站', '澄海区澄城中山北路', '2021-04-24 15:13:12.000000', '2021-04-24 15:13:14.000000');
INSERT INTO `busstation` VALUES (55, 11, '湛江汽车总站', '赤坎区椹川大道北376号', '2021-04-24 15:14:15.000000', '2021-04-24 15:14:16.000000');
INSERT INTO `busstation` VALUES (56, 11, '廉江汽车总站', '廉江市中山二路1附近', '2021-04-24 15:16:42.349470', '2021-04-24 15:16:42.349470');
INSERT INTO `busstation` VALUES (57, 11, '吴川汽车总站', '吴川市解放路24号', '2021-04-24 15:17:28.488188', '2021-04-24 15:17:28.488188');
INSERT INTO `busstation` VALUES (58, 11, '麻章汽车站', '金康东路1号', '2021-04-24 15:18:18.673433', '2021-04-24 15:18:58.672180');
INSERT INTO `busstation` VALUES (59, 11, '徐闻汽车总站', '徐城镇红旗一路3号', '2021-04-24 15:19:43.398929', '2021-04-24 15:19:43.398929');
INSERT INTO `busstation` VALUES (60, 12, '茂名客运中心站', '茂南区站前四路89号', '2021-04-24 15:20:46.097645', '2021-04-24 15:21:00.951051');
INSERT INTO `busstation` VALUES (61, 12, '茂名汽车总站', '茂名市油城三路222号', '2021-04-24 15:22:19.310923', '2021-04-24 15:22:19.310923');
INSERT INTO `busstation` VALUES (62, 12, '信宜汽车站', '信宜市人民南路78号', '2021-04-24 15:23:24.769180', '2021-04-24 15:23:31.218094');
INSERT INTO `busstation` VALUES (63, 12, '电白汽车客运站', '电白区水东镇人民路29号', '2021-04-24 15:24:15.099569', '2021-04-24 15:24:15.099569');
INSERT INTO `busstation` VALUES (64, 12, '化州汽车站', '桔城中路63号', '2021-04-24 15:25:06.882039', '2021-04-24 15:25:06.882039');
INSERT INTO `busstation` VALUES (65, 13, '肇庆长途客运站', '肇庆火车站西100米', '2021-04-24 15:27:22.665916', '2021-04-24 15:28:03.324468');
INSERT INTO `busstation` VALUES (66, 13, '四会汽车站东城站', '光明南路35座7号对面', '2021-04-24 15:29:29.605880', '2021-04-24 15:29:29.605880');
INSERT INTO `busstation` VALUES (67, 13, '怀集汽车站', '怀集县怀城镇幸福一路燕都广场对面', '2021-04-24 15:30:03.633657', '2021-04-24 15:30:03.633657');
INSERT INTO `busstation` VALUES (68, 13, '高要粤运汽车站', '南岸镇要南二路1号', '2021-04-24 15:30:54.293564', '2021-04-24 15:30:54.293564');
INSERT INTO `busstation` VALUES (69, 13, '广宁粤运汽车站', '广宁县人民路21号', '2021-04-24 15:31:43.032232', '2021-04-24 15:31:43.032232');
INSERT INTO `busstation` VALUES (70, 14, '惠州汽车总站', '惠城区鹅岭北路11号', '2021-04-24 15:35:20.933975', '2021-04-24 15:35:20.933975');
INSERT INTO `busstation` VALUES (71, 14, '博罗汽车站', '博罗阳镇博惠路87号', '2021-04-24 15:46:23.286660', '2021-04-24 15:46:23.286660');
INSERT INTO `busstation` VALUES (72, 14, '惠阳汽车站', '惠阳区永兴路100号', '2021-04-24 15:59:38.449789', '2021-04-24 15:59:38.449789');
INSERT INTO `busstation` VALUES (73, 14, '惠东汽车站', '惠东县环城南路与象棋路交叉口', '2021-04-24 16:17:21.371880', '2021-04-24 16:17:21.371880');
INSERT INTO `busstation` VALUES (74, 14, '龙门汽车站', '龙门县西林路29号', '2021-04-24 16:23:56.178951', '2021-04-24 16:23:56.178951');
INSERT INTO `busstation` VALUES (75, 15, '梅州汽车总站', '梅州市梅石路2号', '2021-04-24 16:33:06.277831', '2021-04-24 16:33:06.277831');
INSERT INTO `busstation` VALUES (76, 15, '梅县新城汽车站', '梅县区广梅北路60-4', '2021-04-24 16:33:45.946751', '2021-04-24 16:33:45.946751');
INSERT INTO `busstation` VALUES (77, 15, '大埔汽车客运站', '湖寮镇畹香路33号', '2021-04-24 16:34:16.291026', '2021-04-24 16:34:16.291026');
INSERT INTO `busstation` VALUES (78, 15, '五华汽车站', '五华县水寨镇华兴南路6号', '2021-04-24 16:34:53.707694', '2021-04-24 16:34:53.707694');
INSERT INTO `busstation` VALUES (79, 15, '兴宁汽车站', '兴宁市兴城镇宁江路212号', '2021-04-24 16:43:39.053390', '2021-04-24 16:43:39.053390');
INSERT INTO `busstation` VALUES (80, 16, '汕尾粤运汽车站', '香洲街道荷包岭工业大道与汕尾大道交叉口', '2021-04-24 16:45:54.230985', '2021-04-24 16:45:54.230985');
INSERT INTO `busstation` VALUES (81, 16, '陆河汽车站', '陆河县河田镇城南社区人民南路67号', '2021-04-24 16:49:30.669414', '2021-04-24 16:49:30.669414');
INSERT INTO `busstation` VALUES (82, 16, '陆丰汽车总站', '陆丰市广汕公路旺角大厦斜对面', '2021-04-24 16:58:10.153665', '2021-04-24 16:58:10.153665');
INSERT INTO `busstation` VALUES (83, 16, '海丰客运总站', '海丰县广富路与三环西路交叉口东北角', '2021-04-24 17:01:56.406995', '2021-04-24 17:01:56.406995');
INSERT INTO `busstation` VALUES (84, 17, '河源汽车总站', '源城大桥路6号', '2021-04-24 17:03:08.630421', '2021-04-24 17:03:08.630421');
INSERT INTO `busstation` VALUES (85, 17, '紫金汽车站', '紫金县金山大道99号', '2021-04-24 17:05:01.464046', '2021-04-24 17:05:01.464046');
INSERT INTO `busstation` VALUES (86, 17, '和平汽车站', '和平县阳明镇东山路164号', '2021-04-24 17:08:47.863622', '2021-04-24 17:08:47.863622');
INSERT INTO `busstation` VALUES (87, 17, '连平汽车站', '连平县元善镇环城南路15号连运大厦附近', '2021-04-24 17:12:16.821990', '2021-04-24 17:12:16.821990');
INSERT INTO `busstation` VALUES (88, 17, '龙川汽车站', '龙川县东风路19号', '2021-04-24 17:13:56.621552', '2021-04-24 17:13:56.621552');
INSERT INTO `busstation` VALUES (89, 18, '阳江汽车总站', '江城区西平北路888号', '2021-04-24 22:15:44.055784', '2021-04-24 22:15:44.055784');
INSERT INTO `busstation` VALUES (90, 18, '阳春汽车站', '阳春市春城镇南新大道29号', '2021-04-24 22:16:38.142012', '2021-04-24 22:16:38.142012');
INSERT INTO `busstation` VALUES (91, 18, '阳东汽车站', '阳东县城湖滨西路1号', '2021-04-24 22:17:16.804533', '2021-04-24 22:17:16.804533');
INSERT INTO `busstation` VALUES (92, 18, '阳西汽车站', '阳西县迎宾大道5号', '2021-04-24 22:17:50.235179', '2021-04-24 22:17:50.235179');
INSERT INTO `busstation` VALUES (93, 18, '银岭客运站', '江城区G234(银岭大道)', '2021-04-24 22:19:14.796198', '2021-04-24 22:19:14.796198');
INSERT INTO `busstation` VALUES (94, 19, '潮州长途汽车总站', '潮州市潮枫路2号', '2021-04-24 22:20:14.866595', '2021-04-24 22:20:14.866595');
INSERT INTO `busstation` VALUES (95, 19, '潮安车站', '安南路与建业街交叉口西50米', '2021-04-24 22:21:06.301092', '2021-04-24 22:21:06.301092');
INSERT INTO `busstation` VALUES (96, 19, '饶平汽车客运站', '饶平县黄冈镇沿河北路与黄岗大道交汇处东南侧', '2021-04-24 22:22:34.877486', '2021-04-24 22:22:41.095429');
INSERT INTO `busstation` VALUES (97, 19, '饶平黄冈大厦客运站', '饶平县汽车客运站对面', '2021-04-24 22:23:55.520363', '2021-04-24 22:23:55.520363');
INSERT INTO `busstation` VALUES (98, 20, '揭阳汽车站', '榕城区榕华大道75号', '2021-04-24 22:25:00.742971', '2021-04-24 22:25:00.742971');
INSERT INTO `busstation` VALUES (99, 20, '惠来汽车站', '惠来县惠城镇南门东路58号', '2021-04-24 22:25:54.477927', '2021-04-24 22:25:54.477927');
INSERT INTO `busstation` VALUES (100, 20, '揭西汽车站', '揭西县河江大道揭西县燕龙宾馆楼下', '2021-04-24 22:27:19.884462', '2021-04-24 22:27:19.884462');
INSERT INTO `busstation` VALUES (101, 20, '普宁流沙客运站', '普宁市流沙大道西8号', '2021-04-24 22:28:21.954078', '2021-04-24 22:28:21.954078');
INSERT INTO `busstation` VALUES (102, 20, '岐山汽车站', '揭阳市榕城区晓翠路创鸿国际斜对面', '2021-04-24 22:29:17.433479', '2021-04-24 22:29:25.147337');
INSERT INTO `busstation` VALUES (103, 21, '云浮汽车站', '云城区兴云东路246号', '2021-04-24 22:30:12.921395', '2021-04-24 22:30:12.921395');
INSERT INTO `busstation` VALUES (104, 21, '罗定汽车站', '其他工业大道一路78号', '2021-04-24 22:30:46.337380', '2021-04-24 22:30:46.337380');
INSERT INTO `busstation` VALUES (105, 21, '云安汽车站', '县城宝华路28号', '2021-04-24 22:31:45.558870', '2021-04-24 22:31:45.558870');
INSERT INTO `busstation` VALUES (106, 21, '郁南汽车站', '郁南县都城镇工业大道24号', '2021-04-24 22:32:22.488229', '2021-04-24 22:32:22.488229');
INSERT INTO `busstation` VALUES (107, 21, '新兴汽车站', '新兴县新城镇环城北路183号', '2021-04-24 22:32:53.564595', '2021-04-24 22:32:53.564595');

-- ----------------------------
-- Table structure for city
-- ----------------------------
DROP TABLE IF EXISTS `city`;
CREATE TABLE `city`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cityName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of city
-- ----------------------------
INSERT INTO `city` VALUES (1, '广州', '2021-04-01 18:22:23.000000', '2021-04-01 18:22:28.000000');
INSERT INTO `city` VALUES (2, '深圳', '2021-04-01 18:47:03.000000', '2021-04-01 18:47:06.000000');
INSERT INTO `city` VALUES (3, '佛山', '2021-04-01 18:47:28.000000', '2021-04-01 23:25:05.580256');
INSERT INTO `city` VALUES (4, '东莞', '2021-04-01 18:47:56.000000', '2021-04-01 23:25:09.892138');
INSERT INTO `city` VALUES (5, '珠海', '2021-04-01 18:48:20.000000', '2021-04-01 23:25:12.832373');
INSERT INTO `city` VALUES (6, '中山', '2021-04-01 18:48:51.000000', '2021-04-01 23:25:16.172118');
INSERT INTO `city` VALUES (7, '清远', '2021-04-01 18:49:09.000000', '2021-04-01 23:25:19.198624');
INSERT INTO `city` VALUES (8, '韶关', '2021-04-01 18:49:30.000000', '2021-04-01 23:25:22.560633');
INSERT INTO `city` VALUES (9, '江门', '2021-04-01 18:49:44.000000', '2021-04-01 23:25:26.081037');
INSERT INTO `city` VALUES (10, '汕头', '2021-04-01 18:50:07.000000', '2021-04-01 23:25:30.669003');
INSERT INTO `city` VALUES (11, '湛江', '2021-04-01 18:50:21.000000', '2021-04-01 23:25:33.460191');
INSERT INTO `city` VALUES (12, '茂名', '2021-04-01 18:50:33.000000', '2021-04-01 23:25:36.141446');
INSERT INTO `city` VALUES (13, '肇庆', '2021-04-01 18:50:47.000000', '2021-04-01 23:25:38.970848');
INSERT INTO `city` VALUES (14, '惠州', '2021-04-01 18:50:58.000000', '2021-04-01 23:25:41.339514');
INSERT INTO `city` VALUES (15, '梅州', '2021-04-01 18:51:14.000000', '2021-04-01 23:25:44.228832');
INSERT INTO `city` VALUES (16, '汕尾', '2021-04-01 18:51:25.000000', '2021-04-01 23:25:46.737795');
INSERT INTO `city` VALUES (17, '河源', '2021-04-01 18:51:36.000000', '2021-04-01 23:25:49.222720');
INSERT INTO `city` VALUES (18, '阳江', '2021-04-01 18:51:55.000000', '2021-04-01 23:25:51.926569');
INSERT INTO `city` VALUES (19, '潮州', '2021-04-01 18:52:18.000000', '2021-04-01 23:25:57.625916');
INSERT INTO `city` VALUES (20, '揭阳', '2021-04-01 18:52:30.000000', '2021-04-01 23:26:01.740606');
INSERT INTO `city` VALUES (21, '云浮', '2021-04-01 18:52:47.000000', '2021-04-01 23:26:04.786352');

-- ----------------------------
-- Table structure for driver
-- ----------------------------
DROP TABLE IF EXISTS `driver`;
CREATE TABLE `driver`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `age` int(11) NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of driver
-- ----------------------------

-- ----------------------------
-- Table structure for rider
-- ----------------------------
DROP TABLE IF EXISTS `rider`;
CREATE TABLE `rider`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `age` int(11) NULL DEFAULT NULL,
  `creditId` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `created_at` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rider
-- ----------------------------
INSERT INTO `rider` VALUES (1, '杨振', 22, '4401621990082053133', '2021-04-03 17:49:53.326584', '2021-04-27 00:36:46.813125');
INSERT INTO `rider` VALUES (2, '叶智健', 22, '440171199907021167', '2021-04-03 18:53:48.834811', '2021-04-10 02:01:23.950009');
INSERT INTO `rider` VALUES (4, '杨宏宇', NULL, '440172199012305212', '2021-04-04 10:35:37.250096', '2021-04-10 02:01:31.267948');
INSERT INTO `rider` VALUES (7, '萧伟豪', NULL, '440167197004054322', '2021-04-10 02:06:58.097237', '2021-04-10 02:06:58.097237');

-- ----------------------------
-- Table structure for ticketinfo
-- ----------------------------
DROP TABLE IF EXISTS `ticketinfo`;
CREATE TABLE `ticketinfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tableId` int(11) NULL DEFAULT NULL,
  `day` date NULL DEFAULT NULL,
  `time` time(6) NOT NULL,
  `startStation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `endStation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `userId` int(11) NOT NULL,
  `money` int(11) NOT NULL COMMENT '价格',
  `duration` time(6) NULL DEFAULT NULL COMMENT '耗时',
  `riderId` int(11) NULL DEFAULT NULL,
  `riderName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `riderCreditId` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `license_plate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车牌',
  `driverId` int(11) NULL DEFAULT NULL,
  `created_at` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tableId`(`tableId`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE,
  INDEX `riderId`(`riderId`) USING BTREE,
  INDEX `driverId`(`driverId`) USING BTREE,
  CONSTRAINT `ticketinfo_ibfk_1` FOREIGN KEY (`tableId`) REFERENCES `timetable` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ticketinfo_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ticketinfo_ibfk_3` FOREIGN KEY (`riderId`) REFERENCES `rider` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ticketinfo_ibfk_4` FOREIGN KEY (`driverId`) REFERENCES `driver` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ticketinfo
-- ----------------------------
INSERT INTO `ticketinfo` VALUES (14, 8, '2021-04-05', '12:00:00.000000', '省汽车站', '佛山汽车站', 1, 20, '01:30:00.000000', 1, '杨振', '440181199809125112', NULL, NULL, '2021-04-04 23:19:13.424307', '2021-04-05 23:53:48.279079');
INSERT INTO `ticketinfo` VALUES (16, 15, '2021-04-06', '20:30:00.000000', '省汽车站', '佛山汽车站', 1, 20, '01:30:00.000000', 1, '杨振', '440181199809125112', NULL, NULL, '2021-04-06 16:58:58.501959', '2021-04-06 16:58:58.501959');
INSERT INTO `ticketinfo` VALUES (17, 22, '2021-04-10', '14:00:00.000000', '省汽车站', '佛山汽车站', 1, 20, '01:30:00.000000', 1, '杨振', '4401621990082053132', NULL, NULL, '2021-04-10 02:21:31.018006', '2021-04-10 02:21:31.018006');
INSERT INTO `ticketinfo` VALUES (18, 22, '2021-04-10', '14:00:00.000000', '省汽车站', '佛山汽车站', 1, 20, '01:30:00.000000', 4, '杨宏宇', '440172199012305212', NULL, NULL, '2021-04-10 02:21:31.018006', '2021-04-10 02:21:31.018006');
INSERT INTO `ticketinfo` VALUES (23, 30, '2021-04-11', '16:30:00.000000', '省汽车站', '佛山汽车站', 1, 20, '01:30:00.000000', 1, '杨振', '4401621990082053132', NULL, NULL, '2021-04-11 10:17:31.682981', '2021-04-11 10:20:30.546767');
INSERT INTO `ticketinfo` VALUES (24, 29, '2021-04-11', '14:00:00.000000', '省汽车站', '佛山汽车站', 1, 20, '01:30:00.000000', 2, '叶智健', '440171199907021167', NULL, NULL, '2021-04-11 10:17:31.682981', '2021-04-11 10:17:31.682981');
INSERT INTO `ticketinfo` VALUES (25, 36, '2021-04-15', '08:05:00.000000', '省汽车站', '佛山汽车站', 1, 20, '01:30:00.000000', 1, '杨振', '4401621990082053132', NULL, NULL, '2021-04-14 22:35:44.176711', '2021-04-14 22:35:44.176711');
INSERT INTO `ticketinfo` VALUES (26, 37, '2021-04-15', '16:30:00.000000', '省汽车站', '佛山汽车站', 1, 20, '01:30:00.000000', 1, '杨振', '4401621990082053132', NULL, NULL, '2021-04-15 14:27:34.160376', '2021-04-15 14:27:34.160376');
INSERT INTO `ticketinfo` VALUES (27, 37, '2021-04-15', '16:30:00.000000', '省汽车站', '佛山汽车站', 1, 20, '01:30:00.000000', 2, '叶智健', '440171199907021167', NULL, NULL, '2021-04-15 14:27:34.160376', '2021-04-15 14:27:34.160376');
INSERT INTO `ticketinfo` VALUES (46, 53, '2021-05-04', '10:30:00.000000', '省汽车站', '佛山汽车站', 1, 20, '01:30:00.000000', 1, '杨振', '4401621990082053133', NULL, NULL, '2021-05-04 00:04:40.741400', '2021-05-04 00:04:40.741400');
INSERT INTO `ticketinfo` VALUES (47, 53, '2021-05-04', '10:30:00.000000', '省汽车站', '佛山汽车站', 1, 20, '01:30:00.000000', 2, '叶智健', '440171199907021167', NULL, NULL, '2021-05-04 00:04:40.741400', '2021-05-04 00:04:40.741400');

-- ----------------------------
-- Table structure for timetable
-- ----------------------------
DROP TABLE IF EXISTS `timetable`;
CREATE TABLE `timetable`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `day` date NULL DEFAULT NULL,
  `time` time(6) NOT NULL,
  `startStationId` int(11) NULL DEFAULT NULL,
  `startStation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `endStationId` int(11) NULL DEFAULT NULL,
  `endStation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `money` int(11) NOT NULL,
  `duration` time(6) NULL DEFAULT NULL COMMENT '耗时',
  `count` int(11) NULL DEFAULT NULL,
  `distance` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '距离',
  `license_plate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车牌',
  `driverId` int(11) NULL DEFAULT NULL,
  `created_at` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `driverId`(`driverId`) USING BTREE,
  INDEX `startStationId`(`startStationId`) USING BTREE,
  INDEX `endStationId`(`endStationId`) USING BTREE,
  CONSTRAINT `timetable_ibfk_1` FOREIGN KEY (`driverId`) REFERENCES `driver` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `timetable_ibfk_2` FOREIGN KEY (`startStationId`) REFERENCES `busstation` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `timetable_ibfk_3` FOREIGN KEY (`endStationId`) REFERENCES `busstation` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of timetable
-- ----------------------------
INSERT INTO `timetable` VALUES (1, '2021-04-02', '10:05:00.000000', NULL, '省汽车站', NULL, '西乡汽车站', 20, '02:00:00.000000', 45, '短途车', NULL, NULL, '2021-04-02 18:06:35.111259', '2021-04-08 12:39:12.008005');
INSERT INTO `timetable` VALUES (2, '2021-04-02', '10:30:00.000000', NULL, '省汽车站', NULL, '东莞南城汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-02 18:07:40.045913', '2021-04-11 09:05:48.305956');
INSERT INTO `timetable` VALUES (5, '2021-04-04', '14:00:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-04 02:52:05.464243', '2021-04-04 02:52:05.464243');
INSERT INTO `timetable` VALUES (6, '2021-04-05', '08:05:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-04 22:14:01.543757', '2021-04-04 22:14:01.543757');
INSERT INTO `timetable` VALUES (8, '2021-04-05', '12:00:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 44, '短途车', NULL, NULL, '2021-04-04 22:15:56.600093', '2021-04-05 23:53:48.294578');
INSERT INTO `timetable` VALUES (9, '2021-04-06', '08:05:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-06 14:30:39.708552', '2021-04-06 14:30:39.708552');
INSERT INTO `timetable` VALUES (10, '2021-04-06', '10:03:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-06 14:31:37.242353', '2021-04-06 14:31:37.242353');
INSERT INTO `timetable` VALUES (11, '2021-04-06', '12:00:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-06 14:32:19.857833', '2021-04-06 14:32:19.857833');
INSERT INTO `timetable` VALUES (12, '2021-04-06', '14:00:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-06 14:33:23.788032', '2021-04-06 14:33:23.788032');
INSERT INTO `timetable` VALUES (13, '2021-04-06', '16:30:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-06 14:34:09.887021', '2021-04-06 14:34:09.887021');
INSERT INTO `timetable` VALUES (14, '2021-04-06', '19:00:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-06 14:36:33.399155', '2021-04-06 14:36:33.399155');
INSERT INTO `timetable` VALUES (15, '2021-04-06', '20:30:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 44, '短途车', NULL, NULL, '2021-04-06 14:37:17.017973', '2021-04-06 16:58:58.522633');
INSERT INTO `timetable` VALUES (16, '2021-04-06', '22:00:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-06 14:47:30.644741', '2021-04-06 14:47:30.644741');
INSERT INTO `timetable` VALUES (17, '2021-04-06', '17:30:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-06 16:37:12.974400', '2021-04-06 16:37:12.974400');
INSERT INTO `timetable` VALUES (18, '2021-04-07', '08:05:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-06 16:38:21.819774', '2021-04-06 16:38:21.819774');
INSERT INTO `timetable` VALUES (19, '2021-04-08', '08:05:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-08 12:41:30.894174', '2021-04-08 12:41:30.894174');
INSERT INTO `timetable` VALUES (20, '2021-04-10', '08:05:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-10 01:24:39.154834', '2021-04-10 01:24:39.154834');
INSERT INTO `timetable` VALUES (21, '2021-04-10', '10:30:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-10 01:25:10.060986', '2021-04-10 01:25:10.060986');
INSERT INTO `timetable` VALUES (22, '2021-04-10', '14:00:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 43, '短途车', NULL, NULL, '2021-04-10 01:25:47.329615', '2021-04-10 02:21:31.034638');
INSERT INTO `timetable` VALUES (23, '2021-04-10', '16:30:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-10 01:26:41.306168', '2021-04-10 01:26:41.306168');
INSERT INTO `timetable` VALUES (24, '2021-04-10', '19:00:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-10 01:27:15.637723', '2021-04-10 01:27:15.637723');
INSERT INTO `timetable` VALUES (25, '2021-04-10', '20:30:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-10 01:27:55.932673', '2021-04-10 01:27:55.932673');
INSERT INTO `timetable` VALUES (26, '2021-04-10', '22:00:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-10 01:28:28.355076', '2021-04-10 01:28:28.355076');
INSERT INTO `timetable` VALUES (27, '2021-04-11', '08:05:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-11 01:42:01.507551', '2021-04-11 01:42:01.507551');
INSERT INTO `timetable` VALUES (28, '2021-04-11', '10:30:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-11 01:42:39.846472', '2021-04-11 01:42:39.846472');
INSERT INTO `timetable` VALUES (29, '2021-04-11', '14:00:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 44, '短途车', NULL, NULL, '2021-04-11 01:43:08.902161', '2021-04-11 10:20:30.550458');
INSERT INTO `timetable` VALUES (30, '2021-04-11', '16:30:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 44, '短途车', NULL, NULL, '2021-04-11 01:43:40.559691', '2021-04-11 10:20:30.552609');
INSERT INTO `timetable` VALUES (31, '2021-04-11', '20:00:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-11 01:44:34.527807', '2021-04-11 01:44:34.527807');
INSERT INTO `timetable` VALUES (32, '2021-04-11', '12:00:00.000000', NULL, '广州南站汽车站', NULL, '西乡汽车站', 40, '02:00:00.000000', 45, '短途车', NULL, NULL, '2021-04-11 01:45:24.947759', '2021-04-11 01:45:24.947759');
INSERT INTO `timetable` VALUES (33, '2021-04-12', '08:05:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-11 01:46:21.134705', '2021-04-11 01:46:21.134705');
INSERT INTO `timetable` VALUES (34, '2021-04-12', '10:30:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-11 01:47:03.276840', '2021-04-11 01:47:03.276840');
INSERT INTO `timetable` VALUES (35, '2021-04-12', '09:05:00.000000', NULL, '西乡汽车站', NULL, '海珠客运站', 20, '02:00:00.000000', 45, '短途车', NULL, NULL, '2021-04-11 09:07:11.817221', '2021-04-11 09:07:11.817221');
INSERT INTO `timetable` VALUES (36, '2021-04-15', '08:05:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 44, '短途车', NULL, NULL, '2021-04-14 22:33:05.225545', '2021-04-14 22:35:44.184094');
INSERT INTO `timetable` VALUES (37, '2021-04-15', '16:30:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 43, '短途车', NULL, NULL, '2021-04-15 14:06:16.004743', '2021-04-15 14:27:34.185118');
INSERT INTO `timetable` VALUES (38, '2021-04-15', '19:00:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:00:00.000000', 45, '短途车', NULL, NULL, '2021-04-15 14:06:57.502055', '2021-04-15 14:06:57.502055');
INSERT INTO `timetable` VALUES (39, '2021-04-15', '20:30:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-15 14:07:29.441028', '2021-04-15 14:07:29.441028');
INSERT INTO `timetable` VALUES (40, '2021-04-15', '22:00:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-15 14:07:53.683501', '2021-04-15 14:07:53.683501');
INSERT INTO `timetable` VALUES (41, '2021-04-23', '20:00:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-22 22:26:11.815401', '2021-04-22 22:26:11.815401');
INSERT INTO `timetable` VALUES (42, '2021-04-26', '08:05:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-25 17:05:46.012277', '2021-04-25 17:21:30.507489');
INSERT INTO `timetable` VALUES (43, '2021-04-27', '08:05:00.000000', NULL, '天河客运站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-26 23:55:05.743795', '2021-04-27 00:36:28.452291');
INSERT INTO `timetable` VALUES (44, '2021-04-27', '10:30:00.000000', NULL, '天河客运站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-26 23:55:43.571516', '2021-04-27 08:39:38.253094');
INSERT INTO `timetable` VALUES (45, '2021-04-27', '14:00:00.000000', NULL, '天河客运站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-26 23:56:16.385335', '2021-04-26 23:56:16.385335');
INSERT INTO `timetable` VALUES (46, '2021-04-27', '16:30:00.000000', NULL, '天河客运站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-26 23:58:10.827417', '2021-04-27 08:39:48.193234');
INSERT INTO `timetable` VALUES (47, '2021-04-27', '19:00:00.000000', NULL, '天河客运站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-26 23:59:34.908612', '2021-04-26 23:59:34.908612');
INSERT INTO `timetable` VALUES (48, '2021-04-27', '20:30:00.000000', NULL, '天河客运站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-27 00:00:07.725064', '2021-04-27 00:00:07.725064');
INSERT INTO `timetable` VALUES (49, '2021-04-27', '22:00:00.000000', NULL, '天河客运站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-27 00:00:58.681976', '2021-04-27 00:01:41.660558');
INSERT INTO `timetable` VALUES (50, '2021-04-28', '08:05:00.000000', NULL, '天河客运站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-04-27 00:22:20.917920', '2021-04-27 00:22:20.917920');
INSERT INTO `timetable` VALUES (51, '2021-04-27', '12:00:00.000000', NULL, '广园客运站', NULL, '西乡汽车站', 40, '02:00:00.000000', 45, '短途车', NULL, NULL, '2021-04-27 00:23:09.272029', '2021-04-27 00:23:09.272029');
INSERT INTO `timetable` VALUES (52, '2021-05-04', '08:30:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-05-03 23:57:40.635175', '2021-05-03 23:57:40.635175');
INSERT INTO `timetable` VALUES (53, '2021-05-04', '10:30:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 43, '短途车', NULL, NULL, '2021-05-03 23:58:14.802424', '2021-05-04 00:04:40.760897');
INSERT INTO `timetable` VALUES (54, '2021-05-04', '14:00:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-05-03 23:59:01.381035', '2021-05-03 23:59:01.381035');
INSERT INTO `timetable` VALUES (55, '2021-05-04', '16:30:00.000000', NULL, '省汽车站', NULL, '佛山汽车站', 20, '01:30:00.000000', 45, '短途车', NULL, NULL, '2021-05-03 23:59:42.168133', '2021-05-03 23:59:42.168133');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `root` int(11) NULL DEFAULT NULL COMMENT '是否为管理员，1为管理员，0为普通用户',
  `created_at` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`userId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '杨振', '$2a$10$YgbIGFFedA0DU.qt1ayIwOzTduEe1j5WiI5M3MBNya2r.ubOox/Wi', 0, '2021-04-06 18:18:27.761053', '2021-04-11 09:11:09.713776');
INSERT INTO `user` VALUES (2, 'yyaa', '$2a$10$ieeAPMfXKcZSqrXlhkg7/OSIDoQxrkmrcDFDL5vEm6nHxUqPMIk.K', 0, '2021-04-06 21:39:46.716519', '2021-04-06 21:39:46.716519');
INSERT INTO `user` VALUES (3, '杨振', '$2a$10$T8B5Mke3EJeg19q/0SLhlOSt.dHmVlRasyLcosM7Hu6MLF0JiBnCO', 1, '2021-04-06 21:58:53.501495', '2021-04-06 21:58:53.501495');
INSERT INTO `user` VALUES (4, '杨宏宇', '$2a$10$A3bsHCUawVR9H15OZxGiJe0u2KNOE3jnKztr1aLgNJvK5LDQMyVVe', 1, '2021-04-08 13:01:57.720957', '2021-04-08 13:01:57.720957');
INSERT INTO `user` VALUES (5, 'yyxx', '$2a$10$kywmGxxDLnDRT7GWQuu2c.qegAAeebfHVQaJ/9c/2.3HdIxgJCHey', 0, '2021-04-11 09:02:10.989570', '2021-04-11 09:02:10.989570');
INSERT INTO `user` VALUES (6, 'yycc', '$2a$10$bCSv0msVGGUJs9RA46dMju2cAMhx0QFr.hTTj2E5o0I17TF.0uhr6', 0, '2021-04-11 09:03:28.660879', '2021-04-11 09:03:28.660879');
INSERT INTO `user` VALUES (7, 'yhy', '$2a$10$daBCOGSpoVeUVEYDcndKR.JX8Mngh0JnVY6pubpxC0zhefYfZMwDi', 1, '2021-04-11 09:08:23.609040', '2021-04-11 09:08:23.609040');

-- ----------------------------
-- Table structure for user2rider
-- ----------------------------
DROP TABLE IF EXISTS `user2rider`;
CREATE TABLE `user2rider`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NULL DEFAULT NULL,
  `riderId` int(11) NULL DEFAULT NULL,
  `creditId` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE,
  INDEX `riderId`(`riderId`) USING BTREE,
  CONSTRAINT `user2rider_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user2rider_ibfk_2` FOREIGN KEY (`riderId`) REFERENCES `rider` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user2rider
-- ----------------------------
INSERT INTO `user2rider` VALUES (1, 1, 1, '4401621990082053133', '杨振', '2021-04-03 17:51:40.665544', '2021-04-27 00:36:46.822093');
INSERT INTO `user2rider` VALUES (2, 1, 2, '440171199907021167', '叶智健', '2021-04-03 18:54:09.635509', '2021-04-10 02:01:23.959928');
INSERT INTO `user2rider` VALUES (3, 1, 4, '440172199012305212', '杨宏宇', '2021-04-04 10:35:37.253162', '2021-04-10 02:01:31.270689');
INSERT INTO `user2rider` VALUES (6, 1, 7, '440167197004054322', '萧伟豪', '2021-04-10 02:06:58.102866', '2021-04-10 02:06:58.102866');

SET FOREIGN_KEY_CHECKS = 1;
