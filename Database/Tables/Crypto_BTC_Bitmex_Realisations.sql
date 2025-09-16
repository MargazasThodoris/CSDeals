CREATE TABLE `Crypto_BTC_Bitmex_Realisations` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` INT(11) NOT NULL,
  `amountBTC` DECIMAL(12, 8) NOT NULL,
  `bitmexTransactId` CHAR(36) DEFAULT NULL,
  `type` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `Crypto_BTC_Bitmex_Realisations` 
  ADD UNIQUE INDEX bitmexTransactId(bitmexTransactId);