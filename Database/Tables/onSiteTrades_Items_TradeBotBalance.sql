CREATE TABLE `onSiteTrades_Items_TradeBotBalance` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `onSiteTradeId` INT(10) UNSIGNED NOT NULL COMMENT '->onSiteTrades_Trades.id',
  `isSendersItem` TINYINT(11) NOT NULL COMMENT 'Flag 1/0. If 1, the trade-tokens are given to the recipient of the trade, otherwise vice-versa',
  `amount` DECIMAL(10, 4) NOT NULL,
  `payToUserId` INT(10) UNSIGNED DEFAULT NULL COMMENT '->users.id;
If the trade is sent from the website, this can be set so that this amount will be paid to some other user than the recipient. Used for User Sales.',
  `deductedTransactionId` INT(10) UNSIGNED DEFAULT NULL COMMENT '->userbalancetransactions.id',
  `refundedTransactionId` INT(4) UNSIGNED DEFAULT NULL COMMENT '->userbalancetransactions.id',
  `recipientTransactionId` INT(10) UNSIGNED DEFAULT NULL COMMENT '->userbalancetransactions.id',
  `creditAtTime` INT(10) UNSIGNED DEFAULT NULL COMMENT 'if set, the payment will be paid after this timestamp',
  `isCompleted` TINYINT(255) GENERATED ALWAYS AS (if(`refundedTransactionId` <> 0 or `recipientTransactionId` <> 0,1,0)) STORED,
  `tradeAccepted` TINYINT(255) DEFAULT 0 COMMENT 'We use this to find accepted trades with delayed payments',
  PRIMARY KEY (id, onSiteTradeId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Trade-token balance included in on-site trades.';

ALTER TABLE `onSiteTrades_Items_TradeBotBalance` 
  ADD INDEX quickSearch(onSiteTradeId, isSendersItem);

ALTER TABLE `onSiteTrades_Items_TradeBotBalance` 
  ADD INDEX findAccepted(tradeAccepted);

ALTER TABLE `onSiteTrades_Items_TradeBotBalance` 
  ADD CONSTRAINT `onSiteTrades_Items_TradeBotBalance_deductedTransactionId` FOREIGN KEY (deductedTransactionId)
    REFERENCES userbalancetransactions(id);

ALTER TABLE `onSiteTrades_Items_TradeBotBalance` 
  ADD CONSTRAINT `onSiteTrades_Items_TradeBotBalance_onSiteTradeId` FOREIGN KEY (onSiteTradeId)
    REFERENCES onSiteTrades_Trades(id);

ALTER TABLE `onSiteTrades_Items_TradeBotBalance` 
  ADD CONSTRAINT `onSiteTrades_Items_TradeBotBalance_payToUserId` FOREIGN KEY (payToUserId)
    REFERENCES users(id);

ALTER TABLE `onSiteTrades_Items_TradeBotBalance` 
  ADD CONSTRAINT `onSiteTrades_Items_TradeBotBalance_recipientTransactionId` FOREIGN KEY (recipientTransactionId)
    REFERENCES userbalancetransactions(id);

ALTER TABLE `onSiteTrades_Items_TradeBotBalance` 
  ADD CONSTRAINT `onSiteTrades_Items_TradeBotBalance_refundedTransactionId` FOREIGN KEY (refundedTransactionId)
    REFERENCES userbalancetransactions(id);