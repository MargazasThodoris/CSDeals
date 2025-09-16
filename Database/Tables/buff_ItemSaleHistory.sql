CREATE TABLE `buff_ItemSaleHistory` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` INT(10) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp of the sale',
  `itemid` INT(11) UNSIGNED DEFAULT NULL COMMENT '->items.id',
  `phaseitemid` INT(255) UNSIGNED DEFAULT NULL COMMENT '->items_phases.phaseitemid',
  `priceCNY` DECIMAL(9, 2) DEFAULT NULL COMMENT 'Price of the sale in CNY',
  `priceUSD` DECIMAL(7, 2) DEFAULT NULL COMMENT 'Price of the sale in USD, converted from CNY. Using the USD/CNY at the time of sale',
  `days` SMALLINT(255) DEFAULT NULL COMMENT 'Whether this data was from the 7 day or 30 day chart. Saved because not sure if 30 day data points may differ from 7 day resulting to duplicate data points',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs scraped item sale history from buff163';

ALTER TABLE `buff_ItemSaleHistory` 
  ADD UNIQUE INDEX itemid_time(itemid, phaseitemid, time);

ALTER TABLE `buff_ItemSaleHistory` 
  ADD CONSTRAINT `buffItemSalesItemid` FOREIGN KEY (itemid)
    REFERENCES items(id);

ALTER TABLE `buff_ItemSaleHistory` 
  ADD CONSTRAINT `buffItemSalesPhaseitemid` FOREIGN KEY (phaseitemid)
    REFERENCES items_phases(phaseitemid);