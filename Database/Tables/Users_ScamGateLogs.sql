CREATE TABLE `Users_ScamGateLogs` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) UNSIGNED NOT NULL COMMENT '->users.id',
  `time` INT(255) UNSIGNED NOT NULL COMMENT 'UNIX timestamp of this entry',
  `IPstr` VARCHAR(255) NOT NULL COMMENT 'IP address of the client',
  `action` TINYINT(255) DEFAULT NULL COMMENT '0=ask, 1=do not pass, 2=pass',
  PRIMARY KEY (id, userId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs of scamgate results';

ALTER TABLE `Users_ScamGateLogs` 
  ADD INDEX userId(userId, IPstr);