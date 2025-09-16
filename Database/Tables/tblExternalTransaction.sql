CREATE TABLE `tblExternalTransaction` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `order_id` VARCHAR(36) NOT NULL,
  `provider_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  `time` DATETIME NOT NULL DEFAULT current_timestamp(),
  `type_id` INT(11) NOT NULL,
  `status_id` INT(11) NOT NULL,
  `request` TEXT DEFAULT NULL,
  `crypto_address` VARCHAR(255) NOT NULL,
  `crypto_currency_id` INT(11) NOT NULL,
  `crypto_amount` DECIMAL(10, 2) DEFAULT NULL,
  `usd_amount` DECIMAL(8, 2) DEFAULT NULL,
  `usd_amount_plus_fees` DECIMAL(8, 2) DEFAULT NULL,
  `euro_amount` DECIMAL(8, 2) DEFAULT NULL,
  `euro_amount_plus_fees` DECIMAL(8, 2) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `tblExternalTransaction` 
  ADD UNIQUE INDEX UK_tblExternalTransaction_transaction_id(order_id);

ALTER TABLE `tblExternalTransaction` 
  ADD INDEX IDX_tblExternalTransaction_user_id(user_id, time, type_id, status_id);

ALTER TABLE `tblExternalTransaction` 
  ADD CONSTRAINT `FK_tblExternalTransaction_crypto_currency_id` FOREIGN KEY (crypto_currency_id)
    REFERENCES tblExternalCryptoCurrency(id) ON DELETE NO ACTION;

ALTER TABLE `tblExternalTransaction` 
  ADD CONSTRAINT `FK_tblExternalTransaction_provider_id` FOREIGN KEY (provider_id)
    REFERENCES tblExternalProvider(id) ON DELETE NO ACTION;

ALTER TABLE `tblExternalTransaction` 
  ADD CONSTRAINT `FK_tblExternalTransaction_status_id` FOREIGN KEY (status_id)
    REFERENCES tblExternalStatus(id) ON DELETE NO ACTION;

ALTER TABLE `tblExternalTransaction` 
  ADD CONSTRAINT `FK_tblExternalTransaction_type_id` FOREIGN KEY (type_id)
    REFERENCES tblExternalTransactionType(id) ON DELETE NO ACTION;