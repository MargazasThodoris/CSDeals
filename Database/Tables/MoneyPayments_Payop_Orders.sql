CREATE TABLE `MoneyPayments_Payop_Orders` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `orderId` INT(11) NOT NULL,
  `payopInvoiceId` VARCHAR(255) DEFAULT NULL,
  `refundPayopTransactionId` VARCHAR(255) DEFAULT NULL,
  `payopTransactionId` VARCHAR(255) DEFAULT NULL COMMENT 'from IPN',
  `orderCreationRequestContent` TEXT DEFAULT NULL,
  `orderCreationResponseContent` TEXT DEFAULT NULL,
  `transactionId` VARCHAR(200) DEFAULT NULL COMMENT 'To url_ok will be passed GET parameter transactionId with newly created transaction ID.',
  `cancelError` VARCHAR(255) DEFAULT NULL COMMENT 'passed by g2a to the return_url as error parameter. This can be faked by the user',
  `checkoutIPAddress` VARCHAR(68) DEFAULT NULL,
  `orderCreatedAt` INT(255) DEFAULT NULL COMMENT 'We get this from IPN',
  `orderCompleteAt` INT(255) UNSIGNED DEFAULT NULL COMMENT 'We get this from IPN',
  `IPcountry` CHAR(2) DEFAULT NULL,
  `fraudScore` INT(255) DEFAULT NULL COMMENT 'Calculated by us when status is set to paid or processing',
  PRIMARY KEY (id, orderId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'OBSOLETE. For old balance system';

ALTER TABLE `MoneyPayments_Payop_Orders` 
  ADD INDEX orderId(orderId);

ALTER TABLE `MoneyPayments_Payop_Orders` 
  ADD INDEX payopInvoiceId(payopInvoiceId);