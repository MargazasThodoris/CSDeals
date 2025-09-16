CREATE TABLE `WebClientIds` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cid` CHAR(10) NOT NULL COMMENT 'client ID cookie value',
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'UNIX timestamp when this client ID was generated',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Table of all generated client IDs';

ALTER TABLE `WebClientIds` 
  ADD UNIQUE INDEX clientId(cid);