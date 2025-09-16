CREATE TABLE `onSiteInventories_ItemReplacementHistory` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sourceOnSiteHistoryId` BIGINT(11) UNSIGNED NOT NULL COMMENT '->onSiteInventories_ItemHistory.id; Which item was replaced',
  `targetOnSiteHistoryId` BIGINT(11) UNSIGNED NOT NULL COMMENT '->onSiteInventories_ItemHistory.id; What is the new on-site item id of the item. If the replaced item is replaced again, this value is updated and originalTargetOnSiteHistoryId is set',
  `time` INT(10) UNSIGNED NOT NULL,
  `originalTargetOnSiteHistoryId` BIGINT(11) UNSIGNED DEFAULT NULL COMMENT '->onSiteInventories_ItemHistory.id',
  PRIMARY KEY (id, sourceOnSiteHistoryId, targetOnSiteHistoryId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'When the assetid of an item on our bot changes on Steam, our system can find the new item in the inventory and replace all on-site items using the old botInventoryItem to point to the new botInventoryItem. This table keeps track of those changes. The assetid of an item may change for example when Steam randomly stacks all Rust items in an inventory.';

ALTER TABLE `onSiteInventories_ItemReplacementHistory` 
  ADD UNIQUE INDEX sourceOnSiteHistoryId(sourceOnSiteHistoryId);

ALTER TABLE `onSiteInventories_ItemReplacementHistory` 
  ADD CONSTRAINT `oihReplacementoriginalTargetOnSiteHistoryId` FOREIGN KEY (originalTargetOnSiteHistoryId)
    REFERENCES onSiteInventories_ItemHistory(id);

ALTER TABLE `onSiteInventories_ItemReplacementHistory` 
  ADD CONSTRAINT `oihReplacementssourceOnSiteHistoryId` FOREIGN KEY (sourceOnSiteHistoryId)
    REFERENCES onSiteInventories_ItemHistory(id);

ALTER TABLE `onSiteInventories_ItemReplacementHistory` 
  ADD CONSTRAINT `oihReplacementtargetOnSiteHistoryId` FOREIGN KEY (targetOnSiteHistoryId)
    REFERENCES onSiteInventories_ItemHistory(id);