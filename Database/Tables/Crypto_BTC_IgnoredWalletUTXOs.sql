CREATE TABLE `Crypto_BTC_IgnoredWalletUTXOs` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `txHash` CHAR(64) DEFAULT NULL,
  `vOut` INT(255) DEFAULT NULL,
  `bitcoinAmount` DECIMAL(11, 8) DEFAULT NULL,
  `satoshiAmount` INT(255) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Bitcore is bugged and doesn''t clear out doublespent transactions. To play this safe, this table was made to ignore doublespend txids instead of deleting them from the Bitcore database';

ALTER TABLE `Crypto_BTC_IgnoredWalletUTXOs` 
  ADD UNIQUE INDEX uniq(txHash, vOut);