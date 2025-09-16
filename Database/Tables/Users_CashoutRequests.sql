CREATE TABLE `Users_CashoutRequests` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `UUID` CHAR(64) NOT NULL,
  `userId` INT(255) UNSIGNED NOT NULL,
  `method` SMALLINT(255) NOT NULL COMMENT '0=bitcoin',
  `amountUsd` DECIMAL(12, 4) NOT NULL COMMENT 'amount we deduct from usd balance',
  `feeAmountUsd` DECIMAL(12, 4) NOT NULL COMMENT 'amount we deduct from usd balance',
  `toPayAmountUsd` DECIMAL(12, 4) NOT NULL DEFAULT 0.0000,
  `toPayAmountEur` DECIMAL(12, 4) NOT NULL DEFAULT 0.0000,
  `status` SMALLINT(255) NOT NULL DEFAULT 0 COMMENT '0=in queue, 1=canceled, 2=processing, 3=processed',
  `time` INT(10) UNSIGNED NOT NULL,
  `statusChangeTime` INT(11) DEFAULT NULL,
  `reservedTransactionId` INT(10) UNSIGNED DEFAULT NULL,
  `returnedTransactionId` INT(255) UNSIGNED DEFAULT NULL,
  `reservedFeeTransactionId` INT(255) UNSIGNED DEFAULT NULL,
  `returnedFeeTransactionId` INT(255) UNSIGNED DEFAULT NULL,
  `sentBitcoinTxId` INT(255) DEFAULT NULL,
  `detailsJSON` TEXT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `failedUserReason` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `failedAdminReason` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (id, UUID, userId),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'OBSOLETE: old balance system';

ALTER TABLE `Users_CashoutRequests` 
  ADD INDEX stateMethod(status, method);

ALTER TABLE `Users_CashoutRequests` 
  ADD INDEX userId(userId);

ALTER TABLE `Users_CashoutRequests` 
  ADD INDEX UUID(UUID);

ALTER TABLE `Users_CashoutRequests` 
  ADD CONSTRAINT `cashout_reservedFeeTransactionId` FOREIGN KEY (reservedFeeTransactionId)
    REFERENCES userbalancetransactions(id);

ALTER TABLE `Users_CashoutRequests` 
  ADD CONSTRAINT `cashout_reservedTransactionId` FOREIGN KEY (reservedTransactionId)
    REFERENCES userbalancetransactions(id);