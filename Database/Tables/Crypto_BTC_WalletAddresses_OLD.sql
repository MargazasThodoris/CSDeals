CREATE TABLE `Crypto_BTC_WalletAddresses_OLD` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(255) NOT NULL,
  `deriveIndex` INT(255) UNSIGNED NOT NULL,
  `time` INT(10) UNSIGNED NOT NULL,
  `isInvoiceAddress` TINYINT(255) NOT NULL DEFAULT 0,
  `canHaveBalance` TINYINT(255) NOT NULL DEFAULT 0,
  `format` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'Difference between segwit and P2WPKH is explained here: https://bitcoin.stackexchange.com/questions/74791/what-the-difference-between-old-segwit-3-and-new-segwit-address-bc',
  `userId` INT(10) UNSIGNED DEFAULT NULL,
  `isInBitcoreWallet` TINYINT(255) DEFAULT 0,
  `isP2WPKH` TINYINT(255) GENERATED ALWAYS AS (if(`format` = 2,1,0)) VIRTUAL,
  `isP2SH` TINYINT(255) GENERATED ALWAYS AS (if(`format` = 1,1,0)) VIRTUAL,
  `isSystemAddress` TINYINT(255) GENERATED ALWAYS AS (if(`userId` is null and `isInvoiceAddress` = 0,1,0)) STORED,
  PRIMARY KEY (id, address),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `Crypto_BTC_WalletAddresses_OLD` 
  ADD INDEX isInBitcoreWallet(isInBitcoreWallet);

ALTER TABLE `Crypto_BTC_WalletAddresses_OLD` 
  ADD INDEX address(address);

ALTER TABLE `Crypto_BTC_WalletAddresses_OLD` 
  ADD INDEX userId(userId);

ALTER TABLE `Crypto_BTC_WalletAddresses_OLD` 
  ADD INDEX format(format, isSystemAddress);