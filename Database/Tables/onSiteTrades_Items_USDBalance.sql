CREATE TABLE `onSiteTrades_Items_USDBalance` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `onSiteTradeId` INT(10) UNSIGNED NOT NULL,
  `isSendersItem` TINYINT(11) NOT NULL,
  `amount` DECIMAL(10, 4) NOT NULL,
  `payToUserId` INT(255) UNSIGNED DEFAULT NULL COMMENT 'If the trade is sent from the website, this can be set so that this amount will be paid to some other user than the recipient. Used for User Sales.',
  `deductedTransactionId` INT(10) UNSIGNED DEFAULT NULL COMMENT 'id in userbalancetransactions',
  `refundedTransactionId` INT(4) UNSIGNED DEFAULT NULL COMMENT 'id in userbalancetransactions',
  `recipientTransactionId` INT(10) UNSIGNED DEFAULT NULL,
  `isCompleted` TINYINT(255) GENERATED ALWAYS AS (if(`refundedTransactionId` <> 0 or `recipientTransactionId` <> 0,1,0)) STORED,
  PRIMARY KEY (id, onSiteTradeId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'OBSOLETE: Uses old balance system';

ALTER TABLE `onSiteTrades_Items_USDBalance` 
  ADD INDEX quickSearch(onSiteTradeId, isSendersItem);

ALTER TABLE `onSiteTrades_Items_USDBalance` 
  ADD INDEX onSiteTrades_Items_TradeBotBalance_deductedTransactionId(deductedTransactionId);

ALTER TABLE `onSiteTrades_Items_USDBalance` 
  ADD INDEX onSiteTrades_Items_TradeBotBalance_refundedTransactionId(refundedTransactionId);

ALTER TABLE `onSiteTrades_Items_USDBalance` 
  ADD INDEX onSiteTrades_Items_TradeBotBalance_recipientTransactionId(recipientTransactionId);

ALTER TABLE `onSiteTrades_Items_USDBalance` 
  ADD CONSTRAINT `onSiteTrades_Items_MoneyBalance_payToUserId` FOREIGN KEY (payToUserId)
    REFERENCES users(id);

ALTER TABLE `onSiteTrades_Items_USDBalance` 
  ADD CONSTRAINT `onSiteTrades_Items_USDBalance_ibfk_1` FOREIGN KEY (deductedTransactionId)
    REFERENCES userbalancetransactions(id);

ALTER TABLE `onSiteTrades_Items_USDBalance` 
  ADD CONSTRAINT `onSiteTrades_Items_USDBalance_ibfk_2` FOREIGN KEY (recipientTransactionId)
    REFERENCES userbalancetransactions(id);

ALTER TABLE `onSiteTrades_Items_USDBalance` 
  ADD CONSTRAINT `onSiteTrades_Items_USDBalance_ibfk_3` FOREIGN KEY (refundedTransactionId)
    REFERENCES userbalancetransactions(id);