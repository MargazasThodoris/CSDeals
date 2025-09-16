CREATE TABLE `Crypto_BTC_Bitmex_PendingTransactions` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` INT(11) NOT NULL,
  `amountBTC` DECIMAL(12, 8) NOT NULL COMMENT 'positive when depositing to bitmex, negative when receiving from bitmex (to match bitmex amounts)',
  `toAddressId` INT(11) DEFAULT NULL COMMENT 'id in Crypto_BTC_WalletAddresses where we are receiving the deposit. This is so we can look up from this table when we receive BTC in system addresses',
  `bitmexTransactId` CHAR(36) DEFAULT NULL,
  `isHandled` TINYINT(255) DEFAULT 0,
  `isCanceled` TINYINT(255) DEFAULT 0,
  `accountingLogged` TINYINT(255) DEFAULT 0 COMMENT 'used for withdrawals, we will set this to 1 but keep isHandled 0',
  `isArrivedToWallet` INT(255) DEFAULT NULL COMMENT 'set to 1 when we receive a withdrawal to our BTC wallet',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `Crypto_BTC_Bitmex_PendingTransactions` 
  ADD INDEX isHandled(isHandled, toAddressId);

ALTER TABLE `Crypto_BTC_Bitmex_PendingTransactions` 
  ADD INDEX isArrivedToWallet(isArrivedToWallet);