CREATE TABLE `onSiteInventories_ReservedItemsHistory` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `onSiteHistoryId` BIGINT(10) UNSIGNED NOT NULL COMMENT '->onSiteInventories_ItemHistory.id',
  `reservedInOnSiteTradeId` INT(11) UNSIGNED DEFAULT NULL COMMENT '->onSiteTrades_Trades.id',
  `reservedInSteamTradeId` INT(11) UNSIGNED DEFAULT NULL COMMENT '->steamTrades_Trades.id',
  `reservedOnSiteTradeItemId` BIGINT(11) UNSIGNED DEFAULT NULL COMMENT '->onSiteTrades_Items.id',
  `reservedSteamTradeItemId` BIGINT(11) UNSIGNED DEFAULT NULL COMMENT '->steamTrades_Items.id',
  `amount` INT(11) NOT NULL COMMENT 'Amount of items reserved from the on-site item stack',
  `reservedPriceHistoryId` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '->itemPriceHistory.id',
  `isReserved` TINYINT(4) NOT NULL DEFAULT 1 COMMENT '1 or 0 whether the item is currently reserved',
  PRIMARY KEY (id, onSiteHistoryId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'History of all reservations of on-site items. History of old reservations is not really needed for other than debugging/troubleshooting purposes.';

ALTER TABLE `onSiteInventories_ReservedItemsHistory` 
  ADD INDEX onSiteTrade(reservedInOnSiteTradeId, reservedOnSiteTradeItemId);

ALTER TABLE `onSiteInventories_ReservedItemsHistory` 
  ADD INDEX steamTrade(reservedInSteamTradeId, reservedSteamTradeItemId);

ALTER TABLE `onSiteInventories_ReservedItemsHistory` 
  ADD INDEX isReserved(onSiteHistoryId, isReserved);

ALTER TABLE `onSiteInventories_ReservedItemsHistory` 
  ADD CONSTRAINT `reservedItemsHistory_onSiteHistoryId` FOREIGN KEY (onSiteHistoryId)
    REFERENCES onSiteInventories_ItemHistory(id);

ALTER TABLE `onSiteInventories_ReservedItemsHistory` 
  ADD CONSTRAINT `reservedItemsHistory_reservedInOnSiteTradeId` FOREIGN KEY (reservedInOnSiteTradeId)
    REFERENCES onSiteTrades_Trades(id);

ALTER TABLE `onSiteInventories_ReservedItemsHistory` 
  ADD CONSTRAINT `reservedItemsHistory_reservedInSteamTradeId` FOREIGN KEY (reservedInSteamTradeId)
    REFERENCES steamTrades_Trades(id);

ALTER TABLE `onSiteInventories_ReservedItemsHistory` 
  ADD CONSTRAINT `reservedItemsHistory_reservedOnSiteTradeItemId` FOREIGN KEY (reservedOnSiteTradeItemId)
    REFERENCES onSiteTrades_Items(id);

ALTER TABLE `onSiteInventories_ReservedItemsHistory` 
  ADD CONSTRAINT `reservedItemsHistory_reservedPriceHistoryId` FOREIGN KEY (reservedPriceHistoryId)
    REFERENCES itemPriceHistory(id);

ALTER TABLE `onSiteInventories_ReservedItemsHistory` 
  ADD CONSTRAINT `reservedItemsHistory_reservedSteamTradeItemId` FOREIGN KEY (reservedSteamTradeItemId)
    REFERENCES steamTrades_Items(id);