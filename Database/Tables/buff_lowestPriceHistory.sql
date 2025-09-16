CREATE TABLE `buff_lowestPriceHistory` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemid` INT(10) UNSIGNED NOT NULL COMMENT '->items.id',
  `phaseitemid` INT(11) UNSIGNED DEFAULT NULL COMMENT '->items_phases.phaseitemid',
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'Timestamp when this data was fetched',
  `lowestPriceCNY` DECIMAL(9, 2) NOT NULL COMMENT 'Price of the listing in CNY',
  `lowestPriceUSD` DECIMAL(7, 2) NOT NULL COMMENT 'Price of the listing in USD, converted from CNY. Using the USD/CNY at the time of sale',
  `firstPageCNYPrices` VARCHAR(1000) DEFAULT NULL COMMENT 'List of all prices on the first page in CNY',
  PRIMARY KEY (id, itemid)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs scraped lowest item prices from buff163';

ALTER TABLE `buff_lowestPriceHistory` 
  ADD INDEX search(itemid, phaseitemid, time);

ALTER TABLE `buff_lowestPriceHistory` 
  ADD CONSTRAINT `buffLowestPricesItemid` FOREIGN KEY (itemid)
    REFERENCES items(id);

ALTER TABLE `buff_lowestPriceHistory` 
  ADD CONSTRAINT `buffLowestPricesPhaseitemid` FOREIGN KEY (phaseitemid)
    REFERENCES items_phases(phaseitemid);