CREATE TABLE `Crypto_BTC_IncomingTransactions_OLD` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `addressId` INT(10) UNSIGNED NOT NULL,
  `txHash` CHAR(64) NOT NULL,
  `vOut` INT(255) NOT NULL COMMENT 'which output index this payment was',
  `bitcoinAmount` DECIMAL(11, 8) NOT NULL,
  `bitcoinPrice` DECIMAL(9, 2) NOT NULL COMMENT 'at the time when this was received',
  `confirmedBitcoinPrice` DECIMAL(9, 2) DEFAULT NULL,
  `includedInBlock` INT(255) DEFAULT NULL,
  `satoshiPerByte` FLOAT(255, 0) DEFAULT NULL,
  `isHandled` TINYINT(11) NOT NULL DEFAULT 0,
  `time` INT(10) UNSIGNED NOT NULL,
  `timeLogged` INT(255) UNSIGNED DEFAULT NULL COMMENT 'when the transaction was added to the database. The time column is set to blockTime if we only saw the transaction in the block',
  `isDuplicate` TINYINT(255) NOT NULL DEFAULT 0,
  `isConfirmed` TINYINT(255) GENERATED ALWAYS AS (if(`includedInBlock` is null,0,1)) STORED,
  PRIMARY KEY (id, addressId, txHash),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `Crypto_BTC_IncomingTransactions_OLD` 
  ADD UNIQUE INDEX uniq(txHash, vOut);

ALTER TABLE `Crypto_BTC_IncomingTransactions_OLD` 
  ADD INDEX addressId(addressId);

ALTER TABLE `Crypto_BTC_IncomingTransactions_OLD` 
  ADD INDEX time(time);