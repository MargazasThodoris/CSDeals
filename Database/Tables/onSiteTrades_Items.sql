CREATE TABLE `onSiteTrades_Items` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `onSiteTradeId` INT(10) UNSIGNED NOT NULL COMMENT '->onSiteTrades_Trades.id',
  `onSiteHistoryId` BIGINT(10) UNSIGNED NOT NULL COMMENT '->onSiteInventories_ItemHistory.id',
  `targetOnSiteHistoryId` BIGINT(255) UNSIGNED DEFAULT NULL COMMENT '->onSiteInventories_ItemHistory.id; The new on-site history id after the trade is accepted',
  `amount` INT(11) NOT NULL COMMENT 'quantity of items',
  `priceHistoryId` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '->itemPriceHistory.id',
  `tradeBotPriceHistoryId` BIGINT(20) UNSIGNED DEFAULT NULL COMMENT '->tradeBot_ItemPriceHistory.id',
  `isSendersItem` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'If this item is the sender''s item, not receiver''s',
  `autoWithdraw` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'If this item will be sent on the steam trade after the parent trade is complete',
  `userSaleHistoryId` INT(10) UNSIGNED DEFAULT NULL COMMENT '->userSales_ListedItemsHistory.id; Used for paying the seller the correct amount',
  `userSaleCurrency` SMALLINT(255) DEFAULT NULL,
  `userSalePrice` DECIMAL(10, 4) DEFAULT NULL COMMENT 'We need this so we know how much to pay the seller when the trade is accepted',
  PRIMARY KEY (id, onSiteTradeId, onSiteHistoryId),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Table for all on-site items that are included in on-site trades.';

ALTER TABLE `onSiteTrades_Items` 
  ADD CONSTRAINT `onSiteTrades_Items_OnSiteTradeId` FOREIGN KEY (onSiteTradeId)
    REFERENCES onSiteTrades_Trades(id);

ALTER TABLE `onSiteTrades_Items` 
  ADD CONSTRAINT `onSiteTrades_Items_PriceHistoryId` FOREIGN KEY (priceHistoryId)
    REFERENCES itemPriceHistory(id);

ALTER TABLE `onSiteTrades_Items` 
  ADD CONSTRAINT `onSiteTrades_Items_onSiteHistoryId` FOREIGN KEY (onSiteHistoryId)
    REFERENCES onSiteInventories_ItemHistory(id);

ALTER TABLE `onSiteTrades_Items` 
  ADD CONSTRAINT `onSiteTrades_Items_targetOnSiteHistoryId` FOREIGN KEY (targetOnSiteHistoryId)
    REFERENCES onSiteInventories_ItemHistory(id);

ALTER TABLE `onSiteTrades_Items` 
  ADD CONSTRAINT `onSiteTrades_Items_tradeBotPriceHistoryId` FOREIGN KEY (tradeBotPriceHistoryId)
    REFERENCES tradeBot_ItemPriceHistory(id);

ALTER TABLE `onSiteTrades_Items` 
  ADD CONSTRAINT `onSiteTrades_Items_userSaleHistoryId` FOREIGN KEY (userSaleHistoryId)
    REFERENCES userSales_ListedItemsHistory(id);