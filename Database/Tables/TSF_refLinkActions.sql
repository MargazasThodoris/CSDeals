CREATE TABLE `TSF_refLinkActions` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `refLinkId` INT(11) NOT NULL DEFAULT 0,
  `actionid` INT(11) NOT NULL DEFAULT 0 COMMENT '1=login, 2=register, 3=unlogged in visit, 4=logged in visit',
  `userid` INT(11) DEFAULT NULL,
  `time` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `IPstr` VARCHAR(46) NOT NULL,
  `HTTPreferer` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id, refLinkId, actionid)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `TSF_refLinkActions` 
  ADD INDEX userid(userid);