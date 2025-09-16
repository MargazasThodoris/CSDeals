CREATE TABLE `MoneyPayments_OrderReservedItems` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemPurchaseOrderId` INT(10) UNSIGNED NOT NULL,
  `onSiteHistoryId` INT(255) UNSIGNED NOT NULL,
  `priceEUR` DECIMAL(8, 2) DEFAULT NULL,
  `priceUSD` DECIMAL(8, 2) DEFAULT NULL,
  PRIMARY KEY (id, itemPurchaseOrderId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'OBSOLETE. For old balance system';