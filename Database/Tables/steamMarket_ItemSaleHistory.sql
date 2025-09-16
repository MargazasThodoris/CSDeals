CREATE TABLE `steamMarket_ItemSaleHistory` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemid` INT(10) UNSIGNED NOT NULL COMMENT '->items.id',
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'UNIX timestamp of the sale',
  `avgPrice` DECIMAL(8, 3) NOT NULL DEFAULT 0.000 COMMENT 'Average price of the items sold in USD during this time point',
  `volume` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Amount of items sold during this time point',
  `cumulativeVolume` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Total amount of items sold up to this point in all history',
  PRIMARY KEY (id, itemid)
)
ENGINE = MYISAM,
CHARACTER SET latin1,
CHECKSUM = 0,
COLLATE latin1_swedish_ci,
COMMENT = 'Stores scraped item sales history from Steam Community Market';

ALTER TABLE `steamMarket_ItemSaleHistory` 
  ADD UNIQUE INDEX uniq(itemid, time);

ALTER TABLE `steamMarket_ItemSaleHistory` 
  ADD INDEX cumulativeVolume(itemid, cumulativeVolume) COMMENT 'Needed for quick lookup';