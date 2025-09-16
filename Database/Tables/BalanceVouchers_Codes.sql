CREATE TABLE `BalanceVouchers_Codes` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `buyerUserId` INT(10) UNSIGNED DEFAULT NULL,
  `time` INT(255) UNSIGNED NOT NULL,
  `amountUsd` DECIMAL(10, 4) UNSIGNED NOT NULL,
  `deductedBalanceTxId` INT(10) UNSIGNED DEFAULT NULL,
  `voucherCode` CHAR(14) NOT NULL,
  `consumerUserId` INT(10) UNSIGNED DEFAULT NULL,
  `consumerBalanceTxId` INT(10) UNSIGNED DEFAULT NULL,
  `platformId` INT(11) DEFAULT NULL COMMENT 'If set, this code is generated to be distributed on this order platform id',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Redeemable balance codes for the old balance system. No longer used, as the balance system was replaced by Adyen.';

ALTER TABLE `BalanceVouchers_Codes` 
  ADD UNIQUE INDEX `unique`(voucherCode);

ALTER TABLE `BalanceVouchers_Codes` 
  ADD INDEX buyerUserIdUsed(buyerUserId, consumerBalanceTxId);

ALTER TABLE `BalanceVouchers_Codes` 
  ADD INDEX unusedPlatformCodes(platformId, consumerUserId);

ALTER TABLE `BalanceVouchers_Codes` 
  ADD CONSTRAINT `buyerUserId` FOREIGN KEY (buyerUserId)
    REFERENCES users(id);

ALTER TABLE `BalanceVouchers_Codes` 
  ADD CONSTRAINT `consumerTx` FOREIGN KEY (consumerBalanceTxId)
    REFERENCES userbalancetransactions(id);

ALTER TABLE `BalanceVouchers_Codes` 
  ADD CONSTRAINT `deductedId` FOREIGN KEY (deductedBalanceTxId)
    REFERENCES userbalancetransactions(id);