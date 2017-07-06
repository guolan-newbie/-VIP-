/*
Navicat MySQL Data Transfer

Source Server         : 123.56.153.56_test
Source Server Version : 50537
Source Host           : 123.56.153.56:3306
Source Database       : member

Target Server Type    : MYSQL
Target Server Version : 50537
File Encoding         : 65001

Date: 2017-03-06 13:43:25
*/
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for accountlog
-- ----------------------------
DROP TABLE IF EXISTS `accountlog`;
CREATE TABLE `accountlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mid` int(11) DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `flag` bit(1) DEFAULT NULL,
  `photo` mediumblob,
  `type` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `fileflag` int(1) unsigned zerofill DEFAULT NULL,
  `upflag` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1455 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `pwd` varchar(50) CHARACTER SET latin1 NOT NULL,
  `salt` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `authority` int(11) DEFAULT NULL,
  `realname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for clue
-- ----------------------------
DROP TABLE IF EXISTS `clue`;
CREATE TABLE `clue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num` varchar(20) NOT NULL,
  `sex` varchar(4) NOT NULL,
  `qq` varchar(20) NOT NULL,
  `btime` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `realName` varchar(20) DEFAULT NULL,
  `school` varchar(50) DEFAULT NULL,
  `diploma` varchar(10) DEFAULT NULL,
  `etime` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `type` bit(1) DEFAULT b'0',
  `aid` int(11) DEFAULT '0',
  `phone` varchar(20) DEFAULT NULL,
  `graduateDate` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `flag` bit(1) DEFAULT NULL,
  `exnum` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=312 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for communication
-- ----------------------------
DROP TABLE IF EXISTS `communication`;
CREATE TABLE `communication` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) NOT NULL DEFAULT '0',
  `aid` int(11) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `content` varchar(1000) NOT NULL,
  `mid` int(50) DEFAULT '0',
  `cid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=450 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `chid` int(11) NOT NULL DEFAULT '0',
  `optional_flag` bit(1) NOT NULL DEFAULT b'0',
  `order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=379 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for course_and_category
-- ----------------------------
DROP TABLE IF EXISTS `course_and_category`;
CREATE TABLE `course_and_category` (
  `caid` int(11) NOT NULL COMMENT '类别category id',
  `cid` int(11) NOT NULL COMMENT '课程course id',
  `order` int(255) DEFAULT '0',
  PRIMARY KEY (`cid`,`caid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for courseandpro
-- ----------------------------
DROP TABLE IF EXISTS `courseandpro`;
CREATE TABLE `courseandpro` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `meid` int(11) DEFAULT '0' COMMENT '会员或体验者id',
  `identityType` int(11) DEFAULT '0',
  `caid` int(11) DEFAULT '0' COMMENT '类别id',
  `chorder` int(11) DEFAULT '0' COMMENT '章节order',
  `corder` int(11) DEFAULT '0' COMMENT '课程order',
  `proportion` decimal(5,2) DEFAULT '0.00' COMMENT '完成百分比',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for dailylog
-- ----------------------------
DROP TABLE IF EXISTS `dailylog`;
CREATE TABLE `dailylog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '姓名',
  `time` datetime DEFAULT NULL COMMENT '时间',
  `context` text COMMENT '工作日志内容',
  `created` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for experience
-- ----------------------------
DROP TABLE IF EXISTS `experience`;
CREATE TABLE `experience` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL,
  `salt` varchar(255) NOT NULL,
  `noticeTime` datetime DEFAULT NULL,
  `name` varchar(20) NOT NULL,
  `sex` varchar(2) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `student` bit(1) NOT NULL DEFAULT b'0',
  `school` varchar(50) NOT NULL,
  `company` varchar(50) DEFAULT NULL,
  `graduateDate` date NOT NULL DEFAULT '0000-00-00',
  `province` varchar(10) DEFAULT NULL,
  `beginTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `endTime` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `aid` int(11) DEFAULT '0',
  `flag` bit(1) DEFAULT b'0',
  `memo` varchar(1000) DEFAULT NULL,
  `summaryflag` bit(1) DEFAULT b'1',
  `seat_provid` int(11) DEFAULT NULL,
  `qq` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=267 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for interest
-- ----------------------------
DROP TABLE IF EXISTS `interest`;
CREATE TABLE `interest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `aid` int(11) DEFAULT NULL,
  `money` double(11,2) DEFAULT NULL,
  `amount` double(15,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5734 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `school` varchar(50) DEFAULT NULL,
  `company` varchar(50) DEFAULT NULL,
  `mobile` varchar(18) DEFAULT NULL,
  `student` bit(1) DEFAULT NULL,
  `graduateDate` date NOT NULL,
  `time` datetime DEFAULT NULL,
  `abnormal` bit(1) DEFAULT b'0',
  `provid` int(11) DEFAULT NULL,
  `flag` bit(1) NOT NULL DEFAULT b'1',
  `alog` int(11) DEFAULT '0',
  `restAmount` float DEFAULT NULL,
  `restInterest` float DEFAULT '0',
  `fee` bit(1) DEFAULT b'0',
  `aid` int(50) DEFAULT '0',
  `eid` int(50) DEFAULT '0',
  `summaryflag` bit(1) DEFAULT b'1',
  `seat_provid` int(11) DEFAULT NULL,
  `periodStatus` int(11) DEFAULT NULL COMMENT 'periodStatus',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=351 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aid` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `publishtime` datetime DEFAULT NULL,
  `duetime` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `status` bit(1) DEFAULT NULL,
  `enable` bit(1) DEFAULT NULL,
  `settop` bit(1) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for onduty
-- ----------------------------
DROP TABLE IF EXISTS `onduty`;
CREATE TABLE `onduty` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `mid` int(10) NOT NULL,
  `start` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '申请时间',
  `flag` bit(1) DEFAULT NULL COMMENT '-1:表示不通过0:表示未审核1:表示已通过',
  `read` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=64 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for ondutylog
-- ----------------------------
DROP TABLE IF EXISTS `ondutylog`;
CREATE TABLE `ondutylog` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `oid` int(10) NOT NULL,
  `mid` int(10) NOT NULL,
  `cid` int(10) DEFAULT NULL,
  `beHelpedName` varchar(255) NOT NULL,
  `beHelpedQQ` varchar(255) NOT NULL,
  `beHelpedInfo` varchar(255) NOT NULL,
  `qustionDescription` varchar(255) NOT NULL,
  `solutionReport` varchar(1000) NOT NULL,
  `flag` bit(1) DEFAULT NULL,
  `checkTime` timestamp NULL DEFAULT NULL,
  `submitTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `mid` (`mid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for period
-- ----------------------------
DROP TABLE IF EXISTS `period`;
CREATE TABLE `period` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mid` int(11) DEFAULT NULL,
  `duetime` datetime DEFAULT NULL,
  `amount` double(15,2) DEFAULT NULL,
  `restamount` double(15,2) DEFAULT NULL,
  `minterest` double(15,2) DEFAULT NULL,
  `total` double(15,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5353 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for picture
-- ----------------------------
DROP TABLE IF EXISTS `picture`;
CREATE TABLE `picture` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `photo` mediumblob,
  `title` varchar(255) DEFAULT NULL,
  `flag` bit(1) DEFAULT NULL,
  `cover` bit(1) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `share` bit(1) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=625 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for province
-- ----------------------------
DROP TABLE IF EXISTS `province`;
CREATE TABLE `province` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for summary
-- ----------------------------
DROP TABLE IF EXISTS `summary`;
CREATE TABLE `summary` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `mid` int(50) DEFAULT '0',
  `pid` int(255) DEFAULT '0',
  `time` datetime DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` text NOT NULL,
  `aid` int(11) NOT NULL DEFAULT '0',
  `ischeck` bit(1) DEFAULT NULL,
  `eid` int(50) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mid` (`mid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=7478 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for summary_visit
-- ----------------------------
DROP TABLE IF EXISTS `summary_visit`;
CREATE TABLE `summary_visit` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `sid` int(11) NOT NULL COMMENT '周报的id(因summary表是MyISAM的 不能添加外键 当周报被删除时会出现无效数据)',
  `flag` int(11) NOT NULL COMMENT '标志(管理员、会员、体验会员)',
  `name` varchar(255) NOT NULL COMMENT '名字',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12548 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for thanksgiving
-- ----------------------------
DROP TABLE IF EXISTS `thanksgiving`;
CREATE TABLE `thanksgiving` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `mgid` int(50) DEFAULT NULL,
  `mrid` int(255) DEFAULT '0',
  `money` int(255) DEFAULT '0',
  `gname` varchar(255) DEFAULT NULL,
  `rname` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `pwd` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `salt` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `noticeTime` datetime DEFAULT NULL,
  `root` int(1) DEFAULT '2' COMMENT '判断用户资料是否完善 默认值为2 0表示完善 1表示未填写信用信息 2表示未填写个人信息和信用信息',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1168 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for userinfo
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `idNo` varchar(30) DEFAULT NULL,
  `qqNo` varchar(30) DEFAULT NULL,
  `payAccount` varchar(40) DEFAULT NULL,
  `contactName` varchar(255) DEFAULT NULL,
  `contactMobile` varchar(40) DEFAULT NULL,
  `relation` varchar(20) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=246 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for visitor
-- ----------------------------
DROP TABLE IF EXISTS `visitor`;
CREATE TABLE `visitor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `meid` int(11) DEFAULT NULL,
  `identityType` int(11) DEFAULT NULL,
  `VisitTime` datetime DEFAULT NULL,
  `LeftTime` datetime DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `agent` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22109 DEFAULT CHARSET=utf8;

-- ----------------------------
-- View structure for interestdetail
-- ----------------------------
DROP VIEW IF EXISTS `interestdetail`;
CREATE ALGORITHM=UNDEFINED DEFINER=`test`@`%` SQL SECURITY DEFINER VIEW `interestdetail` AS select `interest`.`amount` AS `i_amount`,`accountlog`.`amount` AS `a_amount`,`accountlog`.`date` AS `a_date`,`period`.`duetime` AS `p_duetime`,`period`.`amount` AS `p_amount`,`accountlog`.`mid` AS `mid`,`interest`.`money` AS `i_money` from ((`interest` join `accountlog` on((`interest`.`aid` = `accountlog`.`id`))) join `period` on((`interest`.`pid` = `period`.`id`))) ;

-- ----------------------------
-- View structure for memberinfo
-- ----------------------------
DROP VIEW IF EXISTS `memberinfo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `memberinfo` AS select `member`.`name` AS `name`,`user`.`name` AS `uid`,`member`.`time` AS `time`,`member`.`id` AS `id`,`member`.`fee` AS `fee` from (`member` join `user`) where (`member`.`uid` = `user`.`id`) ;

-- ----------------------------
-- View structure for v_looksummary
-- ----------------------------
DROP VIEW IF EXISTS `v_looksummary`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_looksummary` AS select `s`.`id` AS `sid`,`s`.`title` AS `title`,`s`.`content` AS `content`,`s`.`ischeck` AS `ischeckval`,`s`.`time` AS `time`,`e`.`id` AS `id`,`e`.`num` AS `num`,`e`.`name` AS `name`,`e`.`aid` AS `aid`,`e`.`summaryflag` AS `summaryflag`,0 AS `identityType`,`s`.`pid` AS `pid` from (`experience` `e` left join `summary` `s` on((`s`.`eid` = `e`.`id`))) union all select `v`.`id` AS `sid`,`v`.`title` AS `title`,`v`.`content` AS `content`,`v`.`ischeckval` AS `ischeckval`,`v`.`time` AS `time`,`v`.`mid` AS `id`,`v`.`num` AS `num`,`v`.`name` AS `name`,`v`.`aid` AS `aid`,`v`.`summaryflag` AS `summaryflag`,1 AS `identityType`,`v`.`pid` AS `pid` from `v_membersum2` `v` order by `num` ;

-- ----------------------------
-- View structure for v_mem&exp
-- ----------------------------
DROP VIEW IF EXISTS `v_mem&exp`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_mem&exp` AS select `e`.`id` AS `id`,`e`.`num` AS `num`,`e`.`name` AS `name`,`e`.`aid` AS `aid`,`e`.`summaryflag` AS `summaryflag`,0 AS `identityType`,`e`.`beginTime` AS `beginTime` from `experience` `e` where (`e`.`flag` = 0) union all select `v`.`id` AS `id`,`v`.`num` AS `num`,`v`.`name` AS `name`,`v`.`aid` AS `aid`,`v`.`summaryflag` AS `summaryflag`,1 AS `identityType`,`v`.`beginTime` AS `beginTime` from `v_member` `v` order by `num` ;

-- ----------------------------
-- View structure for v_member
-- ----------------------------
DROP VIEW IF EXISTS `v_member`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_member` AS select `m`.`id` AS `id`,`u`.`name` AS `num`,`m`.`name` AS `name`,`m`.`aid` AS `aid`,`m`.`summaryflag` AS `summaryflag`,`m`.`time` AS `beginTime` from (`member` `m` join `user` `u`) where (`u`.`id` = `m`.`uid`) ;

-- ----------------------------
-- View structure for v_membersum1
-- ----------------------------
DROP VIEW IF EXISTS `v_membersum1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_membersum1` AS select `s`.`id` AS `id`,`s`.`title` AS `title`,`s`.`content` AS `content`,`s`.`ischeck` AS `ischeckval`,`s`.`time` AS `time`,`s`.`pid` AS `pid`,`m`.`id` AS `mid`,`m`.`uid` AS `muid`,`m`.`name` AS `name`,`m`.`aid` AS `aid`,`m`.`summaryflag` AS `summaryflag` from (`summary` `s` left join `member` `m` on((`s`.`mid` = `m`.`id`))) ;

-- ----------------------------
-- View structure for v_membersum2
-- ----------------------------
DROP VIEW IF EXISTS `v_membersum2`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_membersum2` AS select `v`.`id` AS `id`,`v`.`title` AS `title`,`v`.`content` AS `content`,`v`.`ischeckval` AS `ischeckval`,`v`.`time` AS `time`,`v`.`mid` AS `mid`,`u`.`name` AS `num`,`v`.`name` AS `name`,`v`.`aid` AS `aid`,`v`.`summaryflag` AS `summaryflag`,`v`.`pid` AS `pid` from (`v_membersum1` `v` join `user` `u`) where (`u`.`id` = `v`.`muid`) ;

-- ----------------------------
-- View structure for v_reconfiguration_relay_experience
-- ----------------------------
DROP VIEW IF EXISTS `v_reconfiguration_relay_experience`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_reconfiguration_relay_experience` AS select `e`.`id` AS `id`,`e`.`num` AS `num`,`e`.`password` AS `password`,`e`.`salt` AS `salt`,`e`.`noticeTime` AS `noticeTime`,`e`.`name` AS `name`,`e`.`sex` AS `sex`,`e`.`phone` AS `phone`,`e`.`student` AS `student`,`e`.`school` AS `school`,`e`.`company` AS `company`,`e`.`graduateDate` AS `graduateDate`,`e`.`province` AS `province`,`e`.`beginTime` AS `beginTime`,`e`.`endTime` AS `endTime`,`e`.`aid` AS `aid`,`e`.`flag` AS `flag`,`e`.`memo` AS `memo`,`e`.`summaryflag` AS `summaryflag`,`e`.`seat_provid` AS `seat_provid`,`p`.`name` AS `provname`,`p1`.`name` AS `seat_provname`,`a`.`realname` AS `arealname` from (((`experience` `e` left join `province` `p` on((`e`.`province` = `p`.`id`))) left join `province` `p1` on((`e`.`seat_provid` = `p1`.`id`))) left join `admin` `a` on((`e`.`aid` = `a`.`id`))) ;

-- ----------------------------
-- View structure for v_reconfiguration_relay_mem&exp
-- ----------------------------
DROP VIEW IF EXISTS `v_reconfiguration_relay_mem&exp`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_reconfiguration_relay_mem&exp` AS select `e`.`id` AS `id`,`e`.`num` AS `num`,`e`.`password` AS `password`,`e`.`salt` AS `salt`,`e`.`noticeTime` AS `noticeTime`,`e`.`name` AS `name`,`e`.`sex` AS `sex`,`e`.`phone` AS `phone`,`e`.`student` AS `student`,`e`.`school` AS `school`,`e`.`company` AS `company`,`e`.`graduateDate` AS `graduateDate`,`e`.`province` AS `province`,`e`.`beginTime` AS `beginTime`,`e`.`aid` AS `aid`,`e`.`flag` AS `flag`,`e`.`summaryflag` AS `summaryflag`,`e`.`seat_provid` AS `seat_provid`,`e`.`provname` AS `provname`,`e`.`seat_provname` AS `seat_provname`,`e`.`arealname` AS `arealname`,0 AS `identityType` from `v_reconfiguration_relay_experience` `e` where (`e`.`flag` = 0) union all select `m`.`id` AS `id`,`m`.`num` AS `num`,`m`.`password` AS `password`,`m`.`salt` AS `salt`,`m`.`noticeTime` AS `noticeTime`,`m`.`name` AS `name`,`m`.`sex` AS `sex`,`m`.`mobile` AS `phone`,`m`.`student` AS `student`,`m`.`school` AS `school`,`m`.`company` AS `company`,`m`.`graduateDate` AS `graduateDate`,`m`.`provid` AS `provid`,`m`.`time` AS `beginTime`,`m`.`aid` AS `aid`,`m`.`flag` AS `flag`,`m`.`summaryflag` AS `summaryflag`,`m`.`seat_provid` AS `seat_provid`,`m`.`provname` AS `provname`,`m`.`seat_provname` AS `seat_provname`,`m`.`arealname` AS `arealname`,1 AS `identityType` from `v_reconfiguration_relay_member` `m` ;

-- ----------------------------
-- View structure for v_reconfiguration_relay_member
-- ----------------------------
DROP VIEW IF EXISTS `v_reconfiguration_relay_member`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_reconfiguration_relay_member` AS select `m`.`id` AS `id`,`m`.`uid` AS `uid`,`m`.`name` AS `name`,`m`.`sex` AS `sex`,`m`.`school` AS `school`,`m`.`company` AS `company`,`m`.`mobile` AS `mobile`,`m`.`student` AS `student`,`m`.`graduateDate` AS `graduateDate`,`m`.`time` AS `time`,`m`.`abnormal` AS `abnormal`,`m`.`provid` AS `provid`,`m`.`flag` AS `flag`,`m`.`alog` AS `alog`,`m`.`restAmount` AS `restAmount`,`m`.`restInterest` AS `restInterest`,`m`.`fee` AS `fee`,`m`.`aid` AS `aid`,`m`.`eid` AS `eid`,`m`.`summaryflag` AS `summaryflag`,`m`.`seat_provid` AS `seat_provid`,`p`.`name` AS `provname`,`p1`.`name` AS `seat_provname`,`a`.`realname` AS `arealname`,`u`.`name` AS `num`,`u`.`pwd` AS `password`,`u`.`salt` AS `salt`,`u`.`time` AS `utime`,`u`.`noticeTime` AS `noticeTime` from ((((`member` `m` left join `province` `p` on((`m`.`provid` = `p`.`id`))) left join `province` `p1` on((`m`.`seat_provid` = `p1`.`id`))) left join `admin` `a` on((`m`.`aid` = `a`.`id`))) left join `user` `u` on((`m`.`uid` = `u`.`id`))) ;

-- ----------------------------
-- View structure for v_studentandcategory
-- ----------------------------
DROP VIEW IF EXISTS `v_studentandcategory`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_studentandcategory` AS select `v`.`id` AS `meid`,`v`.`identityType` AS `identityType`,`v`.`num` AS `num`,`v`.`name` AS `name`,`v`.`aid` AS `aid`,`ca`.`id` AS `caid`,`ca`.`title` AS `title` from (`v_mem&exp` `v` join `category` `ca`) order by `v`.`num` ;

-- ----------------------------
-- View structure for v_studentandprocess
-- ----------------------------
DROP VIEW IF EXISTS `v_studentandprocess`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_studentandprocess` AS select `v`.`meid` AS `meid`,`v`.`identityType` AS `identityType`,`v`.`num` AS `num`,`v`.`name` AS `name`,`v`.`aid` AS `aid`,`v`.`caid` AS `caid`,`v`.`title` AS `title`,`cap`.`id` AS `capid`,`cap`.`chorder` AS `chorder`,`cap`.`corder` AS `corder`,`cap`.`proportion` AS `proportion` from (`v_studentandcategory` `v` left join `courseandpro` `cap` on(((`v`.`caid` = `cap`.`caid`) and (`v`.`meid` = `cap`.`meid`) and (`v`.`identityType` = `cap`.`identityType`)))) order by `v`.`num`,`v`.`caid` ;
SET FOREIGN_KEY_CHECKS=1;
