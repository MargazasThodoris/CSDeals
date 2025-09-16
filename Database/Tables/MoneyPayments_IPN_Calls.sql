CREATE TABLE `MoneyPayments_IPN_Calls` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `orderId` INT(11) NOT NULL,
  `uniqueTransactionId` VARCHAR(100) DEFAULT NULL COMMENT 'Use this to make sure it doesn''t get handled twice. Used for Paypal',
  `oldOrderStatus` INT(255) DEFAULT NULL,
  `newOrderStatus` INT(255) DEFAULT NULL,
  `providerId` INT(11) NOT NULL,
  `IPstr` VARCHAR(45) DEFAULT NULL,
  `time` INT(11) NOT NULL,
  `requestHeadersJSON` TEXT DEFAULT NULL,
  `rawContent` TEXT DEFAULT NULL,
  `invalidOrderId` TINYINT(255) DEFAULT 0,
  `authenticationFailed` TINYINT(255) DEFAULT 0,
  `failReason` VARCHAR(2048) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `isFailed` TINYINT(255) GENERATED ALWAYS AS (if(`failReason` is null,0,1)) STORED,
  PRIMARY KEY (id, orderId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'OBSOLETE. For old balance system';

ALTER TABLE `MoneyPayments_IPN_Calls` 
  ADD INDEX uniqTransaction(uniqueTransactionId, providerId);

ALTER TABLE `MoneyPayments_IPN_Calls` 
  ADD INDEX orderId(orderId);