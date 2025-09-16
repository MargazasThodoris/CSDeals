CREATE TABLE `Skinport_API_ItemSaleHistory` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` INT(10) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp of the sale',
  `itemid` INT(11) DEFAULT NULL COMMENT '->items.id',
  `wear_value` DOUBLE(15, 14) DEFAULT NULL COMMENT 'CS2 item wear value',
  `priceEUR` DECIMAL(9, 2) DEFAULT NULL,
  `priceUSD` DECIMAL(7, 2) DEFAULT NULL COMMENT 'using the rate at the time of sale',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs fetched item sale history from Skinport API';

ALTER TABLE `Skinport_API_ItemSaleHistory` 
  ADD UNIQUE INDEX itemid_time(itemid, time);