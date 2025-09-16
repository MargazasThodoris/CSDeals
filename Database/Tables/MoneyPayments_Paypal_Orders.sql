CREATE TABLE `MoneyPayments_Paypal_Orders` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `orderId` INT(11) NOT NULL,
  `orderCreationRequestContent` TEXT DEFAULT NULL,
  `orderCreationResponseContent` TEXT DEFAULT NULL,
  `checkoutIPAddress` VARCHAR(68) DEFAULT NULL,
  `checkoutCountry` CHAR(2) DEFAULT NULL,
  `paymentURL` VARCHAR(1000) DEFAULT NULL,
  `paypalOrderId` VARCHAR(1000) DEFAULT NULL COMMENT 'Returned from paypal when creating the order to redirect the user',
  `paymentId` VARCHAR(1000) DEFAULT NULL COMMENT 'Passed to return url on approved payment',
  `voidedReason` VARCHAR(255) DEFAULT NULL COMMENT 'reason why the order was voided',
  `token` VARCHAR(1000) DEFAULT NULL COMMENT 'Passed to return url on approved payment',
  `PayerID` VARCHAR(1000) DEFAULT NULL COMMENT 'Passed to return url on approved payment',
  `userIsVerified` TINYINT(255) DEFAULT 0,
  `currentTotalDailyDepositLimit` DECIMAL(6, 2) DEFAULT NULL,
  `currentTotalWeeklyDepositLimit` DECIMAL(6, 2) DEFAULT NULL,
  `paypalOrderDetailsJSON` TEXT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'After the payment has been approved, we will fetch the order from paypal to get the buyer''s personal details and email',
  `paypalOrderCaptureJSON` TEXT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'After the payment has been captured by us.',
  PRIMARY KEY (id, orderId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'OBSOLETE. For old balance system';

ALTER TABLE `MoneyPayments_Paypal_Orders` 
  ADD UNIQUE INDEX orderId(orderId);

ALTER TABLE `MoneyPayments_Paypal_Orders` 
  ADD INDEX payerID(PayerID);

ALTER TABLE `MoneyPayments_Paypal_Orders` 
  ADD INDEX paypalOrderId(paypalOrderId);

ALTER TABLE `MoneyPayments_Paypal_Orders` 
  ADD INDEX IP(checkoutIPAddress);