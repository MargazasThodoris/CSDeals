CREATE TABLE `Crypto_BTC_Sends_OLD` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) DEFAULT NULL,
  `time` INT(10) UNSIGNED NOT NULL,
  `bitcoinAmount` DECIMAL(11, 8) NOT NULL,
  `bitcoinPrice` DECIMAL(11, 4) NOT NULL,
  `toAddress` VARCHAR(255) NOT NULL,
  `txFee` DECIMAL(9, 8) NOT NULL,
  `txHash` CHAR(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `rawTx` TEXT CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `Crypto_BTC_Sends_OLD` 
  ADD INDEX txHash(txHash);