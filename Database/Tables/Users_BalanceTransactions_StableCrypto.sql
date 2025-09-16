CREATE TABLE `Users_BalanceTransactions_StableCrypto` (
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
  `BTCbalanceTransactionId` INT(11) DEFAULT NULL,
  `correspondingAmountBTC` DECIMAL(12, 8) NOT NULL DEFAULT 0.00000000 COMMENT 'how much was added or deducted',
  `amountUSD` VARCHAR(255) DEFAULT NULL,
  `balanceafter` DECIMAL(14, 4) NOT NULL DEFAULT 0.0000,
  `bitcoinPrice` DECIMAL(10, 2) NOT NULL,
  `time` INT(10) UNSIGNED NOT NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  `reason` VARCHAR(256) DEFAULT NULL,
  PRIMARY KEY (id, userid, source),
  UNIQUE INDEX UK_Users_BalanceTransactions_StableCrypto_id(id),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'All transactions in this table are conversions from/to BTC balance (Users_BalanceTransactions_BTC)';

ALTER TABLE `Users_BalanceTransactions_StableCrypto` 
  ADD UNIQUE INDEX BTCbalanceTransactionId(BTCbalanceTransactionId);

ALTER TABLE `Users_BalanceTransactions_StableCrypto` 
  ADD INDEX userid(userid);

ALTER TABLE `Users_BalanceTransactions_StableCrypto` 
  ADD INDEX source(source);