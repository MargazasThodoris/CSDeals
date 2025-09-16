CREATE TABLE `onSiteInventories_ItemHistory_copy1` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `inventoryId` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '->onSiteInventories_Inventories.id; 
In which inventory this item resides. This is static and cannot change. If an item is transferred, a new entry is created',
  `historyId` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '->botInventories_ItemHistory.id',
  `amount` INT(11) NOT NULL DEFAULT 1 COMMENT 'Quantity of the item in this stack. This column is updated when the stack amount changes and is finally set to 0 when the stack is completely gone',
  `timeSeen` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'When this entry was created',
  `timeGone` INT(10) UNSIGNED DEFAULT NULL COMMENT 'When the last item in the stack was removed',
  `uniqueHelper` BIGINT(255) NOT NULL DEFAULT 0 COMMENT 'This is 0 when the isActive=1 and is simply set to the id when the stack is gone so we can have the unique index for active rows for easy updating of amount column with ON DUPLICATE KEY',
  `itemStackHelper` TINYINT(255) DEFAULT 1 COMMENT 'This is set to 1 if this item has no special properties (such as listed in tradeBot_IndividualPriceSettings or tradeBot_UserItemSales). This way new items to this inventory will be added to this stack.

If the item has special parameters, this field is set to null, so that new items will never be added to this stack.',
  `isActive` TINYINT(4) GENERATED ALWAYS AS (if((`timeGone` is null or `timeGone` = 0) and `amount` > 0,1,0)) STORED COMMENT '1 if this entry is active (the item is in the on-site inventory)',
  PRIMARY KEY (id, inventoryId, historyId),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'History of all on-site items in inventories. Includes old history and currently active items.';

ALTER TABLE `onSiteInventories_ItemHistory_copy1` 
  ADD UNIQUE INDEX uniq(inventoryId, historyId, uniqueHelper, itemStackHelper);

ALTER TABLE `onSiteInventories_ItemHistory_copy1` 
  ADD INDEX onSiteInv_historyId(historyId);

ALTER TABLE `onSiteInventories_ItemHistory_copy1` 
  ADD INDEX currentInv(isActive, inventoryId);

ALTER TABLE `onSiteInventories_ItemHistory_copy1` 
  ADD CONSTRAINT `onSiteInventories_ItemHistory_copy1_ibfk_1` FOREIGN KEY (historyId)
    REFERENCES botInventories_ItemHistory(id);

ALTER TABLE `onSiteInventories_ItemHistory_copy1` 
  ADD CONSTRAINT `onSiteInventories_ItemHistory_copy1_ibfk_2` FOREIGN KEY (inventoryId)
    REFERENCES onSiteInventories_Inventories(id);