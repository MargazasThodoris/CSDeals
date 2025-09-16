CREATE TABLE `Adyen_BalanceAccounts` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `defaultCurrencyISO` VARCHAR(3) NOT NULL,
  `adyenBalanceAccountId` VARCHAR(25) NOT NULL,
  `balance` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  `balanceAvailable` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  `balanceReserved` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  `balanceAccountType` INT(11) NOT NULL DEFAULT 0,
  `json` LONGTEXT NOT NULL COMMENT '(DC2Type:json)',
  `adyenAccountHolderLocalId` INT(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci;

ALTER TABLE `Adyen_BalanceAccounts` 
  ADD UNIQUE INDEX UNIQ_706F657E5588FA0F(adyenBalanceAccountId);

ALTER TABLE `Adyen_BalanceAccounts` 
  ADD INDEX IDX_706F657EC11F2FE8(adyenAccountHolderLocalId);