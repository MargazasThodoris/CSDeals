CREATE TABLE `Crypto_BTC_Invoices` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `UUID` CHAR(36) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `addressId` INT(10) UNSIGNED NOT NULL,
  `userId` INT(10) UNSIGNED NOT NULL,
  `bitcoinAmount` DECIMAL(11, 8) NOT NULL,
  `usdAmount` DECIMAL(7, 2) NOT NULL COMMENT 'How much we will pay the user if it won''t be revaluated',
  `time` INT(11) NOT NULL,
  `expiryTime` INT(255) NOT NULL,
  `creationBitcoinPrice` DECIMAL(11, 4) NOT NULL,
  `doNotCredit` TINYINT(255) NOT NULL DEFAULT 0,
  `balanceTxId` INT(11) UNSIGNED DEFAULT NULL COMMENT 'Transaction of the crediting to the user balance',
  `paymentAcceptBitcoinPrice` DECIMAL(11, 4) DEFAULT NULL,
  `paymentTxId` INT(11) UNSIGNED DEFAULT NULL COMMENT 'id in the Crypto_BTC_DepositAddressTransactions',
  `revaluateReasons` INT(255) DEFAULT NULL COMMENT 'flags with reasons',
  PRIMARY KEY (id, UUID, addressId, userId),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'OBSOLETE. Uses old balance system. May be used to return payment data to users.';

ALTER TABLE `Crypto_BTC_Invoices` 
  ADD INDEX userID(userId);

ALTER TABLE `Crypto_BTC_Invoices` 
  ADD INDEX addressId(addressId);

ALTER TABLE `Crypto_BTC_Invoices` 
  ADD CONSTRAINT `BTCInvoiceToPaymentIncomingTx` FOREIGN KEY (paymentTxId)
    REFERENCES Crypto_BTC_IncomingTransactions_OLD(id);