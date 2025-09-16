CREATE TABLE `userSales_ListedItemsPendingRelistAfterAdyenIntegration` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) UNSIGNED NOT NULL COMMENT '->users.id',
  `userSaleId` INT(11) UNSIGNED NOT NULL COMMENT '->userSales_ListedItemsHistory.id',
  `onSiteHistoryId` BIGINT(255) UNSIGNED DEFAULT NULL COMMENT '->onSiteInventories_ItemHistory.id',
  `marketname` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `amount` VARCHAR(255) NOT NULL COMMENT 'on-site item amount. Must be the same as the number of items in the on-site item stack',
  `isPriceTooHigh` TINYINT(255) NOT NULL DEFAULT 0 COMMENT '1 if the original price is too high for the item to be listed now',
  `isPendingAction` TINYINT(255) NOT NULL DEFAULT 1 COMMENT '1 if this item has not been relisted or cancelled',
  PRIMARY KEY (id, userId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Items that were listed for sale by users before integration to Adyen were inserted to this table. The entires are never deleted, just the status of the sale is changed.';

ALTER TABLE `userSales_ListedItemsPendingRelistAfterAdyenIntegration` 
  ADD UNIQUE INDEX uniq(userSaleId);

ALTER TABLE `userSales_ListedItemsPendingRelistAfterAdyenIntegration` 
  ADD INDEX userId(userId, isPendingAction);

ALTER TABLE `userSales_ListedItemsPendingRelistAfterAdyenIntegration` 
  ADD INDEX search(userId, onSiteHistoryId);