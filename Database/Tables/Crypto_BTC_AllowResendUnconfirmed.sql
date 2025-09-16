CREATE TABLE `Crypto_BTC_AllowResendUnconfirmed` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `txHash` CHAR(64) NOT NULL,
  PRIMARY KEY (id, txHash)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Configuration table to whitelist specific transactions that can are allowed to be used for outgoing transactions even if the specified transaction is still unconfirmed';

ALTER TABLE `Crypto_BTC_AllowResendUnconfirmed` 
  ADD UNIQUE INDEX txHash(txHash);