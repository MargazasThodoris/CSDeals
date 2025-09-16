CREATE TABLE `onSiteTrades_Adyen_Orders_PaymentSplits` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `onSiteTradeid` INT(11) NOT NULL,
  `onSiteTradeItemId` INT(11) DEFAULT NULL,
  `type` INT(11) NOT NULL,
  `userSaleId` INT(11) DEFAULT NULL,
  `value` DECIMAL(10, 2) NOT NULL,
  `currency` INT(11) NOT NULL,
  `adyenBalanceAccountId` VARCHAR(25) DEFAULT NULL,
  `adyenTransferId` VARCHAR(25) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci;

ALTER TABLE `onSiteTrades_Adyen_Orders_PaymentSplits` 
  ADD UNIQUE INDEX UNIQ_1DC59ABD341A00E8(adyenTransferId);

ALTER TABLE `onSiteTrades_Adyen_Orders_PaymentSplits` 
  ADD INDEX saleItem(onSiteTradeid, userSaleId);