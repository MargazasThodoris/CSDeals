CREATE TABLE `Crypto_BTC_WalletAddressSettings` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `addressId` INT(10) UNSIGNED DEFAULT NULL,
  `canSendWithoutConfirmed` TINYINT(255) DEFAULT 1,
  `doNotSendWithoutConfirmed` TINYINT(255) DEFAULT 0,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Additional configuration for specific wallet addresses. Allows to force never to send incoming transactions without the transaction being confirmed first, or allows sending the transactions before they are confirmed.';

ALTER TABLE `Crypto_BTC_WalletAddressSettings` 
  ADD CONSTRAINT `addressID` FOREIGN KEY (addressId)
    REFERENCES Crypto_BTC_WalletAddresses_OLD(id);