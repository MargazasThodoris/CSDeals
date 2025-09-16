CREATE TABLE `userbalancetransactions` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` INT(10) UNSIGNED NOT NULL COMMENT '->users.id',
  `source` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'Source/reason for the transaction. Refer to the source code documentation for source constants',
  `tradeid` INT(11) DEFAULT NULL COMMENT 'if eligible. When source is 0, this is the id in tradeoffers. When source is 2, this is the ID in offerwallcallbacks ',
  `userSaleId` INT(255) UNSIGNED DEFAULT NULL COMMENT '->userSales_ListedItemsHistory.id',
  `userSaleAmount` INT(255) UNSIGNED DEFAULT NULL COMMENT 'Quantity of items sold from the on-site item stack',
  `BTCTxId` INT(255) UNSIGNED DEFAULT NULL COMMENT 'set for underpays, overpays, mispays and deposits',
  `BTCInvoiceId` INT(255) UNSIGNED DEFAULT NULL COMMENT 'when an invoice is paid this is set',
  `moneyDepositOrderId` INT(255) UNSIGNED DEFAULT NULL COMMENT '->MoneyPayments_Orders.id; OBSOLETE. Replaced by Adyen and BTC system',
  `currency` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'Refer to source code documentation for constants',
  `amount` DECIMAL(10, 4) NOT NULL DEFAULT 0.0000 COMMENT 'How much of this currency was added or deducted',
  `balanceafter` DECIMAL(10, 4) DEFAULT 0.0000 COMMENT 'How much balance the user has after the event',
  `revertedById` INT(11) UNSIGNED DEFAULT NULL COMMENT 'if this transaction has been reverted with another transaction, this is the ID of that row. Used so we don''t reverse a transaction multiple times',
  `isfinal` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'if this row was a revert from another transaction, this is 1',
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'UNIX timestamp of this entry',
  `timestamp` TIMESTAMP NOT NULL DEFAULT current_timestamp() COMMENT 'Timestamp of this entry',
  `reason` VARCHAR(256) DEFAULT NULL,
  PRIMARY KEY (id, userid, source),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'History of all transactions in Trade-tokens, old USD balance and TSF balance for all users. Every transaction must be logged here for consistency.';

ALTER TABLE `userbalancetransactions` 
  ADD INDEX currency(currency);

ALTER TABLE `userbalancetransactions` 
  ADD INDEX userid(userid);

ALTER TABLE `userbalancetransactions` 
  ADD INDEX tradeid(tradeid);

ALTER TABLE `userbalancetransactions` 
  ADD INDEX source(source);

ALTER TABLE `userbalancetransactions` 
  ADD CONSTRAINT `balanceTxToBTCInvoice` FOREIGN KEY (BTCInvoiceId)
    REFERENCES Crypto_BTC_Invoices(id);

ALTER TABLE `userbalancetransactions` 
  ADD CONSTRAINT `balanceTxToIncomingBtcTx` FOREIGN KEY (BTCTxId)
    REFERENCES Crypto_BTC_IncomingTransactions_OLD(id);

ALTER TABLE `userbalancetransactions` 
  ADD CONSTRAINT `balanceTxToOrder` FOREIGN KEY (moneyDepositOrderId)
    REFERENCES MoneyPayments_Orders(id);

ALTER TABLE `userbalancetransactions` 
  ADD CONSTRAINT `balanceTxToUserSale` FOREIGN KEY (userSaleId)
    REFERENCES userSales_ListedItemsHistory(id);