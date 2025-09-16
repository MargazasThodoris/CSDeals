CREATE TABLE `tradeBot_IndividualItemPriceSettings` (
  `id` INT(255) UNSIGNED NOT NULL AUTO_INCREMENT,
  `onSiteHistoryId` BIGINT(20) DEFAULT NULL COMMENT '->onSiteInventories_ItemHistory.id; Target item. Set to null when the setting is removed',
  `type` SMALLINT(255) NOT NULL DEFAULT 0 COMMENT 'Type of the price setting: 1=Static price, 2=decaying price',
  `price1` DECIMAL(10, 4) DEFAULT NULL COMMENT 'Price in USD. Used for static price and starting price for decaying price',
  `price2` DECIMAL(10, 4) DEFAULT NULL COMMENT 'Price decay ending price',
  `price3` DECIMAL(10, 2) DEFAULT NULL,
  `time1` INT(10) UNSIGNED DEFAULT NULL COMMENT 'Price decay setting time1',
  `time2` INT(10) UNSIGNED DEFAULT NULL COMMENT 'Price decay setting time2',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Overrides default prices on a specific item on the tradebot';

ALTER TABLE `tradeBot_IndividualItemPriceSettings` 
  ADD UNIQUE INDEX uniq(onSiteHistoryId);