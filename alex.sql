-- MySQL dump 10.17  Distrib 10.3.17-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: alex
-- ------------------------------------------------------
-- Server version	10.3.17-MariaDB-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `adminRoles`
--

DROP TABLE IF EXISTS `adminRoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adminRoles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `authority` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `adminRoles_name_uindex` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='管理员角色';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminRoles`
--

LOCK TABLES `adminRoles` WRITE;
/*!40000 ALTER TABLE `adminRoles` DISABLE KEYS */;
INSERT INTO `adminRoles` VALUES (1,'rule','商品-商品列表');
/*!40000 ALTER TABLE `adminRoles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminUsers`
--

DROP TABLE IF EXISTS `adminUsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adminUsers` (
  `userId` bigint(10) unsigned NOT NULL,
  `roleId` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminUsers`
--

LOCK TABLES `adminUsers` WRITE;
/*!40000 ALTER TABLE `adminUsers` DISABLE KEYS */;
INSERT INTO `adminUsers` VALUES (1,0),(2,1);
/*!40000 ALTER TABLE `adminUsers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brand` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `note` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES (1,'apple','aa'),(2,'a',''),(3,'abc',''),(5,'bbb',''),(6,'李宁',''),(7,'22','aa'),(8,'ttt','');
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parentId` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `i` bigint(10) unsigned NOT NULL DEFAULT 0 COMMENT '首页显示 0:no 1:display',
  `sort` bigint(20) NOT NULL DEFAULT 50,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,0,'手机数码',0,50),(2,0,'电脑办公',0,50),(3,0,'运动健康',0,60),(4,3,'户外装备',0,50),(5,2,'电脑整机',0,50),(7,3,'运动器械',0,50),(8,3,'户外鞋服',0,50),(10,0,'家用电器',0,50),(11,10,'大家电',1,50),(12,1,'手机通讯',1,50),(15,1,'手机配件',0,50),(16,1,'摄影摄像',0,50),(17,2,'电脑配件',0,50),(18,2,'服务产品',0,50),(19,10,'生活电器',0,50),(20,10,'厨房电器',0,50);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expressCompanies`
--

DROP TABLE IF EXISTS `expressCompanies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expressCompanies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `recommend` bigint(20) NOT NULL DEFAULT 100 COMMENT '推荐',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='快递公司';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expressCompanies`
--

LOCK TABLES `expressCompanies` WRITE;
/*!40000 ALTER TABLE `expressCompanies` DISABLE KEYS */;
INSERT INTO `expressCompanies` VALUES (1,'顺丰速运','adfdf',100),(3,'assd','a',100),(4,'a','b',0);
/*!40000 ALTER TABLE `expressCompanies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods`
--

DROP TABLE IF EXISTS `goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goods` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cateId` bigint(20) unsigned NOT NULL,
  `brandId` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT 'brand id',
  `name` varchar(255) NOT NULL,
  `status` bigint(8) unsigned NOT NULL DEFAULT 2 COMMENT '0B1: recycle bin / normal\n0B10: on sell / not on sell\n0B100: shipping fee / shipping free',
  `recommend` bigint(20) unsigned NOT NULL DEFAULT 1000,
  `released` date NOT NULL DEFAULT curdate() COMMENT 'release date',
  `des` text NOT NULL COMMENT 'goods description',
  `imgs` text NOT NULL COMMENT 'goods image',
  `price` bigint(20) unsigned NOT NULL COMMENT 'price',
  `stock` bigint(20) unsigned NOT NULL COMMENT 'goods stock',
  `weight` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT 'goods weight',
  `updateAt` datetime NOT NULL,
  `createAt` datetime NOT NULL,
  `spec` text NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COMMENT='goods';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods`
--

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` VALUES (3,5,2,'afsffffffffffffffffffsfsff sf4 s84 8s7f8s7f8s7f8s7f8s7fs7f87f8s7f8s4fs84fs84f8s7fs8 4s8 787fs87fs87fs8a7fs8f78sf7s8f78s7f8s7f8s7fs8f7s8f78sf78sf78s4f8s4f8sf4s8f',2,1000,'2020-10-09','<p>rr</p>\r\n<p>fs</p>\r\n<p>f</p>\r\n<p><img src=\"https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg\" alt=\"\" width=\"800\" height=\"550\" /></p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',3201,0,0,'2020-09-29 16:22:48','2020-04-21 15:13:04','[{\"name\":\"颜色\",\"list\":[{\"val\":\"黑色\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/b0/id/er34frcfao6nk8gt3n6wf67whbyx35skiwtayjur7nibfbua.jpg?x-oss-process=image/resize,w_40,h_40\"},{\"val\":\"白色\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/6r/i5/8auglqevlz14mqoe5mf01buhdh530s3swx9ue9n9uu5nn2d5i.jpg?x-oss-process=image/resize,w_40,h_40\"},{\"val\":\"红色\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/2v/fj/ryojefdfcnrrvn9m0ji6ely5v4w4zofy0bbcwyr3gg0y9q9t76.jpg?x-oss-process=image/resize,w_40,h_40\"}]},{\"name\":\"容量\",\"list\":[{\"val\":\"32G\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/2v/fj/ryojefdfcnrrvn9m0ji6ely5v4w4zofy0bbcwyr3gg0y9q9t76.jpg\"},{\"val\":\"64G\",\"hint\":\"\",\"img\":\"\"},{\"val\":\"128G\",\"hint\":\"\",\"img\":\"\"}]}]'),(4,2,0,'a<br><hr>\'\"',6,1000,'2020-10-11','<p>df</p>','https://0-00.oss-cn-beijing.aliyuncs.com/3o/va/yms620ynwpqnr3mzeqoq6hex7z16qnbsbj8807bq1va5oc49n6.jpg,https://0-00.oss-cn-beijing.aliyuncs.com/6r/i5/8auglqevlz14mqoe5mf01buhdh530s3swx9ue9n9uu5nn2d5i.jpg,https://0-00.oss-cn-beijing.aliyuncs.com/1y/no/zwpufs3n2acgmgi4lzd5aa7ockbcqw0tmid4qbw2ifi8emc4b3.jpg',698,0,0,'2020-12-04 16:25:23','2020-04-21 15:59:09','[{\"name\":\"长规格值测试测试\",\"list\":[{\"val\":\"测试测试测试测试测试测试测试测试测试测试测试\",\"hint\":\"c\",\"img\":\"\"},{\"val\":\"测试测试测试测试测试测试测试测试测试测试测试测试1\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/1a/qh/zmnc5tgzuou5fz03f99kiyg1mse2849vxdpvflr5nydxbeiavv.jpg?x-oss-process=image/resize,w_40,h_40\"}]}]'),(5,2,0,'df1111',2,1000,'2020-10-09','<p style=\"text-align: justify;\">dfdfdf</p>','https://0-00.oss-cn-beijing.aliyuncs.com/2v/fj/ryojefdfcnrrvn9m0ji6ely5v4w4zofy0bbcwyr3gg0y9q9t76.jpg',245,4,6,'2020-09-05 00:47:32','2020-04-22 16:24:11',''),(7,12,0,'商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称',2,1000,'2020-10-09','<p>df</p>','https://0-00.oss-cn-beijing.aliyuncs.com/1a/qh/zmnc5tgzuou5fz03f99kiyg1mse2849vxdpvflr5nydxbeiavv.jpg,https://0-00.oss-cn-beijing.aliyuncs.com/6r/i5/8auglqevlz14mqoe5mf01buhdh530s3swx9ue9n9uu5nn2d5i.jpg',0,0,0,'2020-09-25 09:44:00','2020-04-24 15:48:16',''),(8,5,0,'f',2,1000,'2020-10-09','','https://0-00.oss-cn-beijing.aliyuncs.com/2v/fj/ryojefdfcnrrvn9m0ji6ely5v4w4zofy0bbcwyr3gg0y9q9t76.jpg',0,0,1,'2020-12-06 01:31:37','2020-05-08 15:38:20',''),(9,7,7,'df',6,1000,'2020-10-09','<p>df</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',0,0,0,'2020-08-21 01:31:55','2020-08-20 03:02:40',''),(10,12,0,'fsfsf',6,1000,'2020-10-09','<p>df</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-08-26 01:28:41','2020-08-26 01:28:41',''),(12,3,7,'adf',6,1000,'2020-10-09','<p>df</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',0,0,0,'2020-08-26 02:02:03','2020-08-26 02:02:03','[{\"name\":\"颜色\",\"list\":[{\"val\":\"黑色\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/b0/id/er34frcfao6nk8gt3n6wf67whbyx35skiwtayjur7nibfbua.jpg\"},{\"val\":\"白色\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/6r/i5/8auglqevlz14mqoe5mf01buhdh530s3swx9ue9n9uu5nn2d5i.jpg\"}]},{\"name\":\"容量\",\"list\":[{\"val\":\"32G\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/2v/fj/ryojefdfcnrrvn9m0ji6ely5v4w4zofy0bbcwyr3gg0y9q9t76.jpg\"},{\"val\":\"64G\",\"hint\":\"\",\"img\":\"\"}]}]'),(13,3,7,'adf',6,1000,'2020-10-09','<p>df</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,0,3,'2020-08-30 03:47:20','2020-08-26 02:02:41',''),(29,12,0,'Apple iPhone 11 (A2223)  移动联通电信4G手机 双卡双待',2,10001,'2020-10-09','<p>dfdf</p>','https://0-00.oss-cn-beijing.aliyuncs.com/1y/6u/grc2krd3h3xwcevd9wpyrihabukvmnymauohhb6ula8q872c9g.png,https://0-00.oss-cn-beijing.aliyuncs.com/1d/za/x5dfklo29gwwarpvn009ls9vy150rjv18rdlcgte45k9j9w3wx.jpg,https://0-00.oss-cn-beijing.aliyuncs.com/2u/1s/p6ji15fmgoyfp964kql8gys2z3hhix153cad1bs5azrhoyl8h1.png,https://0-00.oss-cn-beijing.aliyuncs.com/14/tc/rittidoeup4hdd03yzg6ywe77gb2uq8tpaubftwx6n8lwsq2xh.png,https://0-00.oss-cn-beijing.aliyuncs.com/14/01/0hcd1nbbs0qdqkkjei2w76f3qkw22ch623wjcw11fthmw4moxl.png,https://0-00.oss-cn-beijing.aliyuncs.com/1y/13/h9fxsd1qaci06zamsqczspllhpd95llktp5fan7vocywn4seud.png,https://0-00.oss-cn-beijing.aliyuncs.com/t1/vi/l0h6nu8xplkbmzqckdi1xfdo7r561g7jb3ycq4d9rgwqoo2if.png',549900,0,0,'2020-11-29 01:44:37','2020-10-08 03:05:00','[{\"name\":\"颜色\",\"list\":[{\"val\":\"黑色\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/1y/6u/grc2krd3h3xwcevd9wpyrihabukvmnymauohhb6ula8q872c9g.png?x-oss-process=image/resize,w_40,h_40\"},{\"val\":\"白色\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/2u/1s/p6ji15fmgoyfp964kql8gys2z3hhix153cad1bs5azrhoyl8h1.png?x-oss-process=image/resize,w_40,h_40\"},{\"val\":\"红色\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/14/tc/rittidoeup4hdd03yzg6ywe77gb2uq8tpaubftwx6n8lwsq2xh.png?x-oss-process=image/resize,w_40,h_40\"},{\"val\":\"黄色\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/14/01/0hcd1nbbs0qdqkkjei2w76f3qkw22ch623wjcw11fthmw4moxl.png?x-oss-process=image/resize,w_40,h_40\"},{\"val\":\"紫色\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/1y/13/h9fxsd1qaci06zamsqczspllhpd95llktp5fan7vocywn4seud.png?x-oss-process=image/resize,w_40,h_40\"},{\"val\":\"绿色\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/t1/vi/l0h6nu8xplkbmzqckdi1xfdo7r561g7jb3ycq4d9rgwqoo2if.png?x-oss-process=image/resize,w_40,h_40\"}]},{\"name\":\"容量\",\"list\":[{\"val\":\"64G\",\"hint\":\"\",\"img\":\"\"},{\"val\":\"128G\",\"hint\":\"\",\"img\":\"\"},{\"val\":\"256G\",\"hint\":\"\",\"img\":\"\"}]}]'),(30,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(31,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(32,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(33,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(34,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(35,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(36,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(37,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(38,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(39,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(40,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(41,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(42,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(43,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(44,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(45,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(46,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(47,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(48,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(49,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(50,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(51,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(52,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(53,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(54,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(55,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(56,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(57,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(58,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(59,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(60,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(61,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(62,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(63,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(64,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(65,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(66,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(67,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(68,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(69,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(70,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(71,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(72,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16',''),(73,4,0,'test',2,1000,'2020-10-09','<p>a</p>','https://0-00.oss-cn-beijing.aliyuncs.com/24/ze/tedh8fbl6jdsmsmsmkx0z1onzyhub8f6vigbqdhzli1hl16eb4.jpg',100,1,1,'2020-10-09 01:04:16','2020-10-09 01:04:16','');
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goodsSpec`
--

DROP TABLE IF EXISTS `goodsSpec`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goodsSpec` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `goodsId` bigint(20) unsigned NOT NULL,
  `idx` bigint(20) unsigned NOT NULL COMMENT 'index',
  `price` bigint(20) unsigned NOT NULL,
  `stock` bigint(20) unsigned NOT NULL,
  `weight` bigint(20) unsigned NOT NULL,
  `des` text NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `goodsSpec_goodsId_index` (`goodsId`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goodsSpec`
--

LOCK TABLES `goodsSpec` WRITE;
/*!40000 ALTER TABLE `goodsSpec` DISABLE KEYS */;
INSERT INTO `goodsSpec` VALUES (1,1,1,1,1,1,''),(9,9,1,1,1,1,''),(11,11,1,1,1,1,''),(15,15,1,1,1,1,''),(36,3,0,3201,99,0,'黑色 32G'),(37,3,1,3202,99,0,'黑色 64G'),(38,3,2,3203,99,0,'黑色 128G'),(39,3,3,3204,99,0,'白色 32G'),(40,3,4,3205,99,0,'白色 64G'),(41,3,5,3206,99,0,'白色 128G'),(42,3,6,3207,99,0,'红色 32G'),(43,3,7,3208,99,0,'红色 64G'),(44,3,8,3209,999,0,'红色 128G'),(45,4,0,698,88,90,'测试测试测试测试测试测试测试测试测试测试测试'),(46,4,1,698,88,90,'测试测试测试测试测试测试测试测试测试测试测试测试1'),(47,29,0,549900,999,470,'黑色 64G'),(48,29,1,589900,999,470,'黑色 128G'),(49,29,2,669900,999,470,'黑色 256G'),(50,29,3,549900,999,470,'白色 64G'),(51,29,4,589900,999,470,'白色 128G'),(52,29,5,669900,999,470,'白色 256G'),(53,29,6,549900,999,470,'红色 64G'),(54,29,7,589900,999,470,'红色 128G'),(55,29,8,669900,999,470,'红色 256G'),(56,29,9,549900,999,470,'黄色 64G'),(57,29,10,589900,999,470,'黄色 128G'),(58,29,11,669900,999,470,'黄色 256G'),(59,29,12,549900,999,470,'紫色 64G'),(60,29,13,589900,999,470,'紫色 128G'),(61,29,14,669900,999,470,'紫色 256G'),(62,29,15,549900,999,470,'绿色 64G'),(63,29,16,589900,999,470,'绿色 128G'),(64,29,17,669900,999,470,'绿色 256G');
/*!40000 ALTER TABLE `goodsSpec` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderGoods`
--

DROP TABLE IF EXISTS `orderGoods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orderGoods` (
  `id` bigint(20) unsigned NOT NULL,
  `orderId` bigint(20) unsigned NOT NULL,
  `goodsId` bigint(20) unsigned NOT NULL,
  `specId` bigint(20) unsigned NOT NULL,
  `goodsName` varchar(255) NOT NULL,
  `price` bigint(20) unsigned NOT NULL,
  `weight` bigint(20) unsigned NOT NULL,
  `num` bigint(20) unsigned NOT NULL,
  `status` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '状态\n0 待发货\n1 已发货\n2 已退货',
  `img` varchar(255) NOT NULL,
  UNIQUE KEY `orderGoods_id_uindex` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderGoods`
--

LOCK TABLES `orderGoods` WRITE;
/*!40000 ALTER TABLE `orderGoods` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderGoods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` bigint(20) unsigned NOT NULL,
  `no` bigint(20) NOT NULL DEFAULT 0 COMMENT '订单号',
  `userId` bigint(20) NOT NULL COMMENT '用户ID',
  `region` bigint(20) NOT NULL,
  `price` bigint(20) NOT NULL,
  `shippingFee` bigint(20) NOT NULL,
  `status` bigint(20) NOT NULL DEFAULT 0 COMMENT '0 已下单\n2 已发货\n10 已取消(未付款)\n11 已取消(付款后取消)\n12 已退货',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '用户备注',
  `createTime` datetime NOT NULL,
  `payTime` datetime DEFAULT NULL,
  `shippingTime` datetime DEFAULT NULL,
  `confirmTime` datetime DEFAULT NULL,
  `payType` bigint(20) NOT NULL COMMENT '支付类型',
  `source` bigint(20) NOT NULL DEFAULT 1 COMMENT '来源\n1网页\n2微信小程序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_no_uindex` (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,201206000997,1,120110,0,0,0,'','2020-12-06 20:41:32',NULL,NULL,NULL,0,0),(2,201206001994,1,120110,245,0,0,'','2020-12-06 20:43:17',NULL,NULL,NULL,0,0),(3,201206002991,1,120110,980,0,0,'','2020-12-06 22:43:47',NULL,NULL,NULL,0,0),(4,201206003988,1,120110,698,0,0,'','2020-12-06 23:21:19',NULL,NULL,NULL,0,0);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `region` (
  `code` bigint(20) unsigned NOT NULL COMMENT '行政区划代码',
  `name` varchar(32) DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `region`
--

LOCK TABLES `region` WRITE;
/*!40000 ALTER TABLE `region` DISABLE KEYS */;
INSERT INTO `region` VALUES (110000,'北京'),(110100,'北京市'),(110101,'东城区'),(110102,'西城区'),(110105,'朝阳区'),(110106,'丰台区'),(110107,'石景山区'),(110108,'海淀区'),(110109,'门头沟区'),(110111,'房山区'),(110112,'通州区'),(110113,'顺义区'),(110114,'昌平区'),(110115,'大兴区'),(110116,'怀柔区'),(110117,'平谷区'),(110118,'密云区'),(110119,'延庆区'),(120000,'天津'),(120100,'天津市'),(120101,'和平区'),(120102,'河东区'),(120103,'河西区'),(120104,'南开区'),(120105,'河北区'),(120106,'红桥区'),(120110,'东丽区'),(120111,'西青区'),(120112,'津南区'),(120113,'北辰区'),(120114,'武清区'),(120115,'宝坻区'),(120116,'滨海新区'),(120117,'宁河区'),(120118,'静海区'),(120119,'蓟州区'),(130000,'河北'),(130100,'石家庄市'),(130102,'长安区'),(130104,'桥西区'),(130105,'新华区'),(130107,'井陉矿区'),(130108,'裕华区'),(130109,'藁城区'),(130110,'鹿泉区'),(130111,'栾城区'),(130121,'井陉县'),(130123,'正定县'),(130125,'行唐县'),(130126,'灵寿县'),(130127,'高邑县'),(130128,'深泽县'),(130129,'赞皇县'),(130130,'无极县'),(130131,'平山县'),(130132,'元氏县'),(130133,'赵县'),(130181,'辛集市'),(130183,'晋州市'),(130184,'新乐市'),(130200,'唐山市'),(130202,'路南区'),(130203,'路北区'),(130204,'古冶区'),(130205,'开平区'),(130207,'丰南区'),(130208,'丰润区'),(130209,'曹妃甸区'),(130224,'滦南县'),(130225,'乐亭县'),(130227,'迁西县'),(130229,'玉田县'),(130281,'遵化市'),(130283,'迁安市'),(130284,'滦州市'),(130300,'秦皇岛市'),(130302,'海港区'),(130303,'山海关区'),(130304,'北戴河区'),(130306,'抚宁区'),(130321,'青龙满族自治县'),(130322,'昌黎县'),(130324,'卢龙县'),(130400,'邯郸市'),(130402,'邯山区'),(130403,'丛台区'),(130404,'复兴区'),(130406,'峰峰矿区'),(130407,'肥乡区'),(130408,'永年区'),(130423,'临漳县'),(130424,'成安县'),(130425,'大名县'),(130426,'涉县'),(130427,'磁县'),(130430,'邱县'),(130431,'鸡泽县'),(130432,'广平县'),(130433,'馆陶县'),(130434,'魏县'),(130435,'曲周县'),(130481,'武安市'),(130500,'邢台市'),(130502,'桥东区'),(130503,'桥西区'),(130521,'邢台县'),(130522,'临城县'),(130523,'内丘县'),(130524,'柏乡县'),(130525,'隆尧县'),(130526,'任县'),(130527,'南和县'),(130528,'宁晋县'),(130529,'巨鹿县'),(130530,'新河县'),(130531,'广宗县'),(130532,'平乡县'),(130533,'威县'),(130534,'清河县'),(130535,'临西县'),(130581,'南宫市'),(130582,'沙河市'),(130600,'保定市'),(130602,'竞秀区'),(130606,'莲池区'),(130607,'满城区'),(130608,'清苑区'),(130609,'徐水区'),(130623,'涞水县'),(130624,'阜平县'),(130626,'定兴县'),(130627,'唐县'),(130628,'高阳县'),(130629,'容城县'),(130630,'涞源县'),(130631,'望都县'),(130632,'安新县'),(130633,'易县'),(130634,'曲阳县'),(130635,'蠡县'),(130636,'顺平县'),(130637,'博野县'),(130638,'雄县'),(130681,'涿州市'),(130682,'定州市'),(130683,'安国市'),(130684,'高碑店市'),(130700,'张家口市'),(130702,'桥东区'),(130703,'桥西区'),(130705,'宣化区'),(130706,'下花园区'),(130708,'万全区'),(130709,'崇礼区'),(130722,'张北县'),(130723,'康保县'),(130724,'沽源县'),(130725,'尚义县'),(130726,'蔚县'),(130727,'阳原县'),(130728,'怀安县'),(130730,'怀来县'),(130731,'涿鹿县'),(130732,'赤城县'),(130800,'承德市'),(130802,'双桥区'),(130803,'双滦区'),(130804,'鹰手营子矿区'),(130821,'承德县'),(130822,'兴隆县'),(130824,'滦平县'),(130825,'隆化县'),(130826,'丰宁满族自治县'),(130827,'宽城满族自治县'),(130828,'围场满族蒙古族自治县'),(130881,'平泉市'),(130900,'沧州市'),(130902,'新华区'),(130903,'运河区'),(130921,'沧县'),(130922,'青县'),(130923,'东光县'),(130924,'海兴县'),(130925,'盐山县'),(130926,'肃宁县'),(130927,'南皮县'),(130928,'吴桥县'),(130929,'献县'),(130930,'孟村回族自治县'),(130981,'泊头市'),(130982,'任丘市'),(130983,'黄骅市'),(130984,'河间市'),(131000,'廊坊市'),(131002,'安次区'),(131003,'广阳区'),(131022,'固安县'),(131023,'永清县'),(131024,'香河县'),(131025,'大城县'),(131026,'文安县'),(131028,'大厂回族自治县'),(131081,'霸州市'),(131082,'三河市'),(131100,'衡水市'),(131102,'桃城区'),(131103,'冀州区'),(131121,'枣强县'),(131122,'武邑县'),(131123,'武强县'),(131124,'饶阳县'),(131125,'安平县'),(131126,'故城县'),(131127,'景县'),(131128,'阜城县'),(131182,'深州市'),(140000,'山西'),(140100,'太原市'),(140105,'小店区'),(140106,'迎泽区'),(140107,'杏花岭区'),(140108,'尖草坪区'),(140109,'万柏林区'),(140110,'晋源区'),(140121,'清徐县'),(140122,'阳曲县'),(140123,'娄烦县'),(140181,'古交市'),(140200,'大同市'),(140212,'新荣区'),(140213,'平城区'),(140214,'云冈区'),(140215,'云州区'),(140221,'阳高县'),(140222,'天镇县'),(140223,'广灵县'),(140224,'灵丘县'),(140225,'浑源县'),(140226,'左云县'),(140300,'阳泉市'),(140302,'城区'),(140303,'矿区'),(140311,'郊区'),(140321,'平定县'),(140322,'盂县'),(140400,'长治市'),(140403,'潞州区'),(140404,'上党区'),(140405,'屯留区'),(140406,'潞城区'),(140423,'襄垣县'),(140425,'平顺县'),(140426,'黎城县'),(140427,'壶关县'),(140428,'长子县'),(140429,'武乡县'),(140430,'沁县'),(140431,'沁源县'),(140500,'晋城市'),(140502,'城区'),(140521,'沁水县'),(140522,'阳城县'),(140524,'陵川县'),(140525,'泽州县'),(140581,'高平市'),(140600,'朔州市'),(140602,'朔城区'),(140603,'平鲁区'),(140621,'山阴县'),(140622,'应县'),(140623,'右玉县'),(140681,'怀仁市'),(140700,'晋中市'),(140702,'榆次区'),(140721,'榆社县'),(140722,'左权县'),(140723,'和顺县'),(140724,'昔阳县'),(140725,'寿阳县'),(140726,'太谷县'),(140727,'祁县'),(140728,'平遥县'),(140729,'灵石县'),(140781,'介休市'),(140800,'运城市'),(140802,'盐湖区'),(140821,'临猗县'),(140822,'万荣县'),(140823,'闻喜县'),(140824,'稷山县'),(140825,'新绛县'),(140826,'绛县'),(140827,'垣曲县'),(140828,'夏县'),(140829,'平陆县'),(140830,'芮城县'),(140881,'永济市'),(140882,'河津市'),(140900,'忻州市'),(140902,'忻府区'),(140921,'定襄县'),(140922,'五台县'),(140923,'代县'),(140924,'繁峙县'),(140925,'宁武县'),(140926,'静乐县'),(140927,'神池县'),(140928,'五寨县'),(140929,'岢岚县'),(140930,'河曲县'),(140931,'保德县'),(140932,'偏关县'),(140981,'原平市'),(141000,'临汾市'),(141002,'尧都区'),(141021,'曲沃县'),(141022,'翼城县'),(141023,'襄汾县'),(141024,'洪洞县'),(141025,'古县'),(141026,'安泽县'),(141027,'浮山县'),(141028,'吉县'),(141029,'乡宁县'),(141030,'大宁县'),(141031,'隰县'),(141032,'永和县'),(141033,'蒲县'),(141034,'汾西县'),(141081,'侯马市'),(141082,'霍州市'),(141100,'吕梁市'),(141102,'离石区'),(141121,'文水县'),(141122,'交城县'),(141123,'兴县'),(141124,'临县'),(141125,'柳林县'),(141126,'石楼县'),(141127,'岚县'),(141128,'方山县'),(141129,'中阳县'),(141130,'交口县'),(141181,'孝义市'),(141182,'汾阳市'),(150000,'内蒙古'),(150100,'呼和浩特市'),(150102,'新城区'),(150103,'回民区'),(150104,'玉泉区'),(150105,'赛罕区'),(150121,'土默特左旗'),(150122,'托克托县'),(150123,'和林格尔县'),(150124,'清水河县'),(150125,'武川县'),(150200,'包头市'),(150202,'东河区'),(150203,'昆都仑区'),(150204,'青山区'),(150205,'石拐区'),(150206,'白云鄂博矿区'),(150207,'九原区'),(150221,'土默特右旗'),(150222,'固阳县'),(150223,'达尔罕茂明安联合旗'),(150300,'乌海市'),(150302,'海勃湾区'),(150303,'海南区'),(150304,'乌达区'),(150400,'赤峰市'),(150402,'红山区'),(150403,'元宝山区'),(150404,'松山区'),(150421,'阿鲁科尔沁旗'),(150422,'巴林左旗'),(150423,'巴林右旗'),(150424,'林西县'),(150425,'克什克腾旗'),(150426,'翁牛特旗'),(150428,'喀喇沁旗'),(150429,'宁城县'),(150430,'敖汉旗'),(150500,'通辽市'),(150502,'科尔沁区'),(150521,'科尔沁左翼中旗'),(150522,'科尔沁左翼后旗'),(150523,'开鲁县'),(150524,'库伦旗'),(150525,'奈曼旗'),(150526,'扎鲁特旗'),(150581,'霍林郭勒市'),(150600,'鄂尔多斯市'),(150602,'东胜区'),(150603,'康巴什区'),(150621,'达拉特旗'),(150622,'准格尔旗'),(150623,'鄂托克前旗'),(150624,'鄂托克旗'),(150625,'杭锦旗'),(150626,'乌审旗'),(150627,'伊金霍洛旗'),(150700,'呼伦贝尔市'),(150702,'海拉尔区'),(150703,'扎赉诺尔区'),(150721,'阿荣旗'),(150722,'莫力达瓦达斡尔族自治旗'),(150723,'鄂伦春自治旗'),(150724,'鄂温克族自治旗'),(150725,'陈巴尔虎旗'),(150726,'新巴尔虎左旗'),(150727,'新巴尔虎右旗'),(150781,'满洲里市'),(150782,'牙克石市'),(150783,'扎兰屯市'),(150784,'额尔古纳市'),(150785,'根河市'),(150800,'巴彦淖尔市'),(150802,'临河区'),(150821,'五原县'),(150822,'磴口县'),(150823,'乌拉特前旗'),(150824,'乌拉特中旗'),(150825,'乌拉特后旗'),(150826,'杭锦后旗'),(150900,'乌兰察布市'),(150902,'集宁区'),(150921,'卓资县'),(150922,'化德县'),(150923,'商都县'),(150924,'兴和县'),(150925,'凉城县'),(150926,'察哈尔右翼前旗'),(150927,'察哈尔右翼中旗'),(150928,'察哈尔右翼后旗'),(150929,'四子王旗'),(150981,'丰镇市'),(152200,'兴安盟'),(152201,'乌兰浩特市'),(152202,'阿尔山市'),(152221,'科尔沁右翼前旗'),(152222,'科尔沁右翼中旗'),(152223,'扎赉特旗'),(152224,'突泉县'),(152500,'锡林郭勒盟'),(152501,'二连浩特市'),(152502,'锡林浩特市'),(152522,'阿巴嘎旗'),(152523,'苏尼特左旗'),(152524,'苏尼特右旗'),(152525,'东乌珠穆沁旗'),(152526,'西乌珠穆沁旗'),(152527,'太仆寺旗'),(152528,'镶黄旗'),(152529,'正镶白旗'),(152530,'正蓝旗'),(152531,'多伦县'),(152900,'阿拉善盟'),(152921,'阿拉善左旗'),(152922,'阿拉善右旗'),(152923,'额济纳旗'),(210000,'辽宁'),(210100,'沈阳市'),(210102,'和平区'),(210103,'沈河区'),(210104,'大东区'),(210105,'皇姑区'),(210106,'铁西区'),(210111,'苏家屯区'),(210112,'浑南区'),(210113,'沈北新区'),(210114,'于洪区'),(210115,'辽中区'),(210123,'康平县'),(210124,'法库县'),(210181,'新民市'),(210200,'大连市'),(210202,'中山区'),(210203,'西岗区'),(210204,'沙河口区'),(210211,'甘井子区'),(210212,'旅顺口区'),(210213,'金州区'),(210214,'普兰店区'),(210224,'长海县'),(210281,'瓦房店市'),(210283,'庄河市'),(210300,'鞍山市'),(210302,'铁东区'),(210303,'铁西区'),(210304,'立山区'),(210311,'千山区'),(210321,'台安县'),(210323,'岫岩满族自治县'),(210381,'海城市'),(210400,'抚顺市'),(210402,'新抚区'),(210403,'东洲区'),(210404,'望花区'),(210411,'顺城区'),(210421,'抚顺县'),(210422,'新宾满族自治县'),(210423,'清原满族自治县'),(210500,'本溪市'),(210502,'平山区'),(210503,'溪湖区'),(210504,'明山区'),(210505,'南芬区'),(210521,'本溪满族自治县'),(210522,'桓仁满族自治县'),(210600,'丹东市'),(210602,'元宝区'),(210603,'振兴区'),(210604,'振安区'),(210624,'宽甸满族自治县'),(210681,'东港市'),(210682,'凤城市'),(210700,'锦州市'),(210702,'古塔区'),(210703,'凌河区'),(210711,'太和区'),(210726,'黑山县'),(210727,'义县'),(210781,'凌海市'),(210782,'北镇市'),(210800,'营口市'),(210802,'站前区'),(210803,'西市区'),(210804,'鲅鱼圈区'),(210811,'老边区'),(210881,'盖州市'),(210882,'大石桥市'),(210900,'阜新市'),(210902,'海州区'),(210903,'新邱区'),(210904,'太平区'),(210905,'清河门区'),(210911,'细河区'),(210921,'阜新蒙古族自治县'),(210922,'彰武县'),(211000,'辽阳市'),(211002,'白塔区'),(211003,'文圣区'),(211004,'宏伟区'),(211005,'弓长岭区'),(211011,'太子河区'),(211021,'辽阳县'),(211081,'灯塔市'),(211100,'盘锦市'),(211102,'双台子区'),(211103,'兴隆台区'),(211104,'大洼区'),(211122,'盘山县'),(211200,'铁岭市'),(211202,'银州区'),(211204,'清河区'),(211221,'铁岭县'),(211223,'西丰县'),(211224,'昌图县'),(211281,'调兵山市'),(211282,'开原市'),(211300,'朝阳市'),(211302,'双塔区'),(211303,'龙城区'),(211321,'朝阳县'),(211322,'建平县'),(211324,'喀喇沁左翼蒙古族自治县'),(211381,'北票市'),(211382,'凌源市'),(211400,'葫芦岛市'),(211402,'连山区'),(211403,'龙港区'),(211404,'南票区'),(211421,'绥中县'),(211422,'建昌县'),(211481,'兴城市'),(220000,'吉林'),(220100,'长春市'),(220102,'南关区'),(220103,'宽城区'),(220104,'朝阳区'),(220105,'二道区'),(220106,'绿园区'),(220112,'双阳区'),(220113,'九台区'),(220122,'农安县'),(220182,'榆树市'),(220183,'德惠市'),(220200,'吉林市'),(220202,'昌邑区'),(220203,'龙潭区'),(220204,'船营区'),(220211,'丰满区'),(220221,'永吉县'),(220281,'蛟河市'),(220282,'桦甸市'),(220283,'舒兰市'),(220284,'磐石市'),(220300,'四平市'),(220302,'铁西区'),(220303,'铁东区'),(220322,'梨树县'),(220323,'伊通满族自治县'),(220381,'公主岭市'),(220382,'双辽市'),(220400,'辽源市'),(220402,'龙山区'),(220403,'西安区'),(220421,'东丰县'),(220422,'东辽县'),(220500,'通化市'),(220502,'东昌区'),(220503,'二道江区'),(220521,'通化县'),(220523,'辉南县'),(220524,'柳河县'),(220581,'梅河口市'),(220582,'集安市'),(220600,'白山市'),(220602,'浑江区'),(220605,'江源区'),(220621,'抚松县'),(220622,'靖宇县'),(220623,'长白朝鲜族自治县'),(220681,'临江市'),(220700,'松原市'),(220702,'宁江区'),(220721,'前郭尔罗斯蒙古族自治县'),(220722,'长岭县'),(220723,'乾安县'),(220781,'扶余市'),(220800,'白城市'),(220802,'洮北区'),(220821,'镇赉县'),(220822,'通榆县'),(220881,'洮南市'),(220882,'大安市'),(222400,'延边朝鲜族自治州'),(222401,'延吉市'),(222402,'图们市'),(222403,'敦化市'),(222404,'珲春市'),(222405,'龙井市'),(222406,'和龙市'),(222424,'汪清县'),(222426,'安图县'),(230000,'黑龙江'),(230100,'哈尔滨市'),(230102,'道里区'),(230103,'南岗区'),(230104,'道外区'),(230108,'平房区'),(230109,'松北区'),(230110,'香坊区'),(230111,'呼兰区'),(230112,'阿城区'),(230113,'双城区'),(230123,'依兰县'),(230124,'方正县'),(230125,'宾县'),(230126,'巴彦县'),(230127,'木兰县'),(230128,'通河县'),(230129,'延寿县'),(230183,'尚志市'),(230184,'五常市'),(230200,'齐齐哈尔市'),(230202,'龙沙区'),(230203,'建华区'),(230204,'铁锋区'),(230205,'昂昂溪区'),(230206,'富拉尔基区'),(230207,'碾子山区'),(230208,'梅里斯达斡尔族区'),(230221,'龙江县'),(230223,'依安县'),(230224,'泰来县'),(230225,'甘南县'),(230227,'富裕县'),(230229,'克山县'),(230230,'克东县'),(230231,'拜泉县'),(230281,'讷河市'),(230300,'鸡西市'),(230302,'鸡冠区'),(230303,'恒山区'),(230304,'滴道区'),(230305,'梨树区'),(230306,'城子河区'),(230307,'麻山区'),(230321,'鸡东县'),(230381,'虎林市'),(230382,'密山市'),(230400,'鹤岗市'),(230402,'向阳区'),(230403,'工农区'),(230404,'南山区'),(230405,'兴安区'),(230406,'东山区'),(230407,'兴山区'),(230421,'萝北县'),(230422,'绥滨县'),(230500,'双鸭山市'),(230502,'尖山区'),(230503,'岭东区'),(230505,'四方台区'),(230506,'宝山区'),(230521,'集贤县'),(230522,'友谊县'),(230523,'宝清县'),(230524,'饶河县'),(230600,'大庆市'),(230602,'萨尔图区'),(230603,'龙凤区'),(230604,'让胡路区'),(230605,'红岗区'),(230606,'大同区'),(230621,'肇州县'),(230622,'肇源县'),(230623,'林甸县'),(230624,'杜尔伯特蒙古族自治县'),(230700,'伊春市'),(230717,'伊美区'),(230718,'乌翠区'),(230719,'友好区'),(230722,'嘉荫县'),(230723,'汤旺县'),(230724,'丰林县'),(230725,'大箐山县'),(230726,'南岔县'),(230751,'金林区'),(230781,'铁力市'),(230800,'佳木斯市'),(230803,'向阳区'),(230804,'前进区'),(230805,'东风区'),(230811,'郊区'),(230822,'桦南县'),(230826,'桦川县'),(230828,'汤原县'),(230881,'同江市'),(230882,'富锦市'),(230883,'抚远市'),(230900,'七台河市'),(230902,'新兴区'),(230903,'桃山区'),(230904,'茄子河区'),(230921,'勃利县'),(231000,'牡丹江市'),(231002,'东安区'),(231003,'阳明区'),(231004,'爱民区'),(231005,'西安区'),(231025,'林口县'),(231081,'绥芬河市'),(231083,'海林市'),(231084,'宁安市'),(231085,'穆棱市'),(231086,'东宁市'),(231100,'黑河市'),(231102,'爱辉区'),(231121,'嫩江县'),(231123,'逊克县'),(231124,'孙吴县'),(231181,'北安市'),(231182,'五大连池市'),(231200,'绥化市'),(231202,'北林区'),(231221,'望奎县'),(231222,'兰西县'),(231223,'青冈县'),(231224,'庆安县'),(231225,'明水县'),(231226,'绥棱县'),(231281,'安达市'),(231282,'肇东市'),(231283,'海伦市'),(232700,'大兴安岭地区'),(232701,'漠河市'),(232721,'呼玛县'),(232722,'塔河县'),(310000,'上海'),(310100,'上海市'),(310101,'黄浦区'),(310104,'徐汇区'),(310105,'长宁区'),(310106,'静安区'),(310107,'普陀区'),(310109,'虹口区'),(310110,'杨浦区'),(310112,'闵行区'),(310113,'宝山区'),(310114,'嘉定区'),(310115,'浦东新区'),(310116,'金山区'),(310117,'松江区'),(310118,'青浦区'),(310120,'奉贤区'),(310151,'崇明区'),(320000,'江苏'),(320100,'南京市'),(320102,'玄武区'),(320104,'秦淮区'),(320105,'建邺区'),(320106,'鼓楼区'),(320111,'浦口区'),(320113,'栖霞区'),(320114,'雨花台区'),(320115,'江宁区'),(320116,'六合区'),(320117,'溧水区'),(320118,'高淳区'),(320200,'无锡市'),(320205,'锡山区'),(320206,'惠山区'),(320211,'滨湖区'),(320213,'梁溪区'),(320214,'新吴区'),(320281,'江阴市'),(320282,'宜兴市'),(320300,'徐州市'),(320302,'鼓楼区'),(320303,'云龙区'),(320305,'贾汪区'),(320311,'泉山区'),(320312,'铜山区'),(320321,'丰县'),(320322,'沛县'),(320324,'睢宁县'),(320381,'新沂市'),(320382,'邳州市'),(320400,'常州市'),(320402,'天宁区'),(320404,'钟楼区'),(320411,'新北区'),(320412,'武进区'),(320413,'金坛区'),(320481,'溧阳市'),(320500,'苏州市'),(320505,'虎丘区'),(320506,'吴中区'),(320507,'相城区'),(320508,'姑苏区'),(320509,'吴江区'),(320581,'常熟市'),(320582,'张家港市'),(320583,'昆山市'),(320585,'太仓市'),(320600,'南通市'),(320602,'崇川区'),(320611,'港闸区'),(320612,'通州区'),(320623,'如东县'),(320681,'启东市'),(320682,'如皋市'),(320684,'海门市'),(320685,'海安市'),(320700,'连云港市'),(320703,'连云区'),(320706,'海州区'),(320707,'赣榆区'),(320722,'东海县'),(320723,'灌云县'),(320724,'灌南县'),(320800,'淮安市'),(320803,'淮安区'),(320804,'淮阴区'),(320812,'清江浦区'),(320813,'洪泽区'),(320826,'涟水县'),(320830,'盱眙县'),(320831,'金湖县'),(320900,'盐城市'),(320902,'亭湖区'),(320903,'盐都区'),(320904,'大丰区'),(320921,'响水县'),(320922,'滨海县'),(320923,'阜宁县'),(320924,'射阳县'),(320925,'建湖县'),(320981,'东台市'),(321000,'扬州市'),(321002,'广陵区'),(321003,'邗江区'),(321012,'江都区'),(321023,'宝应县'),(321081,'仪征市'),(321084,'高邮市'),(321100,'镇江市'),(321102,'京口区'),(321111,'润州区'),(321112,'丹徒区'),(321181,'丹阳市'),(321182,'扬中市'),(321183,'句容市'),(321200,'泰州市'),(321202,'海陵区'),(321203,'高港区'),(321204,'姜堰区'),(321281,'兴化市'),(321282,'靖江市'),(321283,'泰兴市'),(321300,'宿迁市'),(321302,'宿城区'),(321311,'宿豫区'),(321322,'沭阳县'),(321323,'泗阳县'),(321324,'泗洪县'),(330000,'浙江'),(330100,'杭州市'),(330102,'上城区'),(330103,'下城区'),(330104,'江干区'),(330105,'拱墅区'),(330106,'西湖区'),(330108,'滨江区'),(330109,'萧山区'),(330110,'余杭区'),(330111,'富阳区'),(330112,'临安区'),(330122,'桐庐县'),(330127,'淳安县'),(330182,'建德市'),(330200,'宁波市'),(330203,'海曙区'),(330205,'江北区'),(330206,'北仑区'),(330211,'镇海区'),(330212,'鄞州区'),(330213,'奉化区'),(330225,'象山县'),(330226,'宁海县'),(330281,'余姚市'),(330282,'慈溪市'),(330300,'温州市'),(330302,'鹿城区'),(330303,'龙湾区'),(330304,'瓯海区'),(330305,'洞头区'),(330324,'永嘉县'),(330326,'平阳县'),(330327,'苍南县'),(330328,'文成县'),(330329,'泰顺县'),(330381,'瑞安市'),(330382,'乐清市'),(330383,'龙港市'),(330400,'嘉兴市'),(330402,'南湖区'),(330411,'秀洲区'),(330421,'嘉善县'),(330424,'海盐县'),(330481,'海宁市'),(330482,'平湖市'),(330483,'桐乡市'),(330500,'湖州市'),(330502,'吴兴区'),(330503,'南浔区'),(330521,'德清县'),(330522,'长兴县'),(330523,'安吉县'),(330600,'绍兴市'),(330602,'越城区'),(330603,'柯桥区'),(330604,'上虞区'),(330624,'新昌县'),(330681,'诸暨市'),(330683,'嵊州市'),(330700,'金华市'),(330702,'婺城区'),(330703,'金东区'),(330723,'武义县'),(330726,'浦江县'),(330727,'磐安县'),(330781,'兰溪市'),(330782,'义乌市'),(330783,'东阳市'),(330784,'永康市'),(330800,'衢州市'),(330802,'柯城区'),(330803,'衢江区'),(330822,'常山县'),(330824,'开化县'),(330825,'龙游县'),(330881,'江山市'),(330900,'舟山市'),(330902,'定海区'),(330903,'普陀区'),(330921,'岱山县'),(330922,'嵊泗县'),(331000,'台州市'),(331002,'椒江区'),(331003,'黄岩区'),(331004,'路桥区'),(331022,'三门县'),(331023,'天台县'),(331024,'仙居县'),(331081,'温岭市'),(331082,'临海市'),(331083,'玉环市'),(331100,'丽水市'),(331102,'莲都区'),(331121,'青田县'),(331122,'缙云县'),(331123,'遂昌县'),(331124,'松阳县'),(331125,'云和县'),(331126,'庆元县'),(331127,'景宁畲族自治县'),(331181,'龙泉市'),(340000,'安徽'),(340100,'合肥市'),(340102,'瑶海区'),(340103,'庐阳区'),(340104,'蜀山区'),(340111,'包河区'),(340121,'长丰县'),(340122,'肥东县'),(340123,'肥西县'),(340124,'庐江县'),(340181,'巢湖市'),(340200,'芜湖市'),(340202,'镜湖区'),(340203,'弋江区'),(340207,'鸠江区'),(340208,'三山区'),(340221,'芜湖县'),(340222,'繁昌县'),(340223,'南陵县'),(340225,'无为县'),(340300,'蚌埠市'),(340302,'龙子湖区'),(340303,'蚌山区'),(340304,'禹会区'),(340311,'淮上区'),(340321,'怀远县'),(340322,'五河县'),(340323,'固镇县'),(340400,'淮南市'),(340402,'大通区'),(340403,'田家庵区'),(340404,'谢家集区'),(340405,'八公山区'),(340406,'潘集区'),(340421,'凤台县'),(340422,'寿县'),(340500,'马鞍山市'),(340503,'花山区'),(340504,'雨山区'),(340506,'博望区'),(340521,'当涂县'),(340522,'含山县'),(340523,'和县'),(340600,'淮北市'),(340602,'杜集区'),(340603,'相山区'),(340604,'烈山区'),(340621,'濉溪县'),(340700,'铜陵市'),(340705,'铜官区'),(340706,'义安区'),(340711,'郊区'),(340722,'枞阳县'),(340800,'安庆市'),(340802,'迎江区'),(340803,'大观区'),(340811,'宜秀区'),(340822,'怀宁县'),(340825,'太湖县'),(340826,'宿松县'),(340827,'望江县'),(340828,'岳西县'),(340881,'桐城市'),(340882,'潜山市'),(341000,'黄山市'),(341002,'屯溪区'),(341003,'黄山区'),(341004,'徽州区'),(341021,'歙县'),(341022,'休宁县'),(341023,'黟县'),(341024,'祁门县'),(341100,'滁州市'),(341102,'琅琊区'),(341103,'南谯区'),(341122,'来安县'),(341124,'全椒县'),(341125,'定远县'),(341126,'凤阳县'),(341181,'天长市'),(341182,'明光市'),(341200,'阜阳市'),(341202,'颍州区'),(341203,'颍东区'),(341204,'颍泉区'),(341221,'临泉县'),(341222,'太和县'),(341225,'阜南县'),(341226,'颍上县'),(341282,'界首市'),(341300,'宿州市'),(341302,'埇桥区'),(341321,'砀山县'),(341322,'萧县'),(341323,'灵璧县'),(341324,'泗县'),(341500,'六安市'),(341502,'金安区'),(341503,'裕安区'),(341504,'叶集区'),(341522,'霍邱县'),(341523,'舒城县'),(341524,'金寨县'),(341525,'霍山县'),(341600,'亳州市'),(341602,'谯城区'),(341621,'涡阳县'),(341622,'蒙城县'),(341623,'利辛县'),(341700,'池州市'),(341702,'贵池区'),(341721,'东至县'),(341722,'石台县'),(341723,'青阳县'),(341800,'宣城市'),(341802,'宣州区'),(341821,'郎溪县'),(341823,'泾县'),(341824,'绩溪县'),(341825,'旌德县'),(341881,'宁国市'),(341882,'广德市'),(350000,'福建'),(350100,'福州市'),(350102,'鼓楼区'),(350103,'台江区'),(350104,'仓山区'),(350105,'马尾区'),(350111,'晋安区'),(350112,'长乐区'),(350121,'闽侯县'),(350122,'连江县'),(350123,'罗源县'),(350124,'闽清县'),(350125,'永泰县'),(350128,'平潭县'),(350181,'福清市'),(350200,'厦门市'),(350203,'思明区'),(350205,'海沧区'),(350206,'湖里区'),(350211,'集美区'),(350212,'同安区'),(350213,'翔安区'),(350300,'莆田市'),(350302,'城厢区'),(350303,'涵江区'),(350304,'荔城区'),(350305,'秀屿区'),(350322,'仙游县'),(350400,'三明市'),(350402,'梅列区'),(350403,'三元区'),(350421,'明溪县'),(350423,'清流县'),(350424,'宁化县'),(350425,'大田县'),(350426,'尤溪县'),(350427,'沙县'),(350428,'将乐县'),(350429,'泰宁县'),(350430,'建宁县'),(350481,'永安市'),(350500,'泉州市'),(350502,'鲤城区'),(350503,'丰泽区'),(350504,'洛江区'),(350505,'泉港区'),(350521,'惠安县'),(350524,'安溪县'),(350525,'永春县'),(350526,'德化县'),(350527,'金门县'),(350581,'石狮市'),(350582,'晋江市'),(350583,'南安市'),(350600,'漳州市'),(350602,'芗城区'),(350603,'龙文区'),(350622,'云霄县'),(350623,'漳浦县'),(350624,'诏安县'),(350625,'长泰县'),(350626,'东山县'),(350627,'南靖县'),(350628,'平和县'),(350629,'华安县'),(350681,'龙海市'),(350700,'南平市'),(350702,'延平区'),(350703,'建阳区'),(350721,'顺昌县'),(350722,'浦城县'),(350723,'光泽县'),(350724,'松溪县'),(350725,'政和县'),(350781,'邵武市'),(350782,'武夷山市'),(350783,'建瓯市'),(350800,'龙岩市'),(350802,'新罗区'),(350803,'永定区'),(350821,'长汀县'),(350823,'上杭县'),(350824,'武平县'),(350825,'连城县'),(350881,'漳平市'),(350900,'宁德市'),(350902,'蕉城区'),(350921,'霞浦县'),(350922,'古田县'),(350923,'屏南县'),(350924,'寿宁县'),(350925,'周宁县'),(350926,'柘荣县'),(350981,'福安市'),(350982,'福鼎市'),(360000,'江西'),(360100,'南昌市'),(360102,'东湖区'),(360103,'西湖区'),(360104,'青云谱区'),(360105,'湾里区'),(360111,'青山湖区'),(360112,'新建区'),(360121,'南昌县'),(360123,'安义县'),(360124,'进贤县'),(360200,'景德镇市'),(360202,'昌江区'),(360203,'珠山区'),(360222,'浮梁县'),(360281,'乐平市'),(360300,'萍乡市'),(360302,'安源区'),(360313,'湘东区'),(360321,'莲花县'),(360322,'上栗县'),(360323,'芦溪县'),(360400,'九江市'),(360402,'濂溪区'),(360403,'浔阳区'),(360404,'柴桑区'),(360423,'武宁县'),(360424,'修水县'),(360425,'永修县'),(360426,'德安县'),(360428,'都昌县'),(360429,'湖口县'),(360430,'彭泽县'),(360481,'瑞昌市'),(360482,'共青城市'),(360483,'庐山市'),(360500,'新余市'),(360502,'渝水区'),(360521,'分宜县'),(360600,'鹰潭市'),(360602,'月湖区'),(360603,'余江区'),(360681,'贵溪市'),(360700,'赣州市'),(360702,'章贡区'),(360703,'南康区'),(360704,'赣县区'),(360722,'信丰县'),(360723,'大余县'),(360724,'上犹县'),(360725,'崇义县'),(360726,'安远县'),(360727,'龙南县'),(360728,'定南县'),(360729,'全南县'),(360730,'宁都县'),(360731,'于都县'),(360732,'兴国县'),(360733,'会昌县'),(360734,'寻乌县'),(360735,'石城县'),(360781,'瑞金市'),(360800,'吉安市'),(360802,'吉州区'),(360803,'青原区'),(360821,'吉安县'),(360822,'吉水县'),(360823,'峡江县'),(360824,'新干县'),(360825,'永丰县'),(360826,'泰和县'),(360827,'遂川县'),(360828,'万安县'),(360829,'安福县'),(360830,'永新县'),(360881,'井冈山市'),(360900,'宜春市'),(360902,'袁州区'),(360921,'奉新县'),(360922,'万载县'),(360923,'上高县'),(360924,'宜丰县'),(360925,'靖安县'),(360926,'铜鼓县'),(360981,'丰城市'),(360982,'樟树市'),(360983,'高安市'),(361000,'抚州市'),(361002,'临川区'),(361003,'东乡区'),(361021,'南城县'),(361022,'黎川县'),(361023,'南丰县'),(361024,'崇仁县'),(361025,'乐安县'),(361026,'宜黄县'),(361027,'金溪县'),(361028,'资溪县'),(361030,'广昌县'),(361100,'上饶市'),(361102,'信州区'),(361103,'广丰区'),(361104,'广信区'),(361123,'玉山县'),(361124,'铅山县'),(361125,'横峰县'),(361126,'弋阳县'),(361127,'余干县'),(361128,'鄱阳县'),(361129,'万年县'),(361130,'婺源县'),(361181,'德兴市'),(370000,'山东'),(370100,'济南市'),(370102,'历下区'),(370103,'市中区'),(370104,'槐荫区'),(370105,'天桥区'),(370112,'历城区'),(370113,'长清区'),(370114,'章丘区'),(370115,'济阳区'),(370116,'莱芜区'),(370117,'钢城区'),(370124,'平阴县'),(370126,'商河县'),(370200,'青岛市'),(370202,'市南区'),(370203,'市北区'),(370211,'黄岛区'),(370212,'崂山区'),(370213,'李沧区'),(370214,'城阳区'),(370215,'即墨区'),(370281,'胶州市'),(370283,'平度市'),(370285,'莱西市'),(370300,'淄博市'),(370302,'淄川区'),(370303,'张店区'),(370304,'博山区'),(370305,'临淄区'),(370306,'周村区'),(370321,'桓台县'),(370322,'高青县'),(370323,'沂源县'),(370400,'枣庄市'),(370402,'市中区'),(370403,'薛城区'),(370404,'峄城区'),(370405,'台儿庄区'),(370406,'山亭区'),(370481,'滕州市'),(370500,'东营市'),(370502,'东营区'),(370503,'河口区'),(370505,'垦利区'),(370522,'利津县'),(370523,'广饶县'),(370600,'烟台市'),(370602,'芝罘区'),(370611,'福山区'),(370612,'牟平区'),(370613,'莱山区'),(370634,'长岛县'),(370681,'龙口市'),(370682,'莱阳市'),(370683,'莱州市'),(370684,'蓬莱市'),(370685,'招远市'),(370686,'栖霞市'),(370687,'海阳市'),(370700,'潍坊市'),(370702,'潍城区'),(370703,'寒亭区'),(370704,'坊子区'),(370705,'奎文区'),(370724,'临朐县'),(370725,'昌乐县'),(370781,'青州市'),(370782,'诸城市'),(370783,'寿光市'),(370784,'安丘市'),(370785,'高密市'),(370786,'昌邑市'),(370800,'济宁市'),(370811,'任城区'),(370812,'兖州区'),(370826,'微山县'),(370827,'鱼台县'),(370828,'金乡县'),(370829,'嘉祥县'),(370830,'汶上县'),(370831,'泗水县'),(370832,'梁山县'),(370881,'曲阜市'),(370883,'邹城市'),(370900,'泰安市'),(370902,'泰山区'),(370911,'岱岳区'),(370921,'宁阳县'),(370923,'东平县'),(370982,'新泰市'),(370983,'肥城市'),(371000,'威海市'),(371002,'环翠区'),(371003,'文登区'),(371082,'荣成市'),(371083,'乳山市'),(371100,'日照市'),(371102,'东港区'),(371103,'岚山区'),(371121,'五莲县'),(371122,'莒县'),(371300,'临沂市'),(371302,'兰山区'),(371311,'罗庄区'),(371312,'河东区'),(371321,'沂南县'),(371322,'郯城县'),(371323,'沂水县'),(371324,'兰陵县'),(371325,'费县'),(371326,'平邑县'),(371327,'莒南县'),(371328,'蒙阴县'),(371329,'临沭县'),(371400,'德州市'),(371402,'德城区'),(371403,'陵城区'),(371422,'宁津县'),(371423,'庆云县'),(371424,'临邑县'),(371425,'齐河县'),(371426,'平原县'),(371427,'夏津县'),(371428,'武城县'),(371481,'乐陵市'),(371482,'禹城市'),(371500,'聊城市'),(371502,'东昌府区'),(371521,'阳谷县'),(371522,'莘县'),(371523,'茌平县'),(371524,'东阿县'),(371525,'冠县'),(371526,'高唐县'),(371581,'临清市'),(371600,'滨州市'),(371602,'滨城区'),(371603,'沾化区'),(371621,'惠民县'),(371622,'阳信县'),(371623,'无棣县'),(371625,'博兴县'),(371681,'邹平市'),(371700,'菏泽市'),(371702,'牡丹区'),(371703,'定陶区'),(371721,'曹县'),(371722,'单县'),(371723,'成武县'),(371724,'巨野县'),(371725,'郓城县'),(371726,'鄄城县'),(371728,'东明县'),(410000,'河南'),(410100,'郑州市'),(410102,'中原区'),(410103,'二七区'),(410104,'管城回族区'),(410105,'金水区'),(410106,'上街区'),(410108,'惠济区'),(410122,'中牟县'),(410181,'巩义市'),(410182,'荥阳市'),(410183,'新密市'),(410184,'新郑市'),(410185,'登封市'),(410200,'开封市'),(410202,'龙亭区'),(410203,'顺河回族区'),(410204,'鼓楼区'),(410205,'禹王台区'),(410212,'祥符区'),(410221,'杞县'),(410222,'通许县'),(410223,'尉氏县'),(410225,'兰考县'),(410300,'洛阳市'),(410302,'老城区'),(410303,'西工区'),(410304,'瀍河回族区'),(410305,'涧西区'),(410306,'吉利区'),(410311,'洛龙区'),(410322,'孟津县'),(410323,'新安县'),(410324,'栾川县'),(410325,'嵩县'),(410326,'汝阳县'),(410327,'宜阳县'),(410328,'洛宁县'),(410329,'伊川县'),(410381,'偃师市'),(410400,'平顶山市'),(410402,'新华区'),(410403,'卫东区'),(410404,'石龙区'),(410411,'湛河区'),(410421,'宝丰县'),(410422,'叶县'),(410423,'鲁山县'),(410425,'郏县'),(410481,'舞钢市'),(410482,'汝州市'),(410500,'安阳市'),(410502,'文峰区'),(410503,'北关区'),(410505,'殷都区'),(410506,'龙安区'),(410522,'安阳县'),(410523,'汤阴县'),(410526,'滑县'),(410527,'内黄县'),(410581,'林州市'),(410600,'鹤壁市'),(410602,'鹤山区'),(410603,'山城区'),(410611,'淇滨区'),(410621,'浚县'),(410622,'淇县'),(410700,'新乡市'),(410702,'红旗区'),(410703,'卫滨区'),(410704,'凤泉区'),(410711,'牧野区'),(410721,'新乡县'),(410724,'获嘉县'),(410725,'原阳县'),(410726,'延津县'),(410727,'封丘县'),(410728,'长垣县'),(410781,'卫辉市'),(410782,'辉县市'),(410800,'焦作市'),(410802,'解放区'),(410803,'中站区'),(410804,'马村区'),(410811,'山阳区'),(410821,'修武县'),(410822,'博爱县'),(410823,'武陟县'),(410825,'温县'),(410882,'沁阳市'),(410883,'孟州市'),(410900,'濮阳市'),(410902,'华龙区'),(410922,'清丰县'),(410923,'南乐县'),(410926,'范县'),(410927,'台前县'),(410928,'濮阳县'),(411000,'许昌市'),(411002,'魏都区'),(411003,'建安区'),(411024,'鄢陵县'),(411025,'襄城县'),(411081,'禹州市'),(411082,'长葛市'),(411100,'漯河市'),(411102,'源汇区'),(411103,'郾城区'),(411104,'召陵区'),(411121,'舞阳县'),(411122,'临颍县'),(411200,'三门峡市'),(411202,'湖滨区'),(411203,'陕州区'),(411221,'渑池县'),(411224,'卢氏县'),(411281,'义马市'),(411282,'灵宝市'),(411300,'南阳市'),(411302,'宛城区'),(411303,'卧龙区'),(411321,'南召县'),(411322,'方城县'),(411323,'西峡县'),(411324,'镇平县'),(411325,'内乡县'),(411326,'淅川县'),(411327,'社旗县'),(411328,'唐河县'),(411329,'新野县'),(411330,'桐柏县'),(411381,'邓州市'),(411400,'商丘市'),(411402,'梁园区'),(411403,'睢阳区'),(411421,'民权县'),(411422,'睢县'),(411423,'宁陵县'),(411424,'柘城县'),(411425,'虞城县'),(411426,'夏邑县'),(411481,'永城市'),(411500,'信阳市'),(411502,'浉河区'),(411503,'平桥区'),(411521,'罗山县'),(411522,'光山县'),(411523,'新县'),(411524,'商城县'),(411525,'固始县'),(411526,'潢川县'),(411527,'淮滨县'),(411528,'息县'),(411600,'周口市'),(411602,'川汇区'),(411603,'淮阳区'),(411621,'扶沟县'),(411622,'西华县'),(411623,'商水县'),(411624,'沈丘县'),(411625,'郸城县'),(411627,'太康县'),(411628,'鹿邑县'),(411681,'项城市'),(411700,'驻马店市'),(411702,'驿城区'),(411721,'西平县'),(411722,'上蔡县'),(411723,'平舆县'),(411724,'正阳县'),(411725,'确山县'),(411726,'泌阳县'),(411727,'汝南县'),(411728,'遂平县'),(411729,'新蔡县'),(419000,'济源市'),(419001,'济源市'),(420000,'湖北'),(420100,'武汉市'),(420102,'江岸区'),(420103,'江汉区'),(420104,'硚口区'),(420105,'汉阳区'),(420106,'武昌区'),(420107,'青山区'),(420111,'洪山区'),(420112,'东西湖区'),(420113,'汉南区'),(420114,'蔡甸区'),(420115,'江夏区'),(420116,'黄陂区'),(420117,'新洲区'),(420200,'黄石市'),(420202,'黄石港区'),(420203,'西塞山区'),(420204,'下陆区'),(420205,'铁山区'),(420222,'阳新县'),(420281,'大冶市'),(420300,'十堰市'),(420302,'茅箭区'),(420303,'张湾区'),(420304,'郧阳区'),(420322,'郧西县'),(420323,'竹山县'),(420324,'竹溪县'),(420325,'房县'),(420381,'丹江口市'),(420500,'宜昌市'),(420502,'西陵区'),(420503,'伍家岗区'),(420504,'点军区'),(420505,'猇亭区'),(420506,'夷陵区'),(420525,'远安县'),(420526,'兴山县'),(420527,'秭归县'),(420528,'长阳土家族自治县'),(420529,'五峰土家族自治县'),(420581,'宜都市'),(420582,'当阳市'),(420583,'枝江市'),(420600,'襄阳市'),(420602,'襄城区'),(420606,'樊城区'),(420607,'襄州区'),(420624,'南漳县'),(420625,'谷城县'),(420626,'保康县'),(420682,'老河口市'),(420683,'枣阳市'),(420684,'宜城市'),(420700,'鄂州市'),(420702,'梁子湖区'),(420703,'华容区'),(420704,'鄂城区'),(420800,'荆门市'),(420802,'东宝区'),(420804,'掇刀区'),(420822,'沙洋县'),(420881,'钟祥市'),(420882,'京山市'),(420900,'孝感市'),(420902,'孝南区'),(420921,'孝昌县'),(420922,'大悟县'),(420923,'云梦县'),(420981,'应城市'),(420982,'安陆市'),(420984,'汉川市'),(421000,'荆州市'),(421002,'沙市区'),(421003,'荆州区'),(421022,'公安县'),(421023,'监利县'),(421024,'江陵县'),(421081,'石首市'),(421083,'洪湖市'),(421087,'松滋市'),(421100,'黄冈市'),(421102,'黄州区'),(421121,'团风县'),(421122,'红安县'),(421123,'罗田县'),(421124,'英山县'),(421125,'浠水县'),(421126,'蕲春县'),(421127,'黄梅县'),(421181,'麻城市'),(421182,'武穴市'),(421200,'咸宁市'),(421202,'咸安区'),(421221,'嘉鱼县'),(421222,'通城县'),(421223,'崇阳县'),(421224,'通山县'),(421281,'赤壁市'),(421300,'随州市'),(421303,'曾都区'),(421321,'随县'),(421381,'广水市'),(422800,'恩施土家族苗族自治州'),(422801,'恩施市'),(422802,'利川市'),(422822,'建始县'),(422823,'巴东县'),(422825,'宣恩县'),(422826,'咸丰县'),(422827,'来凤县'),(422828,'鹤峰县'),(429000,'仙桃市'),(429001,'仙桃市'),(429100,'潜江市'),(429101,'潜江市'),(429200,'天门市'),(429201,'天门市'),(429300,'神农架林区'),(429301,'神农架林区'),(430000,'湖南'),(430100,'长沙市'),(430102,'芙蓉区'),(430103,'天心区'),(430104,'岳麓区'),(430105,'开福区'),(430111,'雨花区'),(430112,'望城区'),(430121,'长沙县'),(430181,'浏阳市'),(430182,'宁乡市'),(430200,'株洲市'),(430202,'荷塘区'),(430203,'芦淞区'),(430204,'石峰区'),(430211,'天元区'),(430212,'渌口区'),(430223,'攸县'),(430224,'茶陵县'),(430225,'炎陵县'),(430281,'醴陵市'),(430300,'湘潭市'),(430302,'雨湖区'),(430304,'岳塘区'),(430321,'湘潭县'),(430381,'湘乡市'),(430382,'韶山市'),(430400,'衡阳市'),(430405,'珠晖区'),(430406,'雁峰区'),(430407,'石鼓区'),(430408,'蒸湘区'),(430412,'南岳区'),(430421,'衡阳县'),(430422,'衡南县'),(430423,'衡山县'),(430424,'衡东县'),(430426,'祁东县'),(430481,'耒阳市'),(430482,'常宁市'),(430500,'邵阳市'),(430502,'双清区'),(430503,'大祥区'),(430511,'北塔区'),(430522,'新邵县'),(430523,'邵阳县'),(430524,'隆回县'),(430525,'洞口县'),(430527,'绥宁县'),(430528,'新宁县'),(430529,'城步苗族自治县'),(430581,'武冈市'),(430582,'邵东市'),(430600,'岳阳市'),(430602,'岳阳楼区'),(430603,'云溪区'),(430611,'君山区'),(430621,'岳阳县'),(430623,'华容县'),(430624,'湘阴县'),(430626,'平江县'),(430681,'汨罗市'),(430682,'临湘市'),(430700,'常德市'),(430702,'武陵区'),(430703,'鼎城区'),(430721,'安乡县'),(430722,'汉寿县'),(430723,'澧县'),(430724,'临澧县'),(430725,'桃源县'),(430726,'石门县'),(430781,'津市市'),(430800,'张家界市'),(430802,'永定区'),(430811,'武陵源区'),(430821,'慈利县'),(430822,'桑植县'),(430900,'益阳市'),(430902,'资阳区'),(430903,'赫山区'),(430921,'南县'),(430922,'桃江县'),(430923,'安化县'),(430981,'沅江市'),(431000,'郴州市'),(431002,'北湖区'),(431003,'苏仙区'),(431021,'桂阳县'),(431022,'宜章县'),(431023,'永兴县'),(431024,'嘉禾县'),(431025,'临武县'),(431026,'汝城县'),(431027,'桂东县'),(431028,'安仁县'),(431081,'资兴市'),(431100,'永州市'),(431102,'零陵区'),(431103,'冷水滩区'),(431121,'祁阳县'),(431122,'东安县'),(431123,'双牌县'),(431124,'道县'),(431125,'江永县'),(431126,'宁远县'),(431127,'蓝山县'),(431128,'新田县'),(431129,'江华瑶族自治县'),(431200,'怀化市'),(431202,'鹤城区'),(431221,'中方县'),(431222,'沅陵县'),(431223,'辰溪县'),(431224,'溆浦县'),(431225,'会同县'),(431226,'麻阳苗族自治县'),(431227,'新晃侗族自治县'),(431228,'芷江侗族自治县'),(431229,'靖州苗族侗族自治县'),(431230,'通道侗族自治县'),(431281,'洪江市'),(431300,'娄底市'),(431302,'娄星区'),(431321,'双峰县'),(431322,'新化县'),(431381,'冷水江市'),(431382,'涟源市'),(433100,'湘西土家族苗族自治州'),(433101,'吉首市'),(433122,'泸溪县'),(433123,'凤凰县'),(433124,'花垣县'),(433125,'保靖县'),(433126,'古丈县'),(433127,'永顺县'),(433130,'龙山县'),(440000,'广东'),(440100,'广州市'),(440103,'荔湾区'),(440104,'越秀区'),(440105,'海珠区'),(440106,'天河区'),(440111,'白云区'),(440112,'黄埔区'),(440113,'番禺区'),(440114,'花都区'),(440115,'南沙区'),(440117,'从化区'),(440118,'增城区'),(440200,'韶关市'),(440203,'武江区'),(440204,'浈江区'),(440205,'曲江区'),(440222,'始兴县'),(440224,'仁化县'),(440229,'翁源县'),(440232,'乳源瑶族自治县'),(440233,'新丰县'),(440281,'乐昌市'),(440282,'南雄市'),(440300,'深圳市'),(440303,'罗湖区'),(440304,'福田区'),(440305,'南山区'),(440306,'宝安区'),(440307,'龙岗区'),(440308,'盐田区'),(440309,'龙华区'),(440310,'坪山区'),(440311,'光明区'),(440400,'珠海市'),(440402,'香洲区'),(440403,'斗门区'),(440404,'金湾区'),(440500,'汕头市'),(440507,'龙湖区'),(440511,'金平区'),(440512,'濠江区'),(440513,'潮阳区'),(440514,'潮南区'),(440515,'澄海区'),(440523,'南澳县'),(440600,'佛山市'),(440604,'禅城区'),(440605,'南海区'),(440606,'顺德区'),(440607,'三水区'),(440608,'高明区'),(440700,'江门市'),(440703,'蓬江区'),(440704,'江海区'),(440705,'新会区'),(440781,'台山市'),(440783,'开平市'),(440784,'鹤山市'),(440785,'恩平市'),(440800,'湛江市'),(440802,'赤坎区'),(440803,'霞山区'),(440804,'坡头区'),(440811,'麻章区'),(440823,'遂溪县'),(440825,'徐闻县'),(440881,'廉江市'),(440882,'雷州市'),(440883,'吴川市'),(440900,'茂名市'),(440902,'茂南区'),(440904,'电白区'),(440981,'高州市'),(440982,'化州市'),(440983,'信宜市'),(441200,'肇庆市'),(441202,'端州区'),(441203,'鼎湖区'),(441204,'高要区'),(441223,'广宁县'),(441224,'怀集县'),(441225,'封开县'),(441226,'德庆县'),(441284,'四会市'),(441300,'惠州市'),(441302,'惠城区'),(441303,'惠阳区'),(441322,'博罗县'),(441323,'惠东县'),(441324,'龙门县'),(441400,'梅州市'),(441402,'梅江区'),(441403,'梅县区'),(441422,'大埔县'),(441423,'丰顺县'),(441424,'五华县'),(441426,'平远县'),(441427,'蕉岭县'),(441481,'兴宁市'),(441500,'汕尾市'),(441502,'城区'),(441521,'海丰县'),(441523,'陆河县'),(441581,'陆丰市'),(441600,'河源市'),(441602,'源城区'),(441621,'紫金县'),(441622,'龙川县'),(441623,'连平县'),(441624,'和平县'),(441625,'东源县'),(441700,'阳江市'),(441702,'江城区'),(441704,'阳东区'),(441721,'阳西县'),(441781,'阳春市'),(441800,'清远市'),(441802,'清城区'),(441803,'清新区'),(441821,'佛冈县'),(441823,'阳山县'),(441825,'连山壮族瑶族自治县'),(441826,'连南瑶族自治县'),(441881,'英德市'),(441882,'连州市'),(441900,'东莞市'),(442000,'中山市'),(445100,'潮州市'),(445102,'湘桥区'),(445103,'潮安区'),(445122,'饶平县'),(445200,'揭阳市'),(445202,'榕城区'),(445203,'揭东区'),(445222,'揭西县'),(445224,'惠来县'),(445281,'普宁市'),(445300,'云浮市'),(445302,'云城区'),(445303,'云安区'),(445321,'新兴县'),(445322,'郁南县'),(445381,'罗定市'),(450000,'广西'),(450100,'南宁市'),(450102,'兴宁区'),(450103,'青秀区'),(450105,'江南区'),(450107,'西乡塘区'),(450108,'良庆区'),(450109,'邕宁区'),(450110,'武鸣区'),(450123,'隆安县'),(450124,'马山县'),(450125,'上林县'),(450126,'宾阳县'),(450127,'横县'),(450200,'柳州市'),(450202,'城中区'),(450203,'鱼峰区'),(450204,'柳南区'),(450205,'柳北区'),(450206,'柳江区'),(450222,'柳城县'),(450223,'鹿寨县'),(450224,'融安县'),(450225,'融水苗族自治县'),(450226,'三江侗族自治县'),(450300,'桂林市'),(450302,'秀峰区'),(450303,'叠彩区'),(450304,'象山区'),(450305,'七星区'),(450311,'雁山区'),(450312,'临桂区'),(450321,'阳朔县'),(450323,'灵川县'),(450324,'全州县'),(450325,'兴安县'),(450326,'永福县'),(450327,'灌阳县'),(450328,'龙胜各族自治县'),(450329,'资源县'),(450330,'平乐县'),(450332,'恭城瑶族自治县'),(450381,'荔浦市'),(450400,'梧州市'),(450403,'万秀区'),(450405,'长洲区'),(450406,'龙圩区'),(450421,'苍梧县'),(450422,'藤县'),(450423,'蒙山县'),(450481,'岑溪市'),(450500,'北海市'),(450502,'海城区'),(450503,'银海区'),(450512,'铁山港区'),(450521,'合浦县'),(450600,'防城港市'),(450602,'港口区'),(450603,'防城区'),(450621,'上思县'),(450681,'东兴市'),(450700,'钦州市'),(450702,'钦南区'),(450703,'钦北区'),(450721,'灵山县'),(450722,'浦北县'),(450800,'贵港市'),(450802,'港北区'),(450803,'港南区'),(450804,'覃塘区'),(450821,'平南县'),(450881,'桂平市'),(450900,'玉林市'),(450902,'玉州区'),(450903,'福绵区'),(450921,'容县'),(450922,'陆川县'),(450923,'博白县'),(450924,'兴业县'),(450981,'北流市'),(451000,'百色市'),(451002,'右江区'),(451003,'田阳区'),(451022,'田东县'),(451023,'平果县'),(451024,'德保县'),(451026,'那坡县'),(451027,'凌云县'),(451028,'乐业县'),(451029,'田林县'),(451030,'西林县'),(451031,'隆林各族自治县'),(451081,'靖西市'),(451100,'贺州市'),(451102,'八步区'),(451103,'平桂区'),(451121,'昭平县'),(451122,'钟山县'),(451123,'富川瑶族自治县'),(451200,'河池市'),(451202,'金城江区'),(451203,'宜州区'),(451221,'南丹县'),(451222,'天峨县'),(451223,'凤山县'),(451224,'东兰县'),(451225,'罗城仫佬族自治县'),(451226,'环江毛南族自治县'),(451227,'巴马瑶族自治县'),(451228,'都安瑶族自治县'),(451229,'大化瑶族自治县'),(451300,'来宾市'),(451302,'兴宾区'),(451321,'忻城县'),(451322,'象州县'),(451323,'武宣县'),(451324,'金秀瑶族自治县'),(451381,'合山市'),(451400,'崇左市'),(451402,'江州区'),(451421,'扶绥县'),(451422,'宁明县'),(451423,'龙州县'),(451424,'大新县'),(451425,'天等县'),(451481,'凭祥市'),(460000,'海南'),(460100,'海口市'),(460105,'秀英区'),(460106,'龙华区'),(460107,'琼山区'),(460108,'美兰区'),(460200,'三亚市'),(460202,'海棠区'),(460203,'吉阳区'),(460204,'天涯区'),(460205,'崖州区'),(460300,'三沙市'),(460400,'儋州市'),(468000,'五指山'),(468001,'五指山'),(468100,'琼海市'),(468101,'琼海市'),(468200,'文昌市'),(468201,'文昌市'),(468300,'万宁市'),(468301,'万宁市'),(468400,'东方市'),(468401,'东方市'),(468500,'定安县'),(468501,'定安县'),(468600,'屯昌县'),(468601,'屯昌县'),(468700,'澄迈县'),(468701,'澄迈县'),(468800,'临高县'),(468801,'临高县'),(468900,'白沙'),(468901,'白沙'),(469000,'昌江'),(469001,'昌江'),(469100,'乐东'),(469101,'乐东'),(469200,'陵水'),(469201,'陵水'),(469300,'保亭'),(469301,'保亭'),(469400,'琼中'),(469401,'琼中'),(500000,'重庆'),(500100,'重庆市'),(500101,'万州区'),(500102,'涪陵区'),(500103,'渝中区'),(500104,'大渡口区'),(500105,'江北区'),(500106,'沙坪坝区'),(500107,'九龙坡区'),(500108,'南岸区'),(500109,'北碚区'),(500110,'綦江区'),(500111,'大足区'),(500112,'渝北区'),(500113,'巴南区'),(500114,'黔江区'),(500115,'长寿区'),(500116,'江津区'),(500117,'合川区'),(500118,'永川区'),(500119,'南川区'),(500120,'璧山区'),(500151,'铜梁区'),(500152,'潼南区'),(500153,'荣昌区'),(500154,'开州区'),(500155,'梁平区'),(500156,'武隆区'),(500180,'城口县'),(500181,'丰都县'),(500182,'垫江县'),(500183,'忠县'),(500184,'云阳县'),(500185,'奉节县'),(500186,'巫山县'),(500187,'巫溪县'),(500188,'石柱'),(500189,'秀山'),(500190,'酉阳'),(500191,'彭水'),(510000,'四川'),(510100,'成都市'),(510104,'锦江区'),(510105,'青羊区'),(510106,'金牛区'),(510107,'武侯区'),(510108,'成华区'),(510112,'龙泉驿区'),(510113,'青白江区'),(510114,'新都区'),(510115,'温江区'),(510116,'双流区'),(510117,'郫都区'),(510121,'金堂县'),(510129,'大邑县'),(510131,'蒲江县'),(510132,'新津县'),(510181,'都江堰市'),(510182,'彭州市'),(510183,'邛崃市'),(510184,'崇州市'),(510185,'简阳市'),(510300,'自贡市'),(510302,'自流井区'),(510303,'贡井区'),(510304,'大安区'),(510311,'沿滩区'),(510321,'荣县'),(510322,'富顺县'),(510400,'攀枝花市'),(510402,'东区'),(510403,'西区'),(510411,'仁和区'),(510421,'米易县'),(510422,'盐边县'),(510500,'泸州市'),(510502,'江阳区'),(510503,'纳溪区'),(510504,'龙马潭区'),(510521,'泸县'),(510522,'合江县'),(510524,'叙永县'),(510525,'古蔺县'),(510600,'德阳市'),(510603,'旌阳区'),(510604,'罗江区'),(510623,'中江县'),(510681,'广汉市'),(510682,'什邡市'),(510683,'绵竹市'),(510700,'绵阳市'),(510703,'涪城区'),(510704,'游仙区'),(510705,'安州区'),(510722,'三台县'),(510723,'盐亭县'),(510725,'梓潼县'),(510726,'北川羌族自治县'),(510727,'平武县'),(510781,'江油市'),(510800,'广元市'),(510802,'利州区'),(510811,'昭化区'),(510812,'朝天区'),(510821,'旺苍县'),(510822,'青川县'),(510823,'剑阁县'),(510824,'苍溪县'),(510900,'遂宁市'),(510903,'船山区'),(510904,'安居区'),(510921,'蓬溪县'),(510923,'大英县'),(510981,'射洪市'),(511000,'内江市'),(511002,'市中区'),(511011,'东兴区'),(511024,'威远县'),(511025,'资中县'),(511083,'隆昌市'),(511100,'乐山市'),(511102,'市中区'),(511111,'沙湾区'),(511112,'五通桥区'),(511113,'金口河区'),(511123,'犍为县'),(511124,'井研县'),(511126,'夹江县'),(511129,'沐川县'),(511132,'峨边彝族自治县'),(511133,'马边彝族自治县'),(511181,'峨眉山市'),(511300,'南充市'),(511302,'顺庆区'),(511303,'高坪区'),(511304,'嘉陵区'),(511321,'南部县'),(511322,'营山县'),(511323,'蓬安县'),(511324,'仪陇县'),(511325,'西充县'),(511381,'阆中市'),(511400,'眉山市'),(511402,'东坡区'),(511403,'彭山区'),(511421,'仁寿县'),(511423,'洪雅县'),(511424,'丹棱县'),(511425,'青神县'),(511500,'宜宾市'),(511502,'翠屏区'),(511503,'南溪区'),(511504,'叙州区'),(511523,'江安县'),(511524,'长宁县'),(511525,'高县'),(511526,'珙县'),(511527,'筠连县'),(511528,'兴文县'),(511529,'屏山县'),(511600,'广安市'),(511602,'广安区'),(511603,'前锋区'),(511621,'岳池县'),(511622,'武胜县'),(511623,'邻水县'),(511681,'华蓥市'),(511700,'达州市'),(511702,'通川区'),(511703,'达川区'),(511722,'宣汉县'),(511723,'开江县'),(511724,'大竹县'),(511725,'渠县'),(511781,'万源市'),(511800,'雅安市'),(511802,'雨城区'),(511803,'名山区'),(511822,'荥经县'),(511823,'汉源县'),(511824,'石棉县'),(511825,'天全县'),(511826,'芦山县'),(511827,'宝兴县'),(511900,'巴中市'),(511902,'巴州区'),(511903,'恩阳区'),(511921,'通江县'),(511922,'南江县'),(511923,'平昌县'),(512000,'资阳市'),(512002,'雁江区'),(512021,'安岳县'),(512022,'乐至县'),(513200,'阿坝藏族羌族自治州'),(513201,'马尔康市'),(513221,'汶川县'),(513222,'理县'),(513223,'茂县'),(513224,'松潘县'),(513225,'九寨沟县'),(513226,'金川县'),(513227,'小金县'),(513228,'黑水县'),(513230,'壤塘县'),(513231,'阿坝县'),(513232,'若尔盖县'),(513233,'红原县'),(513300,'甘孜藏族自治州'),(513301,'康定市'),(513322,'泸定县'),(513323,'丹巴县'),(513324,'九龙县'),(513325,'雅江县'),(513326,'道孚县'),(513327,'炉霍县'),(513328,'甘孜县'),(513329,'新龙县'),(513330,'德格县'),(513331,'白玉县'),(513332,'石渠县'),(513333,'色达县'),(513334,'理塘县'),(513335,'巴塘县'),(513336,'乡城县'),(513337,'稻城县'),(513338,'得荣县'),(513400,'凉山彝族自治州'),(513401,'西昌市'),(513422,'木里藏族自治县'),(513423,'盐源县'),(513424,'德昌县'),(513425,'会理县'),(513426,'会东县'),(513427,'宁南县'),(513428,'普格县'),(513429,'布拖县'),(513430,'金阳县'),(513431,'昭觉县'),(513432,'喜德县'),(513433,'冕宁县'),(513434,'越西县'),(513435,'甘洛县'),(513436,'美姑县'),(513437,'雷波县'),(520000,'贵州'),(520100,'贵阳市'),(520102,'南明区'),(520103,'云岩区'),(520111,'花溪区'),(520112,'乌当区'),(520113,'白云区'),(520115,'观山湖区'),(520121,'开阳县'),(520122,'息烽县'),(520123,'修文县'),(520181,'清镇市'),(520200,'六盘水市'),(520201,'钟山区'),(520203,'六枝特区'),(520221,'水城县'),(520281,'盘州市'),(520300,'遵义市'),(520302,'红花岗区'),(520303,'汇川区'),(520304,'播州区'),(520322,'桐梓县'),(520323,'绥阳县'),(520324,'正安县'),(520325,'道真仡佬族苗族自治县'),(520326,'务川仡佬族苗族自治县'),(520327,'凤冈县'),(520328,'湄潭县'),(520329,'余庆县'),(520330,'习水县'),(520381,'赤水市'),(520382,'仁怀市'),(520400,'安顺市'),(520402,'西秀区'),(520403,'平坝区'),(520422,'普定县'),(520423,'镇宁布依族苗族自治县'),(520424,'关岭布依族苗族自治县'),(520425,'紫云苗族布依族自治县'),(520500,'毕节市'),(520502,'七星关区'),(520521,'大方县'),(520522,'黔西县'),(520523,'金沙县'),(520524,'织金县'),(520525,'纳雍县'),(520526,'威宁彝族回族苗族自治县'),(520527,'赫章县'),(520600,'铜仁市'),(520602,'碧江区'),(520603,'万山区'),(520621,'江口县'),(520622,'玉屏侗族自治县'),(520623,'石阡县'),(520624,'思南县'),(520625,'印江土家族苗族自治县'),(520626,'德江县'),(520627,'沿河土家族自治县'),(520628,'松桃苗族自治县'),(522300,'黔西南布依族苗族自治州'),(522301,'兴义市'),(522302,'兴仁市'),(522323,'普安县'),(522324,'晴隆县'),(522325,'贞丰县'),(522326,'望谟县'),(522327,'册亨县'),(522328,'安龙县'),(522600,'黔东南苗族侗族自治州'),(522601,'凯里市'),(522622,'黄平县'),(522623,'施秉县'),(522624,'三穗县'),(522625,'镇远县'),(522626,'岑巩县'),(522627,'天柱县'),(522628,'锦屏县'),(522629,'剑河县'),(522630,'台江县'),(522631,'黎平县'),(522632,'榕江县'),(522633,'从江县'),(522634,'雷山县'),(522635,'麻江县'),(522636,'丹寨县'),(522700,'黔南布依族苗族自治州'),(522701,'都匀市'),(522702,'福泉市'),(522722,'荔波县'),(522723,'贵定县'),(522725,'瓮安县'),(522726,'独山县'),(522727,'平塘县'),(522728,'罗甸县'),(522729,'长顺县'),(522730,'龙里县'),(522731,'惠水县'),(522732,'三都水族自治县'),(530000,'云南'),(530100,'昆明市'),(530102,'五华区'),(530103,'盘龙区'),(530111,'官渡区'),(530112,'西山区'),(530113,'东川区'),(530114,'呈贡区'),(530115,'晋宁区'),(530124,'富民县'),(530125,'宜良县'),(530126,'石林彝族自治县'),(530127,'嵩明县'),(530128,'禄劝彝族苗族自治县'),(530129,'寻甸回族彝族自治县'),(530181,'安宁市'),(530300,'曲靖市'),(530302,'麒麟区'),(530303,'沾益区'),(530304,'马龙区'),(530322,'陆良县'),(530323,'师宗县'),(530324,'罗平县'),(530325,'富源县'),(530326,'会泽县'),(530381,'宣威市'),(530400,'玉溪市'),(530402,'红塔区'),(530403,'江川区'),(530422,'澄江县'),(530423,'通海县'),(530424,'华宁县'),(530425,'易门县'),(530426,'峨山彝族自治县'),(530427,'新平彝族傣族自治县'),(530428,'元江哈尼族彝族傣族自治县'),(530500,'保山市'),(530502,'隆阳区'),(530521,'施甸县'),(530523,'龙陵县'),(530524,'昌宁县'),(530581,'腾冲市'),(530600,'昭通市'),(530602,'昭阳区'),(530621,'鲁甸县'),(530622,'巧家县'),(530623,'盐津县'),(530624,'大关县'),(530625,'永善县'),(530626,'绥江县'),(530627,'镇雄县'),(530628,'彝良县'),(530629,'威信县'),(530681,'水富市'),(530700,'丽江市'),(530702,'古城区'),(530721,'玉龙纳西族自治县'),(530722,'永胜县'),(530723,'华坪县'),(530724,'宁蒗彝族自治县'),(530800,'普洱市'),(530802,'思茅区'),(530821,'宁洱哈尼族彝族自治县'),(530822,'墨江哈尼族自治县'),(530823,'景东彝族自治县'),(530824,'景谷傣族彝族自治县'),(530825,'镇沅彝族哈尼族拉祜族自治县'),(530826,'江城哈尼族彝族自治县'),(530827,'孟连傣族拉祜族佤族自治县'),(530828,'澜沧拉祜族自治县'),(530829,'西盟佤族自治县'),(530900,'临沧市'),(530902,'临翔区'),(530921,'凤庆县'),(530922,'云县'),(530923,'永德县'),(530924,'镇康县'),(530925,'双江拉祜族佤族布朗族傣族自治县'),(530926,'耿马傣族佤族自治县'),(530927,'沧源佤族自治县'),(532300,'楚雄彝族自治州'),(532301,'楚雄市'),(532322,'双柏县'),(532323,'牟定县'),(532324,'南华县'),(532325,'姚安县'),(532326,'大姚县'),(532327,'永仁县'),(532328,'元谋县'),(532329,'武定县'),(532331,'禄丰县'),(532500,'红河哈尼族彝族自治州'),(532501,'个旧市'),(532502,'开远市'),(532503,'蒙自市'),(532504,'弥勒市'),(532523,'屏边苗族自治县'),(532524,'建水县'),(532525,'石屏县'),(532527,'泸西县'),(532528,'元阳县'),(532529,'红河县'),(532530,'金平苗族瑶族傣族自治县'),(532531,'绿春县'),(532532,'河口瑶族自治县'),(532600,'文山壮族苗族自治州'),(532601,'文山市'),(532622,'砚山县'),(532623,'西畴县'),(532624,'麻栗坡县'),(532625,'马关县'),(532626,'丘北县'),(532627,'广南县'),(532628,'富宁县'),(532800,'西双版纳傣族自治州'),(532801,'景洪市'),(532822,'勐海县'),(532823,'勐腊县'),(532900,'大理白族自治州'),(532901,'大理市'),(532922,'漾濞彝族自治县'),(532923,'祥云县'),(532924,'宾川县'),(532925,'弥渡县'),(532926,'南涧彝族自治县'),(532927,'巍山彝族回族自治县'),(532928,'永平县'),(532929,'云龙县'),(532930,'洱源县'),(532931,'剑川县'),(532932,'鹤庆县'),(533100,'德宏傣族景颇族自治州'),(533102,'瑞丽市'),(533103,'芒市'),(533122,'梁河县'),(533123,'盈江县'),(533124,'陇川县'),(533300,'怒江傈僳族自治州'),(533301,'泸水市'),(533323,'福贡县'),(533324,'贡山独龙族怒族自治县'),(533325,'兰坪白族普米族自治县'),(533400,'迪庆藏族自治州'),(533401,'香格里拉市'),(533422,'德钦县'),(533423,'维西傈僳族自治县'),(540000,'西藏'),(540100,'拉萨市'),(540102,'城关区'),(540103,'堆龙德庆区'),(540104,'达孜区'),(540121,'林周县'),(540122,'当雄县'),(540123,'尼木县'),(540124,'曲水县'),(540127,'墨竹工卡县'),(540200,'日喀则市'),(540202,'桑珠孜区'),(540221,'南木林县'),(540222,'江孜县'),(540223,'定日县'),(540224,'萨迦县'),(540225,'拉孜县'),(540226,'昂仁县'),(540227,'谢通门县'),(540228,'白朗县'),(540229,'仁布县'),(540230,'康马县'),(540231,'定结县'),(540232,'仲巴县'),(540233,'亚东县'),(540234,'吉隆县'),(540235,'聂拉木县'),(540236,'萨嘎县'),(540237,'岗巴县'),(540300,'昌都市'),(540302,'卡若区'),(540321,'江达县'),(540322,'贡觉县'),(540323,'类乌齐县'),(540324,'丁青县'),(540325,'察雅县'),(540326,'八宿县'),(540327,'左贡县'),(540328,'芒康县'),(540329,'洛隆县'),(540330,'边坝县'),(540400,'林芝市'),(540402,'巴宜区'),(540421,'工布江达县'),(540422,'米林县'),(540423,'墨脱县'),(540424,'波密县'),(540425,'察隅县'),(540426,'朗县'),(540500,'山南市'),(540502,'乃东区'),(540521,'扎囊县'),(540522,'贡嘎县'),(540523,'桑日县'),(540524,'琼结县'),(540525,'曲松县'),(540526,'措美县'),(540527,'洛扎县'),(540528,'加查县'),(540529,'隆子县'),(540530,'错那县'),(540531,'浪卡子县'),(540600,'那曲市'),(540602,'色尼区'),(540621,'嘉黎县'),(540622,'比如县'),(540623,'聂荣县'),(540624,'安多县'),(540625,'申扎县'),(540626,'索县'),(540627,'班戈县'),(540628,'巴青县'),(540629,'尼玛县'),(540630,'双湖县'),(542500,'阿里地区'),(542521,'普兰县'),(542522,'札达县'),(542523,'噶尔县'),(542524,'日土县'),(542525,'革吉县'),(542526,'改则县'),(542527,'措勤县'),(610000,'陕西'),(610100,'西安市'),(610102,'新城区'),(610103,'碑林区'),(610104,'莲湖区'),(610111,'灞桥区'),(610112,'未央区'),(610113,'雁塔区'),(610114,'阎良区'),(610115,'临潼区'),(610116,'长安区'),(610117,'高陵区'),(610118,'鄠邑区'),(610122,'蓝田县'),(610124,'周至县'),(610200,'铜川市'),(610202,'王益区'),(610203,'印台区'),(610204,'耀州区'),(610222,'宜君县'),(610300,'宝鸡市'),(610302,'渭滨区'),(610303,'金台区'),(610304,'陈仓区'),(610322,'凤翔县'),(610323,'岐山县'),(610324,'扶风县'),(610326,'眉县'),(610327,'陇县'),(610328,'千阳县'),(610329,'麟游县'),(610330,'凤县'),(610331,'太白县'),(610400,'咸阳市'),(610402,'秦都区'),(610403,'杨陵区'),(610404,'渭城区'),(610422,'三原县'),(610423,'泾阳县'),(610424,'乾县'),(610425,'礼泉县'),(610426,'永寿县'),(610428,'长武县'),(610429,'旬邑县'),(610430,'淳化县'),(610431,'武功县'),(610481,'兴平市'),(610482,'彬州市'),(610500,'渭南市'),(610502,'临渭区'),(610503,'华州区'),(610522,'潼关县'),(610523,'大荔县'),(610524,'合阳县'),(610525,'澄城县'),(610526,'蒲城县'),(610527,'白水县'),(610528,'富平县'),(610581,'韩城市'),(610582,'华阴市'),(610600,'延安市'),(610602,'宝塔区'),(610603,'安塞区'),(610621,'延长县'),(610622,'延川县'),(610623,'子长县'),(610625,'志丹县'),(610626,'吴起县'),(610627,'甘泉县'),(610628,'富县'),(610629,'洛川县'),(610630,'宜川县'),(610631,'黄龙县'),(610632,'黄陵县'),(610700,'汉中市'),(610702,'汉台区'),(610703,'南郑区'),(610722,'城固县'),(610723,'洋县'),(610724,'西乡县'),(610725,'勉县'),(610726,'宁强县'),(610727,'略阳县'),(610728,'镇巴县'),(610729,'留坝县'),(610730,'佛坪县'),(610800,'榆林市'),(610802,'榆阳区'),(610803,'横山区'),(610822,'府谷县'),(610824,'靖边县'),(610825,'定边县'),(610826,'绥德县'),(610827,'米脂县'),(610828,'佳县'),(610829,'吴堡县'),(610830,'清涧县'),(610831,'子洲县'),(610881,'神木市'),(610900,'安康市'),(610902,'汉滨区'),(610921,'汉阴县'),(610922,'石泉县'),(610923,'宁陕县'),(610924,'紫阳县'),(610925,'岚皋县'),(610926,'平利县'),(610927,'镇坪县'),(610928,'旬阳县'),(610929,'白河县'),(611000,'商洛市'),(611002,'商州区'),(611021,'洛南县'),(611022,'丹凤县'),(611023,'商南县'),(611024,'山阳县'),(611025,'镇安县'),(611026,'柞水县'),(620000,'甘肃'),(620100,'兰州市'),(620102,'城关区'),(620103,'七里河区'),(620104,'西固区'),(620105,'安宁区'),(620111,'红古区'),(620121,'永登县'),(620122,'皋兰县'),(620123,'榆中县'),(620200,'嘉峪关市'),(620300,'金昌市'),(620302,'金川区'),(620321,'永昌县'),(620400,'白银市'),(620402,'白银区'),(620403,'平川区'),(620421,'靖远县'),(620422,'会宁县'),(620423,'景泰县'),(620500,'天水市'),(620502,'秦州区'),(620503,'麦积区'),(620521,'清水县'),(620522,'秦安县'),(620523,'甘谷县'),(620524,'武山县'),(620525,'张家川回族自治县'),(620600,'武威市'),(620602,'凉州区'),(620621,'民勤县'),(620622,'古浪县'),(620623,'天祝藏族自治县'),(620700,'张掖市'),(620702,'甘州区'),(620721,'肃南裕固族自治县'),(620722,'民乐县'),(620723,'临泽县'),(620724,'高台县'),(620725,'山丹县'),(620800,'平凉市'),(620802,'崆峒区'),(620821,'泾川县'),(620822,'灵台县'),(620823,'崇信县'),(620825,'庄浪县'),(620826,'静宁县'),(620881,'华亭市'),(620900,'酒泉市'),(620902,'肃州区'),(620921,'金塔县'),(620922,'瓜州县'),(620923,'肃北蒙古族自治县'),(620924,'阿克塞哈萨克族自治县'),(620981,'玉门市'),(620982,'敦煌市'),(621000,'庆阳市'),(621002,'西峰区'),(621021,'庆城县'),(621022,'环县'),(621023,'华池县'),(621024,'合水县'),(621025,'正宁县'),(621026,'宁县'),(621027,'镇原县'),(621100,'定西市'),(621102,'安定区'),(621121,'通渭县'),(621122,'陇西县'),(621123,'渭源县'),(621124,'临洮县'),(621125,'漳县'),(621126,'岷县'),(621200,'陇南市'),(621202,'武都区'),(621221,'成县'),(621222,'文县'),(621223,'宕昌县'),(621224,'康县'),(621225,'西和县'),(621226,'礼县'),(621227,'徽县'),(621228,'两当县'),(622900,'临夏回族自治州'),(622901,'临夏市'),(622921,'临夏县'),(622922,'康乐县'),(622923,'永靖县'),(622924,'广河县'),(622925,'和政县'),(622926,'东乡族自治县'),(622927,'积石山保安族东乡族撒拉族自治县'),(623000,'甘南藏族自治州'),(623001,'合作市'),(623021,'临潭县'),(623022,'卓尼县'),(623023,'舟曲县'),(623024,'迭部县'),(623025,'玛曲县'),(623026,'碌曲县'),(623027,'夏河县'),(630000,'青海'),(630100,'西宁市'),(630102,'城东区'),(630103,'城中区'),(630104,'城西区'),(630105,'城北区'),(630121,'大通回族土族自治县'),(630122,'湟中县'),(630123,'湟源县'),(630200,'海东市'),(630202,'乐都区'),(630203,'平安区'),(630222,'民和回族土族自治县'),(630223,'互助土族自治县'),(630224,'化隆回族自治县'),(630225,'循化撒拉族自治县'),(632200,'海北藏族自治州'),(632221,'门源回族自治县'),(632222,'祁连县'),(632223,'海晏县'),(632224,'刚察县'),(632300,'黄南藏族自治州'),(632321,'同仁县'),(632322,'尖扎县'),(632323,'泽库县'),(632324,'河南蒙古族自治县'),(632500,'海南藏族自治州'),(632521,'共和县'),(632522,'同德县'),(632523,'贵德县'),(632524,'兴海县'),(632525,'贵南县'),(632600,'果洛藏族自治州'),(632621,'玛沁县'),(632622,'班玛县'),(632623,'甘德县'),(632624,'达日县'),(632625,'久治县'),(632626,'玛多县'),(632700,'玉树藏族自治州'),(632701,'玉树市'),(632722,'杂多县'),(632723,'称多县'),(632724,'治多县'),(632725,'囊谦县'),(632726,'曲麻莱县'),(632800,'海西蒙古族藏族自治州'),(632801,'格尔木市'),(632802,'德令哈市'),(632803,'茫崖市'),(632821,'乌兰县'),(632822,'都兰县'),(632823,'天峻县'),(640000,'宁夏'),(640100,'银川市'),(640104,'兴庆区'),(640105,'西夏区'),(640106,'金凤区'),(640121,'永宁县'),(640122,'贺兰县'),(640181,'灵武市'),(640200,'石嘴山市'),(640202,'大武口区'),(640205,'惠农区'),(640221,'平罗县'),(640300,'吴忠市'),(640302,'利通区'),(640303,'红寺堡区'),(640323,'盐池县'),(640324,'同心县'),(640381,'青铜峡市'),(640400,'固原市'),(640402,'原州区'),(640422,'西吉县'),(640423,'隆德县'),(640424,'泾源县'),(640425,'彭阳县'),(640500,'中卫市'),(640502,'沙坡头区'),(640521,'中宁县'),(640522,'海原县'),(650000,'新疆'),(650100,'乌鲁木齐市'),(650102,'天山区'),(650103,'沙依巴克区'),(650104,'新市区'),(650105,'水磨沟区'),(650106,'头屯河区'),(650107,'达坂城区'),(650109,'米东区'),(650121,'乌鲁木齐县'),(650200,'克拉玛依市'),(650202,'独山子区'),(650203,'克拉玛依区'),(650204,'白碱滩区'),(650205,'乌尔禾区'),(650400,'吐鲁番市'),(650402,'高昌区'),(650421,'鄯善县'),(650422,'托克逊县'),(650500,'哈密市'),(650502,'伊州区'),(650521,'巴里坤哈萨克自治县'),(650522,'伊吾县'),(652300,'昌吉回族自治州'),(652301,'昌吉市'),(652302,'阜康市'),(652323,'呼图壁县'),(652324,'玛纳斯县'),(652325,'奇台县'),(652327,'吉木萨尔县'),(652328,'木垒哈萨克自治县'),(652700,'博尔塔拉蒙古自治州'),(652701,'博乐市'),(652702,'阿拉山口市'),(652722,'精河县'),(652723,'温泉县'),(652800,'巴音郭楞蒙古自治州'),(652801,'库尔勒市'),(652822,'轮台县'),(652823,'尉犁县'),(652824,'若羌县'),(652825,'且末县'),(652826,'焉耆回族自治县'),(652827,'和静县'),(652828,'和硕县'),(652829,'博湖县'),(652900,'阿克苏地区'),(652901,'阿克苏市'),(652922,'温宿县'),(652923,'库车县'),(652924,'沙雅县'),(652925,'新和县'),(652926,'拜城县'),(652927,'乌什县'),(652928,'阿瓦提县'),(652929,'柯坪县'),(653000,'克孜勒苏柯尔克孜自治州'),(653001,'阿图什市'),(653022,'阿克陶县'),(653023,'阿合奇县'),(653024,'乌恰县'),(653100,'喀什地区'),(653101,'喀什市'),(653121,'疏附县'),(653122,'疏勒县'),(653123,'英吉沙县'),(653124,'泽普县'),(653125,'莎车县'),(653126,'叶城县'),(653127,'麦盖提县'),(653128,'岳普湖县'),(653129,'伽师县'),(653130,'巴楚县'),(653131,'塔什库尔干塔吉克自治县'),(653200,'和田地区'),(653201,'和田市'),(653221,'和田县'),(653222,'墨玉县'),(653223,'皮山县'),(653224,'洛浦县'),(653225,'策勒县'),(653226,'于田县'),(653227,'民丰县'),(654000,'伊犁哈萨克自治州'),(654002,'伊宁市'),(654003,'奎屯市'),(654004,'霍尔果斯市'),(654021,'伊宁县'),(654022,'察布查尔锡伯自治县'),(654023,'霍城县'),(654024,'巩留县'),(654025,'新源县'),(654026,'昭苏县'),(654027,'特克斯县'),(654028,'尼勒克县'),(654200,'塔城地区'),(654201,'塔城市'),(654202,'乌苏市'),(654221,'额敏县'),(654223,'沙湾县'),(654224,'托里县'),(654225,'裕民县'),(654226,'和布克赛尔蒙古自治县'),(654300,'阿勒泰地区'),(654301,'阿勒泰市'),(654321,'布尔津县'),(654322,'富蕴县'),(654323,'福海县'),(654324,'哈巴河县'),(654325,'青河县'),(654326,'吉木乃县'),(659000,'石河子市'),(659001,'石河子市'),(659100,'阿拉尔市'),(659101,'阿拉尔市'),(659200,'图木舒克市'),(659201,'图木舒克市'),(659300,'五家渠市'),(659301,'五家渠市'),(659400,'北屯市'),(659401,'北屯市'),(659500,'铁门关市'),(659501,'铁门关市'),(659600,'双河市'),(659601,'双河市'),(659700,'可克达拉市'),(659701,'可克达拉市'),(659800,'昆玉市'),(659801,'昆玉市'),(710000,'台湾'),(810000,'香港'),(820000,'澳门');
/*!40000 ALTER TABLE `region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spec`
--

DROP TABLE IF EXISTS `spec`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spec` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'specification name',
  `sort` bigint(20) NOT NULL DEFAULT 50,
  `note` varchar(255) NOT NULL,
  `list` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='goods specificatoins';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spec`
--

LOCK TABLES `spec` WRITE;
/*!40000 ALTER TABLE `spec` DISABLE KEYS */;
INSERT INTO `spec` VALUES (5,'颜色',50,'有图测试','[{\"val\":\"黑色\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/b0/id/er34frcfao6nk8gt3n6wf67whbyx35skiwtayjur7nibfbua.jpg?x-oss-process=image/resize,w_40,h_40\"},{\"val\":\"白色\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/6r/i5/8auglqevlz14mqoe5mf01buhdh530s3swx9ue9n9uu5nn2d5i.jpg?x-oss-process=image/resize,w_40,h_40\"},{\"val\":\"红色\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/2v/fj/ryojefdfcnrrvn9m0ji6ely5v4w4zofy0bbcwyr3gg0y9q9t76.jpg?x-oss-process=image/resize,w_40,h_40\"},{\"val\":\"黄色\",\"hint\":\"\",\"img\":\"\"}]'),(7,'颜色',50,'iphone','[{\"val\":\"黑色\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/1y/6u/grc2krd3h3xwcevd9wpyrihabukvmnymauohhb6ula8q872c9g.png?x-oss-process=image/resize,w_40,h_40?x-oss-process=image/resize,w_40,h_40\"},{\"val\":\"白色\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/2u/1s/p6ji15fmgoyfp964kql8gys2z3hhix153cad1bs5azrhoyl8h1.png?x-oss-process=image/resize,w_40,h_40?x-oss-process=image/resize,w_40,h_40\"},{\"val\":\"红色\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/14/tc/rittidoeup4hdd03yzg6ywe77gb2uq8tpaubftwx6n8lwsq2xh.png?x-oss-process=image/resize,w_40,h_40?x-oss-process=image/resize,w_40,h_40\"},{\"val\":\"黄色\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/14/01/0hcd1nbbs0qdqkkjei2w76f3qkw22ch623wjcw11fthmw4moxl.png?x-oss-process=image/resize,w_40,h_40?x-oss-process=image/resize,w_40,h_40\"},{\"val\":\"紫色\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/1y/13/h9fxsd1qaci06zamsqczspllhpd95llktp5fan7vocywn4seud.png?x-oss-process=image/resize,w_40,h_40?x-oss-process=image/resize,w_40,h_40\"},{\"val\":\"绿色\",\"hint\":\"\",\"img\":\"https://0-00.oss-cn-beijing.aliyuncs.com/t1/vi/l0h6nu8xplkbmzqckdi1xfdo7r561g7jb3ycq4d9rgwqoo2if.png?x-oss-process=image/resize,w_40,h_40?x-oss-process=image/resize,w_40,h_40\"}]'),(9,'容量',50,'手机容量','[{\"val\":\"32G\",\"hint\":\"\",\"img\":\"\"},{\"val\":\"64G\",\"hint\":\"\",\"img\":\"\"},{\"val\":\"128G\",\"hint\":\"\",\"img\":\"\"},{\"val\":\"256G\",\"hint\":\"\",\"img\":\"\"},{\"val\":\"512G\",\"hint\":\"\",\"img\":\"\"}]');
/*!40000 ALTER TABLE `spec` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system`
--

DROP TABLE IF EXISTS `system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `entity` varchar(255) NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `value` text NOT NULL DEFAULT '',
  `desc` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `system_pk` (`entity`,`attribute`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COMMENT='system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system`
--

LOCK TABLES `system` WRITE;
/*!40000 ALTER TABLE `system` DISABLE KEYS */;
INSERT INTO `system` VALUES (1,'sys','keywords','iphone 11,test','搜索关键字'),(2,'sys','name','alex商城','网站名称'),(3,'sys','url','http://127.0.0.1:8080','网址'),(4,'sys','maxBuyNum','90','商品限购'),(5,'sys','beian','鲁a-333','备案号'),(6,'theme','pc','default','电脑端模板'),(7,'theme','mobile','mobile','移动端模板'),(8,'storage','type','oss','存储类型,oss or local'),(9,'storage','ossAk','GNhHRfe5kTelOTD6LabI68mgsnacHeuWcDJkKBYUUkKxynydnWp+ysMcS6NFm63tu+i17w==','Access Key ID,加密数据'),(10,'storage','ossAks','zalNDudbUAynVsiW7msM4aU3UFf7/1laucF5QlSZkAwwIsHr/gbOFGjfw7GGo3sBtNJIex5q4SRs0A==','Access Key Secret,加密数据'),(11,'storage','ossBucket','0-00',''),(12,'storage','ossBucketUrl','https://0-00.oss-cn-beijing.aliyuncs.com',''),(13,'storage','ossEndpoint','https://oss-cn-beijing.aliyuncs.com',''),(14,'sys','jsVersion','6','静态文件版本号'),(15,'sys','jsPath','','静态文件路径'),(17,'shipping','freeRule','{\"enable\":true,\"price\":9900,\"exclude\":[540000]}','包邮规则'),(18,'shipping','priceRule','{\"firstWeight\":1000,\"firstPrice\":2400,\"additionalWeight\":1000,\"additionalPrice\":600,\"provincePrices\":[{\"provinces\":[370000,110000,430000],\"firstPrice\":1600,\"additionalPrice\":200}],\"otherDefault\":true}','邮费规则');
/*!40000 ALTER TABLE `system` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userAddress`
--

DROP TABLE IF EXISTS `userAddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userAddress` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `region` bigint(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `dft` bigint(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `userAddress_userId_index` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userAddress`
--

LOCK TABLES `userAddress` WRITE;
/*!40000 ALTER TABLE `userAddress` DISABLE KEYS */;
INSERT INTO `userAddress` VALUES (6,2,'abc','11111111111',130303,'1112121212',0),(21,1,'abc','11231112222',130102,'23232323',0),(22,1,'ccc','12311111111',140303,'sdfdfdfdf',0),(23,1,'abc','11111111111',150121,'231312321313',0),(24,1,'dcc','11111111111',110105,'23123213123123',0),(25,1,'1111212','12341111111',120102,'dfd33333',0),(26,1,'hhh','11111111111',120110,'21212121212',1),(27,1,'1222','12311111111',310115,'23232323232323',0);
/*!40000 ALTER TABLE `userAddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userLogs`
--

DROP TABLE IF EXISTS `userLogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userLogs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0 COMMENT '1: login success\n2: login faild\n3: reset password\n4: edit password\n5: account bind info\n6: update info\n7: move order to trash\n8: delete order',
  `msg` varchar(255) NOT NULL DEFAULT '',
  `ip` varchar(128) NOT NULL,
  `time` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `userLogs_uid_type_index` (`uid`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COMMENT='用户日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userLogs`
--

LOCK TABLES `userLogs` WRITE;
/*!40000 ALTER TABLE `userLogs` DISABLE KEYS */;
INSERT INTO `userLogs` VALUES (1,1,1,'','0:0:0:0:0:0:0:1','2020-09-04 16:06:39'),(2,1,1,'','0:0:0:0:0:0:0:1','2020-09-05 00:43:59'),(3,1,1,'','0:0:0:0:0:0:0:1','2020-09-17 08:10:07'),(6,1,1,'','0:0:0:0:0:0:0:1','2020-09-18 09:29:55'),(7,1,1,'','0:0:0:0:0:0:0:1','2020-09-25 09:43:05'),(8,1,1,'','0:0:0:0:0:0:0:1','2020-09-25 16:47:06'),(9,1,1,'','0:0:0:0:0:0:0:1','2020-09-27 03:53:38'),(10,1,1,'','0:0:0:0:0:0:0:1','2020-09-27 22:41:26'),(11,1,1,'','0:0:0:0:0:0:0:1','2020-09-28 14:48:51'),(12,1,1,'','0:0:0:0:0:0:0:1','2020-09-29 16:22:33'),(13,1,1,'','0:0:0:0:0:0:0:1','2020-09-30 14:56:41'),(14,1,1,'','0:0:0:0:0:0:0:1','2020-10-04 12:22:34'),(15,1,1,'','0:0:0:0:0:0:0:1','2020-10-05 02:36:55'),(17,1,1,'','0:0:0:0:0:0:0:1','2020-10-06 12:48:59'),(18,1,1,'','0:0:0:0:0:0:0:1','2020-10-08 02:07:23'),(19,1,1,'','0:0:0:0:0:0:0:1','2020-10-09 01:03:21'),(20,1,1,'','0:0:0:0:0:0:0:1','2020-10-10 00:23:09'),(21,1,1,'','0:0:0:0:0:0:0:1','2020-10-12 08:52:38'),(22,2,1,'','0:0:0:0:0:0:0:1','2020-10-12 09:19:27'),(23,1,1,'','0:0:0:0:0:0:0:1','2020-10-12 09:20:06'),(24,2,1,'','0:0:0:0:0:0:0:1','2020-10-12 09:22:06'),(25,1,1,'','0:0:0:0:0:0:0:1','2020-10-12 09:24:03'),(26,2,1,'','0:0:0:0:0:0:0:1','2020-10-12 09:24:25'),(27,1,1,'','127.0.0.1','2020-10-12 09:26:55'),(28,1,1,'','0:0:0:0:0:0:0:1','2020-10-12 15:24:40'),(29,1,1,'','0:0:0:0:0:0:0:1','2020-10-13 07:51:31'),(30,1,1,'','0:0:0:0:0:0:0:1','2020-10-14 10:03:48'),(31,1,1,'','0:0:0:0:0:0:0:1','2020-10-15 09:52:05'),(32,1,1,'','0:0:0:0:0:0:0:1','2020-10-16 14:36:22'),(33,1,1,'','0:0:0:0:0:0:0:1','2020-10-19 16:27:11'),(34,1,1,'','127.0.0.1','2020-10-20 00:12:32'),(35,1,1,'','127.0.0.1','2020-10-22 08:46:02'),(36,1,1,'','127.0.0.1','2020-10-22 08:47:24'),(37,1,1,'','127.0.0.1','2020-10-22 08:50:58'),(38,1,1,'','127.0.0.1','2020-10-22 08:51:28'),(39,1,1,'','127.0.0.1','2020-10-22 13:38:12'),(40,1,1,'','127.0.0.1','2020-10-22 15:55:41'),(41,1,1,'','127.0.0.1','2020-10-23 07:50:07'),(42,1,1,'','127.0.0.1','2020-10-23 08:45:41'),(43,1,1,'','127.0.0.1','2020-10-24 14:30:03'),(44,1,1,'','127.0.0.1','2020-10-26 09:07:35'),(45,1,1,'','127.0.0.1','2020-11-01 00:26:35'),(46,1,1,'','127.0.0.1','2020-11-01 19:30:10'),(48,1,1,'','127.0.0.1','2020-11-01 22:25:20'),(49,1,1,'','127.0.0.1','2020-11-02 13:11:23'),(50,1,1,'','127.0.0.1','2020-11-02 14:48:40'),(51,1,1,'','127.0.0.1','2020-11-04 00:48:00'),(52,1,1,'','127.0.0.1','2020-11-04 01:33:47'),(53,1,1,'','127.0.0.1','2020-11-04 14:29:34'),(54,1,1,'','0:0:0:0:0:0:0:1','2020-11-05 19:26:23'),(55,1,1,'','127.0.0.1','2020-11-05 22:37:20'),(56,1,1,'','127.0.0.1','2020-11-06 01:29:31'),(57,1,1,'','127.0.0.1','2020-11-06 03:05:59'),(58,1,1,'','127.0.0.1','2020-11-06 14:58:23'),(59,1,1,'','192.168.10.1','2020-11-06 16:45:41'),(60,1,1,'','127.0.0.1','2020-11-10 16:01:40'),(61,1,1,'','127.0.0.1','2020-11-11 13:56:38'),(62,1,1,'','127.0.0.1','2020-11-12 08:48:07'),(63,1,1,'','127.0.0.1','2020-11-13 10:26:01'),(64,1,1,'','127.0.0.1','2020-11-13 13:48:09'),(68,1,1,'','127.0.0.1','2020-11-13 14:35:47'),(69,1,1,'','127.0.0.1','2020-11-15 19:33:19'),(70,1,1,'','127.0.0.1','2020-11-17 08:32:35'),(71,1,1,'','127.0.0.1','2020-11-17 15:41:44'),(72,1,1,'','127.0.0.1','2020-11-17 16:39:35'),(73,1,1,'','127.0.0.1','2020-11-17 18:44:14'),(74,1,1,'','35.201.181.23','2020-11-17 21:30:17'),(75,1,1,'','127.0.0.1','2020-11-17 22:05:24'),(76,1,1,'','127.0.0.1','2020-11-18 02:24:34'),(77,1,1,'','127.0.0.1','2020-11-18 12:10:08'),(78,1,1,'','127.0.0.1','2020-11-18 22:09:05'),(80,1,1,'','127.0.0.1','2020-11-19 12:45:23'),(81,1,1,'','127.0.0.1','2020-11-19 13:30:21'),(82,1,1,'','127.0.0.1','2020-11-21 10:49:16'),(83,1,1,'','127.0.0.1','2020-11-22 15:23:56'),(84,1,1,'','127.0.0.1','2020-11-25 01:56:45'),(85,1,1,'','127.0.0.1','2020-11-25 20:53:00'),(86,1,1,'','127.0.0.1','2020-11-26 23:10:10'),(87,1,1,'','127.0.0.1','2020-11-26 23:45:31'),(88,1,1,'','127.0.0.1','2020-11-27 22:54:54'),(89,1,1,'','127.0.0.1','2020-11-29 01:41:54'),(90,1,1,'','127.0.0.1','2020-11-29 23:50:15'),(91,1,1,'','127.0.0.1','2020-12-01 16:20:08'),(92,1,1,'','127.0.0.1','2020-12-02 16:36:32'),(96,1,1,'','127.0.0.1','2020-12-03 16:33:57'),(97,1,1,'','127.0.0.1','2020-12-04 14:26:23'),(98,1,1,'','127.0.0.1','2020-12-06 01:00:14'),(99,1,1,'','127.0.0.1','2020-12-06 19:47:59'),(100,1,1,'','127.0.0.1','2020-12-08 17:23:39'),(101,1,1,'','127.0.0.1','2020-12-11 22:45:35');
/*!40000 ALTER TABLE `userLogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `name` varchar(255) NOT NULL COMMENT '用户名',
  `level` int(11) NOT NULL DEFAULT 0 COMMENT '级别',
  `phone` varchar(255) NOT NULL DEFAULT '' COMMENT '手机号码',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `sex` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT '性别 0:未知 1:男 2:女',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT '电子邮件',
  `surplus` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '余额,单位(分)',
  `lastLoginTime` datetime DEFAULT NULL COMMENT '最近登陆时间',
  `lastLoginIp` varchar(32) DEFAULT NULL COMMENT '最近登陆IP',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态:1:正常 0:停用 -1:软删除',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `salt` char(4) NOT NULL COMMENT '盐值',
  `registerTime` datetime NOT NULL COMMENT '注册时间',
  `registerIp` varchar(255) NOT NULL COMMENT '注册所用IP',
  PRIMARY KEY (`id`),
  UNIQUE KEY `iName` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin',0,'12366666666','',0,'',0,'2020-12-11 22:45:35','127.0.0.1',1,'605f5279c4f24badeb2538719c1900859a28e62ac842db4f166dd036118bedab','yybl','2020-08-28 19:19:57','127.0.0.1'),(2,'admin1',0,'','',0,'',0,'2020-10-12 09:24:25','0:0:0:0:0:0:0:1',1,'075fe082915eca2c3fe67d99bba35180e91424a4c14be435ffaa141d9b4d0346','dtec','2020-10-12 09:19:17','0:0:0:0:0:0:0:1');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'alex'
--

--
-- Dumping routines for database 'alex'
--
/*!50003 DROP PROCEDURE IF EXISTS `p_clean_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`::1` PROCEDURE `p_clean_data`()
BEGIN
    truncate table adminRoles;
    truncate table adminUsers;
    truncate table logs;
    truncate table userLogs;
    truncate table users;
    
    insert into users (name, level, mobile, avatar, sex, email, surplus, lastLoginTime, lastLoginIp, status, password, salt, registerTime, registerIp) VALUES ('admin', 0, '', '', 0, '', 0, null, null, 1, '605f5279c4f24badeb2538719c1900859a28e62ac842db4f166dd036118bedab', 'yybl', now(), '127.0.0.1');
    insert into adminUsers set userId = 1, roleId = 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-20 19:50:06
