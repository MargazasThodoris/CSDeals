CREATE TABLE `userSales_PendingAdyenSalePayments` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `onSiteTradeid` INT(11) NOT NULL,
  `userId` INT(11) NOT NULL,
  `userSaleId` INT(11) NOT NULL,
  `value` DECIMAL(10, 2) NOT NULL,
  `currency` INT(11) NOT NULL,
  `AdyenOrderPaymentSplitId` INT(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci,
COMMENT = 'When a sale is completed, new rows are inserted here. When the funds have been settled to the seller, the row is deleted. Used to calculate total pending funds to the seller.';

ALTER TABLE `userSales_PendingAdyenSalePayments` 
  ADD UNIQUE INDEX UNIQ_EA4A2DF0D7232DE1(AdyenOrderPaymentSplitId);

ALTER TABLE `userSales_PendingAdyenSalePayments` 
  ADD INDEX search_user(userId);

ALTER TABLE `userSales_PendingAdyenSalePayments` 
  ADD CONSTRAINT `FK_EA4A2DF0D7232DE1` FOREIGN KEY (AdyenOrderPaymentSplitId)
    REFERENCES onSiteTrades_Adyen_Orders_PaymentSplits(id);