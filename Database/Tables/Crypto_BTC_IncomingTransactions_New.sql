CREATE TABLE `Crypto_BTC_IncomingTransactions_New` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `addressId` INT(10) UNSIGNED NOT NULL COMMENT '->Crypto_BTC_WalletAddresses_New.id',
  `txHash` CHAR(64) NOT NULL,
  `vOut` INT(255) NOT NULL COMMENT 'which output index this payment was',
  `bitcoinAmount` DECIMAL(11, 8) NOT NULL,
  `bitcoinPrice` DECIMAL(9, 2) NOT NULL COMMENT 'at the time when this was received',
  `confirmedBitcoinPrice` DECIMAL(9, 2) DEFAULT NULL COMMENT 'BTC/USD when the transaction was confirmed',
  `includedInBlock` INT(255) DEFAULT NULL COMMENT 'The block height in which this transaction was confirmed',
  `satoshiPerByte` FLOAT(255, 0) DEFAULT NULL COMMENT 'satoshi per byte used as the transaction fee, calculated by us and subject to error',
  `isHandled` TINYINT(11) NOT NULL DEFAULT 0 COMMENT 'Whether this transaction has been processed in our system',
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'UNIX timestamp when the transaction was sent',
  `timeLogged` INT(255) UNSIGNED DEFAULT NULL COMMENT 'when the transaction was added to the database. The time column is set to blockTime if we only saw the transaction in the block',
  `isDuplicate` TINYINT(255) NOT NULL DEFAULT 0 COMMENT '1 if this transaction was already logged in our database',
  `isConfirmed` TINYINT(255) GENERATED ALWAYS AS (if(`includedInBlock` is null,0,1)) STORED COMMENT 'Whether the transaction is confirmed by the network',
  PRIMARY KEY (id, addressId, txHash),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs all incoming Bitcoin transactions to our wallet addresses';

ALTER TABLE `Crypto_BTC_IncomingTransactions_New` 
  ADD UNIQUE INDEX uniq(txHash, vOut);

ALTER TABLE `Crypto_BTC_IncomingTransactions_New` 
  ADD INDEX time(time);

ALTER TABLE `Crypto_BTC_IncomingTransactions_New` 
  ADD CONSTRAINT `BTCIncomingTxAddressId` FOREIGN KEY (addressId)
    REFERENCES Crypto_BTC_WalletAddresses_New(id);