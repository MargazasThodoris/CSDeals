CREATE TABLE `MoneyPayments_Daopay_Orders` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `orderId` INT(11) NOT NULL,
  `orderCreationRequestContent` TEXT DEFAULT NULL,
  `orderCreationResponseContent` TEXT DEFAULT NULL,
  `transactionId` VARCHAR(200) DEFAULT NULL COMMENT 'To url_ok will be passed GET parameter transactionId with newly created transaction ID.',
  `paymentURL` VARCHAR(1000) DEFAULT NULL,
  PRIMARY KEY (id, orderId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'OBSOLETE. For old balance system';