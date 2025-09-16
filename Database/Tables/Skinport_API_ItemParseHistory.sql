CREATE TABLE `Skinport_API_ItemParseHistory` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'UNIX timestamp of the attempt',
  `itemid` INT(10) UNSIGNED NOT NULL COMMENT '->items.id',
  `success` INT(11) NOT NULL DEFAULT 1 COMMENT 'Whether the parsing was successful',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs attempts for fetching a specific item price history from Skinport API';

ALTER TABLE `Skinport_API_ItemParseHistory` 
  ADD INDEX quickLookup(itemid, success, time);