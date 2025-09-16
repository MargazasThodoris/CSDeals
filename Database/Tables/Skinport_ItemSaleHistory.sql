CREATE TABLE `Skinport_ItemSaleHistory` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` INT(10) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp of the sale',
  `itemid` INT(11) UNSIGNED DEFAULT NULL COMMENT '->items.id',
  `phaseitemid` INT(255) UNSIGNED DEFAULT NULL COMMENT '->items_phases.id',
  `priceEUR` DECIMAL(9, 2) DEFAULT NULL,
  `priceUSD` DECIMAL(7, 2) DEFAULT NULL COMMENT 'using the rate at the time of sale',
  `salesCount` INT(255) DEFAULT NULL,
  `uniqHelper` INT(255) GENERATED ALWAYS AS (ifnull(`phaseitemid`,0)) VIRTUAL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs scraped item sale history from Skinport without API';

ALTER TABLE `Skinport_ItemSaleHistory` 
  ADD UNIQUE INDEX itemid_time(itemid, uniqHelper, time);