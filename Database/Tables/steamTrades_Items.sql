CREATE TABLE `steamTrades_Items` (
  `id` BIGINT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `steamTradeId` INT(11) NOT NULL COMMENT '->steamTrades_Trades.id',
  `itemid` INT(11) UNSIGNED NOT NULL COMMENT '->items.id',
  `phaseitemid` INT(11) DEFAULT NULL COMMENT '->items_phases.phaseitemid',
  `assetid` BIGINT(20) UNSIGNED NOT NULL,
  `amount` INT(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT 'Quantity of items of the stack',
  `priceHistoryId` INT(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '->itemPriceHistory.id',
  `tradeBotPriceHistoryId` BIGINT(255) UNSIGNED DEFAULT NULL COMMENT '->tradeBot_ItemPriceHistory.id',
  `isbotitem` TINYINT(4) NOT NULL DEFAULT 0 COMMENT '1 if this is a bot''s item, 0 if the item is from the user',
  `botInventoryHistoryId` INT(11) UNSIGNED DEFAULT NULL COMMENT '->botInventories_ItemHistory.id',
  `steamInventoryHistoryId` BIGINT(11) UNSIGNED DEFAULT NULL COMMENT '->steamInventories_ItemHistories.id; set if it''s a user''s item',
  `onSiteHistoryId` INT(10) UNSIGNED DEFAULT NULL COMMENT '->onSiteInventories_ItemHistory.id; set if it''s a bot''s item',
  `userSaleHistoryId` INT(10) UNSIGNED DEFAULT NULL COMMENT '->userSales_ListedItemsHistory.id; Was not fully implemented, so not used',
  `userSalePrice` DECIMAL(10, 4) UNSIGNED DEFAULT NULL COMMENT 'We need this so we know how much to pay the seller when the trade is accepted. Was not fully implemented, so not used.',
  PRIMARY KEY (id, steamTradeId),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Links the items to a Steam trade that should be included in the trade';

ALTER TABLE `steamTrades_Items` 
  ADD UNIQUE INDEX uniq(steamTradeId, assetid, isbotitem);

ALTER TABLE `steamTrades_Items` 
  ADD INDEX itemLookup(itemid, isbotitem) COMMENT 'Needed for item stock count query';

ALTER TABLE `steamTrades_Items` 
  ADD INDEX steamInventoryHistoryId(steamInventoryHistoryId);

ALTER TABLE `steamTrades_Items` 
  ADD INDEX onSiteHistoryId(onSiteHistoryId) COMMENT 'Find trades by item';

ALTER TABLE `steamTrades_Items` 
  ADD INDEX tradeItemsLookup(steamTradeId, isbotitem);