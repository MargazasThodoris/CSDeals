CREATE TABLE `onSiteTrades_Adyen_Orders_Transfers` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `onSiteTradeid` INT(11) NOT NULL,
  `onSiteTradeItemId` INT(11) DEFAULT NULL,
  `userSaleId` INT(11) DEFAULT NULL,
  `itemTransferId` INT(11) DEFAULT NULL,
  `type` INT(11) NOT NULL,
  `status` INT(255) NOT NULL,
  `isFromSystemBalanceAccount` TINYINT(1) NOT NULL,
  `isToSystemBalanceAccount` TINYINT(1) NOT NULL,
  `value` INT(11) NOT NULL,
  `targetCurrencyValue` INT(11) NOT NULL,
  `sourceCurrencyISO` VARCHAR(3) NOT NULL,
  `targetCurrencyISO` VARCHAR(3) NOT NULL,
  `sourceAdyenBalanceAccountId` VARCHAR(25) NOT NULL,
  `targetAdyenBalanceAccountId` VARCHAR(25) NOT NULL,
  `adyenTransferId` VARCHAR(25) DEFAULT NULL,
  `requestJSON` LONGTEXT DEFAULT NULL COMMENT 'Response of the API request when making the transfer(DC2Type:json)',
  `responseJSON` LONGTEXT DEFAULT NULL COMMENT 'Response of the API request when making the transfer(DC2Type:json)',
  `adyenReversionTransferId` VARCHAR(25) DEFAULT NULL,
  `reversionRequestJSON` LONGTEXT DEFAULT NULL COMMENT 'Response of the API request when making the transfer(DC2Type:json)',
  `reversionResponseJSON` LONGTEXT DEFAULT NULL COMMENT 'Response of the API request when making the transfer(DC2Type:json)',
  `adyenFromBalanceAccountLocalId` INT(11) DEFAULT NULL,
  `adyenToBalanceAccountLocalId` INT(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci;

ALTER TABLE `onSiteTrades_Adyen_Orders_Transfers` 
  ADD UNIQUE INDEX UNIQ_D6CB595E341A00E8(adyenTransferId);

ALTER TABLE `onSiteTrades_Adyen_Orders_Transfers` 
  ADD INDEX IDX_D6CB595EF957C203(adyenFromBalanceAccountLocalId);

ALTER TABLE `onSiteTrades_Adyen_Orders_Transfers` 
  ADD INDEX IDX_D6CB595E5BB0B86C(adyenToBalanceAccountLocalId);

ALTER TABLE `onSiteTrades_Adyen_Orders_Transfers` 
  ADD INDEX saleItem(onSiteTradeid, userSaleId);

ALTER TABLE `onSiteTrades_Adyen_Orders_Transfers` 
  ADD CONSTRAINT `FK_BFA841DE5BB0B86C` FOREIGN KEY (adyenToBalanceAccountLocalId)
    REFERENCES Adyen_BalanceAccounts(id);

ALTER TABLE `onSiteTrades_Adyen_Orders_Transfers` 
  ADD CONSTRAINT `FK_BFA841DEF957C203` FOREIGN KEY (adyenFromBalanceAccountLocalId)
    REFERENCES Adyen_BalanceAccounts(id);