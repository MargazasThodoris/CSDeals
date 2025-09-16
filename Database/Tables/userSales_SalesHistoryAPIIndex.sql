CREATE TABLE `userSales_SalesHistoryAPIIndex` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemId` INT(11) NOT NULL COMMENT '->items.id',
  `currency` VARCHAR(255) NOT NULL,
  `rateUsdCurrency` DECIMAL(10, 5) DEFAULT NULL COMMENT 'for example USD/EUR if price was in euro',
  `rateEurCurrency` DECIMAL(10, 5) DEFAULT NULL COMMENT 'for example USD/EUR if price was in USD',
  `completedSaleId` INT(255) UNSIGNED DEFAULT NULL COMMENT 'Just to prevent duplicates',
  `phaseItemId` INT(10) UNSIGNED DEFAULT NULL COMMENT '->items_phases.phaseitemid',
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'UNIX timestamp of the sale',
  `salePrice` DECIMAL(10, 4) NOT NULL COMMENT 'Sale price in `currency`',
  `salePriceConvertedUsd` DECIMAL(10, 4) GENERATED ALWAYS AS (if(`currency` <> 0,round(`salePrice` * `rateUsdCurrency`,2),`salePrice` * `rateUsdCurrency`)) VIRTUAL COMMENT 'Used so we can easily use this price for analytics/price calculations',
  `amount` INT(255) NOT NULL COMMENT 'Quantity of items sold',
  `paintwear` DOUBLE(15, 14) DEFAULT NULL,
  `paintindex` MEDIUMINT(255) DEFAULT NULL,
  PRIMARY KEY (id, itemId, currency)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci,
COMMENT = 'Normalized table of user sales history for faster lookup in REST API endpoint';

ALTER TABLE `userSales_SalesHistoryAPIIndex` 
  ADD UNIQUE INDEX uniq(completedSaleId);

ALTER TABLE `userSales_SalesHistoryAPIIndex` 
  ADD INDEX getsaleshistoryindex(itemId, currency, phaseItemId, time);