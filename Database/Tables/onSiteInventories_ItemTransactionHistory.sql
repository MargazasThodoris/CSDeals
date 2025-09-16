CREATE TABLE `onSiteInventories_ItemTransactionHistory` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sourceOnSiteHistoryId` BIGINT(10) UNSIGNED DEFAULT NULL COMMENT '->onSiteInventories_ItemHistory.id; Will be null for deposited Steam items',
  `targetOnSiteHistoryId` BIGINT(10) UNSIGNED DEFAULT NULL COMMENT '->onSiteInventories_ItemHistory.id; will be null for withdrawn Steam items',
  `fromInventoryId` INT(11) UNSIGNED DEFAULT NULL COMMENT '->onSiteInventories_Inventories.id;
This is NULL if the item was just deposited to the initial inventory',
  `toInventoryId` INT(11) UNSIGNED DEFAULT NULL COMMENT '->onSiteInventories_Inventories.id; If the item was withdrawn in a Steam trade, this is null',
  `amount` INT(11) NOT NULL DEFAULT 1 COMMENT 'Quantity of items transferred from the stack',
  `time` INT(11) NOT NULL DEFAULT 0,
  `onSiteTradeItemId` BIGINT(10) UNSIGNED DEFAULT NULL COMMENT '->onSiteTrades_Items.id; This will be null if no on-site trade was involved',
  `steamTradeItemId` BIGINT(20) UNSIGNED DEFAULT NULL COMMENT '->steamTrades_Items.id; set if the item was withdrawn or deposited',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs ALL stack amount changes, new items and gone items from onSiteInventories_ItemHistories. Different from botInventories_ItemStackAmountChanges because that table only tracks stack amount changes.';

ALTER TABLE `onSiteInventories_ItemTransactionHistory` 
  ADD INDEX targetOnSIteHistoryId(targetOnSiteHistoryId) COMMENT 'Used so we can trace back where items came from (for tradebot trades)';

ALTER TABLE `onSiteInventories_ItemTransactionHistory` 
  ADD CONSTRAINT `itemTransactionHistoryfromInventoryId` FOREIGN KEY (fromInventoryId)
    REFERENCES onSiteInventories_Inventories(id);

ALTER TABLE `onSiteInventories_ItemTransactionHistory` 
  ADD CONSTRAINT `itemTransactionHistoryonSiteTradeItemId` FOREIGN KEY (onSiteTradeItemId)
    REFERENCES onSiteTrades_Items(id);

ALTER TABLE `onSiteInventories_ItemTransactionHistory` 
  ADD CONSTRAINT `itemTransactionHistorysourceOnSiteHistoryId` FOREIGN KEY (sourceOnSiteHistoryId)
    REFERENCES onSiteInventories_ItemHistory(id);

ALTER TABLE `onSiteInventories_ItemTransactionHistory` 
  ADD CONSTRAINT `itemTransactionHistorysteamTradeItemId` FOREIGN KEY (steamTradeItemId)
    REFERENCES steamTrades_Items(id);

ALTER TABLE `onSiteInventories_ItemTransactionHistory` 
  ADD CONSTRAINT `itemTransactionHistorytargetOnSiteHistoryId` FOREIGN KEY (targetOnSiteHistoryId)
    REFERENCES onSiteInventories_ItemHistory(id);

ALTER TABLE `onSiteInventories_ItemTransactionHistory` 
  ADD CONSTRAINT `itemTransactionHistorytoInventoryId` FOREIGN KEY (toInventoryId)
    REFERENCES onSiteInventories_Inventories(id);