CREATE TABLE `MoneyPayments_G2A_Orders` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `orderId` INT(11) NOT NULL,
  `G2ATransactionId` VARCHAR(255) DEFAULT NULL,
  `refundG2ATransactionId` VARCHAR(255) DEFAULT NULL,
  `orderCreationRequestContent` TEXT DEFAULT NULL,
  `orderCreationResponseContent` TEXT DEFAULT NULL,
  `transactionId` VARCHAR(200) DEFAULT NULL COMMENT 'To url_ok will be passed GET parameter transactionId with newly created transaction ID.',
  `cancelError` VARCHAR(255) DEFAULT NULL COMMENT 'passed by g2a to the return_url as error parameter. This can be faked by the user',
  `emailAddress` VARCHAR(255) DEFAULT NULL,
  `paymentToken` VARCHAR(200) DEFAULT NULL,
  `paymentMethod` VARCHAR(255) DEFAULT NULL COMMENT 'we get this from g2a',
  `checkoutIPAddress` VARCHAR(68) DEFAULT NULL,
  `orderCreatedAt` INT(255) DEFAULT NULL COMMENT 'We get this from IPN',
  `orderCompleteAt` INT(255) UNSIGNED DEFAULT NULL COMMENT 'We get this from IPN',
  `G2ADebitHoldTransactionId` VARCHAR(255) DEFAULT NULL COMMENT 'When chargebacked, we can automatically log this with a script at https://pay.g2a.com/panel/reversalGrid',
  `G2AReversalTransactionId` VARCHAR(255) DEFAULT NULL COMMENT 'When chargebacked, we can automatically log this with a script at https://pay.g2a.com/panel/reversalGrid',
  `G2ADebitHoldReturnTransactionId` VARCHAR(255) DEFAULT NULL COMMENT 'Parent transaction ID of this transaction is DebitHoldTransactionId',
  `G2ADebitHoldReturnTime` INT(255) UNSIGNED DEFAULT NULL,
  `G2AReversalReturnTransactionId` VARCHAR(255) DEFAULT NULL,
  `G2AReversalReturnTime` INT(255) UNSIGNED DEFAULT NULL,
  `chargebackReason` VARCHAR(255) DEFAULT NULL COMMENT 'Parsed from our received emails',
  `isDisputed` TINYINT(255) DEFAULT 0 COMMENT 'If it''s disputed by us',
  `IPcountry` CHAR(2) DEFAULT NULL,
  `fraudScore` INT(255) DEFAULT NULL COMMENT 'Calculated by us when status is set to paid or processing',
  PRIMARY KEY (id, orderId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'OBSOLETE. For old balance system';

ALTER TABLE `MoneyPayments_G2A_Orders` 
  ADD INDEX transactionId(G2ATransactionId);

ALTER TABLE `MoneyPayments_G2A_Orders` 
  ADD INDEX orderId(orderId);

ALTER TABLE `MoneyPayments_G2A_Orders` 
  ADD INDEX debitHold(G2ADebitHoldTransactionId);

ALTER TABLE `MoneyPayments_G2A_Orders` 
  ADD INDEX reversal(G2AReversalTransactionId);

ALTER TABLE `MoneyPayments_G2A_Orders` 
  ADD INDEX emailAddress(emailAddress);