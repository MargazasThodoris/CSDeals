CREATE TABLE `steamMarket_ItemParseHistory` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'UNIX timestamp of the attempt',
  `itemid` INT(10) UNSIGNED NOT NULL COMMENT '->items.id',
  `success` INT(11) NOT NULL DEFAULT 1 COMMENT 'flag whether the scraping was successful',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs attempts of scraping a specific item price history from Steam Community Market';

ALTER TABLE `steamMarket_ItemParseHistory` 
  ADD INDEX quickLookup(itemid, time, success);