CREATE TABLE `onSiteTrades_Adyen_Orders_Items` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `onSiteTradeId` INT(10) UNSIGNED NOT NULL COMMENT '->onSiteTrades_Trades.id',
  `onSiteTradeItemId` BIGINT(255) UNSIGNED NOT NULL COMMENT '->onSiteTrades_Items.id',
  `onSiteHistoryId` BIGINT(255) UNSIGNED NOT NULL COMMENT '->onSiteInventories_ItemHistory.id',
  `userSaleId` INT(255) UNSIGNED NOT NULL COMMENT '->userSales_ListedItemsHistory.id',
  `amount` INT(10) NOT NULL COMMENT 'Quantity of this on-site item',
  `purchasePriceEach` DECIMAL(10, 2) NOT NULL COMMENT 'This is the price to the seller in payment currency, not necessarily what will be paid to the seller',
  `originalPriceInCurrency` SMALLINT(255) NOT NULL COMMENT '\\CSDEALS\\Config\\Currencies',
  `originalPriceEach` DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (id, onSiteTradeId, onSiteTradeItemId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Adds additional details for items in an on-site trade that is an Adyen order';

ALTER TABLE `onSiteTrades_Adyen_Orders_Items` 
  ADD UNIQUE INDEX uniq(onSiteTradeId, onSiteHistoryId);

ALTER TABLE `onSiteTrades_Adyen_Orders_Items` 
  ADD CONSTRAINT `onSiteTrades_Adyen_Orders_Items_onSiteHistoryId` FOREIGN KEY (onSiteHistoryId)
    REFERENCES onSiteInventories_ItemHistory(id);

ALTER TABLE `onSiteTrades_Adyen_Orders_Items` 
  ADD CONSTRAINT `onSiteTrades_Adyen_Orders_Items_onSiteTradeId` FOREIGN KEY (onSiteTradeId)
    REFERENCES onSiteTrades_Trades(id);

ALTER TABLE `onSiteTrades_Adyen_Orders_Items` 
  ADD CONSTRAINT `onSiteTrades_Adyen_Orders_Items_onSiteTradeItemId` FOREIGN KEY (onSiteTradeItemId)
    REFERENCES onSiteTrades_Items(id);

ALTER TABLE `onSiteTrades_Adyen_Orders_Items` 
  ADD CONSTRAINT `onSiteTrades_Adyen_Orders_Items_userSaleId` FOREIGN KEY (userSaleId)
    REFERENCES userSales_ListedItemsHistory(id);