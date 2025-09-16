CREATE TABLE `Crypto_BTC_WalletAddresses_New` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(255) NOT NULL COMMENT 'Bitcoin address',
  `deriveIndex` INT(255) UNSIGNED NOT NULL COMMENT 'From which index this was derived',
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'Time when this address was taken into use',
  `canHaveBalance` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'Whether this address can have balance. Used for possibility to optimize so we don''t have to check balance of all addresses. Set to 1 whenever we receive a transaction to this address',
  `format` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'Difference between segwit and P2WPKH is explained here: https://bitcoin.stackexchange.com/questions/74791/what-the-difference-between-old-segwit-3-and-new-segwit-address-bc',
  `userId` INT(10) UNSIGNED DEFAULT NULL COMMENT '->users.id',
  `isInBitcoreWallet` TINYINT(255) DEFAULT 0 COMMENT 'Whether this address is registered in the Bitcore wallet',
  `isP2WPKH` TINYINT(255) GENERATED ALWAYS AS (if(`format` = 2,1,0)) VIRTUAL,
  `isP2SH` TINYINT(255) GENERATED ALWAYS AS (if(`format` = 1,1,0)) VIRTUAL,
  `isSystemAddress` TINYINT(255) GENERATED ALWAYS AS (if(`userId` is null,1,0)) STORED COMMENT 'Whether this address is used by a system instead of a user',
  PRIMARY KEY (id, address),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `Crypto_BTC_WalletAddresses_New` 
  ADD INDEX isInBitcoreWallet(isInBitcoreWallet);

ALTER TABLE `Crypto_BTC_WalletAddresses_New` 
  ADD INDEX address(address);

ALTER TABLE `Crypto_BTC_WalletAddresses_New` 
  ADD INDEX format(format, isSystemAddress);

ALTER TABLE `Crypto_BTC_WalletAddresses_New` 
  ADD CONSTRAINT `BTCWalletAddressesUserId` FOREIGN KEY (userId)
    REFERENCES users(id);