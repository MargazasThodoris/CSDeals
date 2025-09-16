CREATE TABLE `Skinport_ItemParseHistory` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'UNIX timestamp of the attempt',
  `itemid` INT(10) UNSIGNED NOT NULL COMMENT '->items.id',
  `phaseitemid` INT(255) UNSIGNED DEFAULT NULL COMMENT '->items_phases.id',
  `type` SMALLINT(255) NOT NULL DEFAULT 0 COMMENT '0=price history, 1=searching for goods_id, 2=given to external worker',
  `success` INT(11) NOT NULL DEFAULT 1 COMMENT 'Whether the parsing was successful',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs attempts for scraping a specific item price history from Skinport without API';

ALTER TABLE `Skinport_ItemParseHistory` 
  ADD INDEX quickLookup(itemid, phaseitemid, success, type, time);