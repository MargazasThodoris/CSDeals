CREATE TABLE `onSiteTrades_Items_Balance_AdditionalUsers` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `onSiteTradeId` INT(10) UNSIGNED NOT NULL,
  `currency` TINYINT(255) NOT NULL COMMENT '0=trade bot balance, 1=real money',
  `amount` DECIMAL(10, 4) NOT NULL,
  `payToUserId` INT(10) UNSIGNED NOT NULL,
  `userSaleHistoryId` INT(10) UNSIGNED DEFAULT NULL,
  `recipientTransactionId` INT(10) UNSIGNED DEFAULT NULL,
  `isAffiliateCommission` TINYINT(255) DEFAULT 0 COMMENT 'If this is commission paid from a sale to an affiliate',
  `isCompleted` TINYINT(255) GENERATED ALWAYS AS (if(`recipientTransactionId` <> 0,1,0)) STORED,
  PRIMARY KEY (id, onSiteTradeId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'OBSOLETE: Crediting these is no longer supported in code';

ALTER TABLE `onSiteTrades_Items_Balance_AdditionalUsers` 
  ADD CONSTRAINT `onSiteTrades_Items_Balance_AdditionalUsers_OnSiteTradeId` FOREIGN KEY (onSiteTradeId)
    REFERENCES onSiteTrades_Trades(id);

ALTER TABLE `onSiteTrades_Items_Balance_AdditionalUsers` 
  ADD CONSTRAINT `onSiteTrades_Items_Balance_AdditionalUsers_PayToUserId` FOREIGN KEY (payToUserId)
    REFERENCES users(id);

ALTER TABLE `onSiteTrades_Items_Balance_AdditionalUsers` 
  ADD CONSTRAINT `onSiteTrades_Items_Balance_AdditionalUsers_UserSaleHistoryId` FOREIGN KEY (userSaleHistoryId)
    REFERENCES userSales_ListedItemsHistory(id);