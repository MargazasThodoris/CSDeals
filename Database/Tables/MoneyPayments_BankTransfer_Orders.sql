CREATE TABLE `MoneyPayments_BankTransfer_Orders` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `orderId` CHAR(36) NOT NULL,
  `invoiceReferenceNumber` VARCHAR(100) NOT NULL,
  `invoiceReferenceNumberCompact` VARCHAR(255) GENERATED ALWAYS AS (replace(`invoiceReferenceNumber`,' ','')) STORED,
  `paymentArchiveId` VARCHAR(100) DEFAULT NULL,
  `paidAmount` DECIMAL(8, 2) DEFAULT NULL,
  `bankDetails` LONGTEXT BINARY CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Used to display the correct details to the recipient in the invoice even if the bank has changed',
  PRIMARY KEY (id, orderId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'OBSOLETE. For old balance system';

ALTER TABLE `MoneyPayments_BankTransfer_Orders` 
  ADD UNIQUE INDEX orderId(orderId);

ALTER TABLE `MoneyPayments_BankTransfer_Orders` 
  ADD UNIQUE INDEX reference(invoiceReferenceNumber);

ALTER TABLE `MoneyPayments_BankTransfer_Orders` 
  ADD UNIQUE INDEX referenceCompact(invoiceReferenceNumberCompact);