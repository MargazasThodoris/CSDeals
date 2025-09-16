CREATE TABLE `onSiteTrades_Items_balanceBTC` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `onSiteTradeId` INT(10) UNSIGNED NOT NULL COMMENT '->onSiteTrades_Trades.id',
  `onSiteTradeItemId` BIGINT(255) UNSIGNED DEFAULT NULL COMMENT '->onSiteTrades_Items.id;
If this BTC transfer is connected to a specific onSiteTradeItem, credit it only after the item has been transferred. Used in Adyen wallet purchases where items are put in escrow and transferred one-by-one',
  `userSaleId` INT(11) UNSIGNED DEFAULT NULL COMMENT '->userSales_ListedItemsHistory.id',
  `itemTransferId` INT(255) UNSIGNED DEFAULT NULL COMMENT '->onSiteInventories_ItemTransactionHistory.id',
  `isSendersItem` TINYINT(11) NOT NULL,
  `amount` DECIMAL(12, 8) NOT NULL,
  `payToUserId` INT(255) UNSIGNED DEFAULT NULL COMMENT '->users.id;
If the trade is sent from the website, this can be set so that this amount will be paid to some other user than the recipient. Used for User Sales.',
  `deductedTransactionId` INT(10) UNSIGNED DEFAULT NULL COMMENT '->Users_BalanceTransactions_BTC.id; If not set, this transfer is paid by the system. Multiple rows may have the same ID as they are all deducted at once from the buyer',
  `refundedTransactionId` INT(4) UNSIGNED DEFAULT NULL COMMENT '->Users_BalanceTransactions_BTC.id',
  `recipientTransactionId` INT(10) UNSIGNED DEFAULT NULL COMMENT '->Users_BalanceTransactions_BTC.id',
  PRIMARY KEY (id, onSiteTradeId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'BTC balance included in on-site trades.';

ALTER TABLE `onSiteTrades_Items_balanceBTC` 
  ADD INDEX quickSearch(onSiteTradeId, isSendersItem);

ALTER TABLE `onSiteTrades_Items_balanceBTC` 
  ADD INDEX onSiteTrades_Items_TradeBotBalance_deductedTransactionId(deductedTransactionId);

ALTER TABLE `onSiteTrades_Items_balanceBTC` 
  ADD INDEX onSiteTrades_Items_TradeBotBalance_refundedTransactionId(refundedTransactionId);

ALTER TABLE `onSiteTrades_Items_balanceBTC` 
  ADD INDEX onSiteTrades_Items_TradeBotBalance_recipientTransactionId(recipientTransactionId);

ALTER TABLE `onSiteTrades_Items_balanceBTC` 
  ADD INDEX onSiteTrades_Items_MoneyBalance_payToUserId(payToUserId);

ALTER TABLE `onSiteTrades_Items_balanceBTC` 
  ADD CONSTRAINT `onSiteTrades_Items_balanceBTC_ibfk_1` FOREIGN KEY (payToUserId)
    REFERENCES users(id);

ALTER TABLE `onSiteTrades_Items_balanceBTC` 
  ADD CONSTRAINT `onSiteTrades_Items_balanceBTC_ibfk_2` FOREIGN KEY (deductedTransactionId)
    REFERENCES Users_BalanceTransactions_BTC(id);

ALTER TABLE `onSiteTrades_Items_balanceBTC` 
  ADD CONSTRAINT `onSiteTrades_Items_balanceBTC_ibfk_3` FOREIGN KEY (recipientTransactionId)
    REFERENCES Users_BalanceTransactions_BTC(id);

ALTER TABLE `onSiteTrades_Items_balanceBTC` 
  ADD CONSTRAINT `onSiteTrades_Items_balanceBTC_ibfk_4` FOREIGN KEY (refundedTransactionId)
    REFERENCES Users_BalanceTransactions_BTC(id);

ALTER TABLE `onSiteTrades_Items_balanceBTC` 
  ADD CONSTRAINT `onSiteTrades_Items_balanceBTC_itemTransferId` FOREIGN KEY (itemTransferId)
    REFERENCES onSiteInventories_ItemTransactionHistory(id);

ALTER TABLE `onSiteTrades_Items_balanceBTC` 
  ADD CONSTRAINT `onSiteTrades_Items_balanceBTC_onSiteTradeId` FOREIGN KEY (onSiteTradeId)
    REFERENCES onSiteTrades_Trades(id);

ALTER TABLE `onSiteTrades_Items_balanceBTC` 
  ADD CONSTRAINT `onSiteTrades_Items_balanceBTC_onSiteTradeItemId` FOREIGN KEY (onSiteTradeItemId)
    REFERENCES onSiteTrades_Items(id);

ALTER TABLE `onSiteTrades_Items_balanceBTC` 
  ADD CONSTRAINT `onSiteTrades_Items_balanceBTC_userSaleId` FOREIGN KEY (userSaleId)
    REFERENCES userSales_ListedItemsHistory(id);