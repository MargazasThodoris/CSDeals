CREATE TABLE `MoneyPayments_Binance_Orders` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `orderId` INT(11) UNSIGNED NOT NULL,
  `orderCreationRequestContent` TEXT BINARY CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `orderCreationResponseContent` TEXT BINARY CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `prepayId` VARCHAR(0) DEFAULT NULL,
  `expireTime` BIGINT(20) UNSIGNED DEFAULT NULL,
  `transactionId` VARCHAR(64) DEFAULT NULL COMMENT 'Received from IPN',
  `commission` DECIMAL(14, 8) DEFAULT NULL COMMENT 'Received from IPN',
  `openUserId` CHAR(32) DEFAULT NULL,
  PRIMARY KEY (id, orderId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'OBSOLETE. For old balance system';

ALTER TABLE `MoneyPayments_Binance_Orders` 
  ADD UNIQUE INDEX binanceOrderId(orderId);

ALTER TABLE `MoneyPayments_Binance_Orders` 
  ADD CONSTRAINT `binanceOrderId2` FOREIGN KEY (orderId)
    REFERENCES MoneyPayments_Orders(id);