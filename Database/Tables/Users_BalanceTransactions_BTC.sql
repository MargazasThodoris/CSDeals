CREATE TABLE `Users_BalanceTransactions_BTC` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` INT(10) UNSIGNED NOT NULL COMMENT '->users.id',
  `source` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'balanceSource_OldTrade = 0,
balanceSource_Giveaway = 1,
balanceSource_OfferWall = 2,
balanceSource_Admin = 3,
balanceSource_OfferWallWithheld = 4,
balanceSource_SellCards = 5,
balanceSource_Trade = 6;
balanceSource_UserSale = 7;',
  `userSaleId` INT(255) UNSIGNED DEFAULT NULL,
  `userSaleAmount` INT(255) UNSIGNED DEFAULT NULL,
  `sentBTCTxId` INT(255) UNSIGNED DEFAULT NULL,
  `incomingBTCTxId` INT(11) DEFAULT NULL,
  `amount` DECIMAL(12, 8) NOT NULL DEFAULT 0.00000000 COMMENT 'how much was added or deducted',
  `balanceafter` DECIMAL(12, 8) NOT NULL DEFAULT 0.00000000,
  `bitcoinPrice` DECIMAL(10, 2) NOT NULL,
  `time` INT(10) UNSIGNED NOT NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  `reason` VARCHAR(256) DEFAULT NULL,
  PRIMARY KEY (id, userid, source),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Same as table userbalancetransactions, but strictly for Bitcoin balance transactions, which are not included in userbalancetransactions.
Check table userbalancetransactions for more.';

ALTER TABLE `Users_BalanceTransactions_BTC` 
  ADD INDEX userid(userid);

ALTER TABLE `Users_BalanceTransactions_BTC` 
  ADD INDEX source(source);

ALTER TABLE `Users_BalanceTransactions_BTC` 
  ADD INDEX balanceTxToUserSale(userSaleId);

ALTER TABLE `Users_BalanceTransactions_BTC` 
  ADD INDEX balanceTxToIncomingBtcTx(sentBTCTxId);

ALTER TABLE `Users_BalanceTransactions_BTC` 
  ADD CONSTRAINT `Users_BalanceTransactions_BTC_ibfk_4` FOREIGN KEY (userSaleId)
    REFERENCES userSales_ListedItemsHistory(id);

ALTER TABLE `Users_BalanceTransactions_BTC` 
  ADD CONSTRAINT `Users_BalanceTransactions_BTC_ibfk_5` FOREIGN KEY (sentBTCTxId)
    REFERENCES Crypto_BTC_Sends_New(id);