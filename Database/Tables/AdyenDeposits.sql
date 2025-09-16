CREATE TABLE `AdyenDeposits` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(36) NOT NULL,
  `time` INT(10) UNSIGNED NOT NULL,
  `userId` INT(11) NOT NULL,
  `currencyISO` VARCHAR(3) NOT NULL,
  `adyenTransferId` VARCHAR(25) DEFAULT NULL,
  `paymentPspReference` VARCHAR(25) DEFAULT NULL,
  `amount` DECIMAL(8, 2) NOT NULL,
  `feeAmount` DECIMAL(8, 2) NOT NULL,
  `adyenPaymentSessionRequestData` LONGTEXT DEFAULT NULL COMMENT '(DC2Type:json)',
  `adyenPaymentSessionData` LONGTEXT DEFAULT NULL COMMENT '(DC2Type:json)',
  `appliedFraudScoreSettings` LONGTEXT DEFAULT NULL COMMENT '(DC2Type:json)',
  `fraudScoreOffset` INT(11) NOT NULL DEFAULT 0,
  `status` INT(11) NOT NULL,
  `AdyenBalanceAccountLocalId` INT(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci;

ALTER TABLE `AdyenDeposits` 
  ADD UNIQUE INDEX UNIQ_BAF1810ED17F50A6(uuid);

ALTER TABLE `AdyenDeposits` 
  ADD UNIQUE INDEX UNIQ_BAF1810E341A00E8(adyenTransferId);

ALTER TABLE `AdyenDeposits` 
  ADD UNIQUE INDEX UNIQ_BAF1810EB44D9033(paymentPspReference);

ALTER TABLE `AdyenDeposits` 
  ADD INDEX IDX_BAF1810E45C8E441(AdyenBalanceAccountLocalId);

ALTER TABLE `AdyenDeposits` 
  ADD INDEX search_user(userId);

ALTER TABLE `AdyenDeposits` 
  ADD CONSTRAINT `FK_BAF1810E45C8E441` FOREIGN KEY (AdyenBalanceAccountLocalId)
    REFERENCES Adyen_BalanceAccounts(id);