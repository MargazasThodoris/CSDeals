CREATE TABLE `onSiteTrades_Items_TSFBalance` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `onSiteTradeId` INT(10) UNSIGNED NOT NULL,
  `isSendersItem` TINYINT(11) NOT NULL,
  `amount` DECIMAL(10, 4) NOT NULL,
  `payToUserId` INT(10) UNSIGNED DEFAULT NULL COMMENT 'If the trade is sent from the website, this can be set so that this amount will be paid to some other user than the recipient. Used for User Sales.',
  `deductedTransactionId` INT(10) UNSIGNED DEFAULT NULL COMMENT 'id in userbalancetransactions',
  `refundedTransactionId` INT(4) UNSIGNED DEFAULT NULL COMMENT 'id in userbalancetransactions',
  `recipientTransactionId` INT(10) UNSIGNED DEFAULT NULL,
  `creditAtTime` INT(10) UNSIGNED DEFAULT NULL COMMENT 'if set, the payment will be paid after this timestamp',
  `isCompleted` TINYINT(255) GENERATED ALWAYS AS (if(`refundedTransactionId` <> 0 or `recipientTransactionId` <> 0,1,0)) STORED,
  `tradeAccepted` TINYINT(255) DEFAULT 0 COMMENT 'We use this to find accepted trades with delayed payments',
  PRIMARY KEY (id, onSiteTradeId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'OBSOLETE: TSF is no longer active. Retained for possible future use or reference.';

ALTER TABLE `onSiteTrades_Items_TSFBalance` 
  ADD INDEX quickSearch(onSiteTradeId, isSendersItem);

ALTER TABLE `onSiteTrades_Items_TSFBalance` 
  ADD INDEX onSiteTrades_Items_TradeBotBalance_deductedTransactionId(deductedTransactionId);

ALTER TABLE `onSiteTrades_Items_TSFBalance` 
  ADD INDEX onSiteTrades_Items_TradeBotBalance_refundedTransactionId(refundedTransactionId);

ALTER TABLE `onSiteTrades_Items_TSFBalance` 
  ADD INDEX onSiteTrades_Items_TradeBotBalance_recipientTransactionId(recipientTransactionId);

ALTER TABLE `onSiteTrades_Items_TSFBalance` 
  ADD INDEX findAccepted(tradeAccepted);

ALTER TABLE `onSiteTrades_Items_TSFBalance` 
  ADD INDEX onSiteTrades_Items_TradeBotBalance_payToUserId(payToUserId);

ALTER TABLE `onSiteTrades_Items_TSFBalance` 
  ADD CONSTRAINT `onSiteTrades_Items_TSFBalance_ibfk_1` FOREIGN KEY (deductedTransactionId)
    REFERENCES userbalancetransactions(id);

ALTER TABLE `onSiteTrades_Items_TSFBalance` 
  ADD CONSTRAINT `onSiteTrades_Items_TSFBalance_ibfk_2` FOREIGN KEY (payToUserId)
    REFERENCES users(id);

ALTER TABLE `onSiteTrades_Items_TSFBalance` 
  ADD CONSTRAINT `onSiteTrades_Items_TSFBalance_ibfk_3` FOREIGN KEY (recipientTransactionId)
    REFERENCES userbalancetransactions(id);

ALTER TABLE `onSiteTrades_Items_TSFBalance` 
  ADD CONSTRAINT `onSiteTrades_Items_TSFBalance_ibfk_4` FOREIGN KEY (refundedTransactionId)
    REFERENCES userbalancetransactions(id);