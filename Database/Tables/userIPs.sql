CREATE TABLE `userIPs` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` INT(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '->users.id',
  `IP` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'integer representation of the IP address',
  `IPstr` VARCHAR(46) NOT NULL DEFAULT '' COMMENT 'IP address string',
  `firstseen` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'When the IP was first seen for this user',
  `lastseen` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'When the IP was last seen for this user',
  `country` CHAR(2) DEFAULT NULL COMMENT 'Country code of the IP location',
  PRIMARY KEY (id, userid, IP, IPstr),
  INDEX id(id),
  INDEX id_2(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs all IP addresses used by registered users';

ALTER TABLE `userIPs` 
  ADD UNIQUE INDEX uniq(userid, IP, IPstr);

ALTER TABLE `userIPs` 
  ADD INDEX recentIPs(userid, lastseen);

ALTER TABLE `userIPs` 
  ADD INDEX findSameHousehold(IPstr, userid, lastseen);