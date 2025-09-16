CREATE TABLE `steamItems_ItemTypes` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appid` INT(10) UNSIGNED NOT NULL,
  `type` VARCHAR(255) NOT NULL DEFAULT '0',
  `time` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (id, appid, type)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Index to log each unique Steam item type per app that we see.';

ALTER TABLE `steamItems_ItemTypes` 
  ADD UNIQUE INDEX uniq(appid, type);