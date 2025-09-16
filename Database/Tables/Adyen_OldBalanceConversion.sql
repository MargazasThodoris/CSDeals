CREATE TABLE `Adyen_OldBalanceConversion` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `userId` INT(11) NOT NULL,
  `usdAmountDeducted` DECIMAL(12, 4) DEFAULT NULL,
  `userBalanceDeductedTransactionId` INT(11) DEFAULT NULL,
  `euroAmountToSend` DECIMAL(10, 2) NOT NULL,
  `usdEuroRate` DECIMAL(6, 4) NOT NULL,
  `liableAccountPreviousBalance` DECIMAL(10, 2) DEFAULT NULL,
  `adyenTransferId` VARCHAR(25) DEFAULT NULL,
  `requestJSON` LONGTEXT NOT NULL COMMENT 'Response of the API request when making the transfer(DC2Type:json)',
  `responseJSON` LONGTEXT DEFAULT NULL COMMENT 'Response of the API request when making the transfer(DC2Type:json)',
  `success` TINYINT(1) NOT NULL,
  `adyenBalanceAccountLocalId` INT(11) DEFAULT NULL,
  `adyenAccountHolderLocalId` INT(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci;

ALTER TABLE `Adyen_OldBalanceConversion` 
  ADD UNIQUE INDEX UNIQ_D3B8B1A2341A00E8(adyenTransferId);

ALTER TABLE `Adyen_OldBalanceConversion` 
  ADD INDEX IDX_D3B8B1A2CA1D54F0(adyenBalanceAccountLocalId);

ALTER TABLE `Adyen_OldBalanceConversion` 
  ADD INDEX IDX_D3B8B1A2C11F2FE8(adyenAccountHolderLocalId);

ALTER TABLE `Adyen_OldBalanceConversion` 
  ADD CONSTRAINT `FK_D3B8B1A2C11F2FE8` FOREIGN KEY (adyenAccountHolderLocalId)
    REFERENCES Adyen_AccountHolders(id);

ALTER TABLE `Adyen_OldBalanceConversion` 
  ADD CONSTRAINT `FK_D3B8B1A2CA1D54F0` FOREIGN KEY (adyenBalanceAccountLocalId)
    REFERENCES Adyen_BalanceAccounts(id);