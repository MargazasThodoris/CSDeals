CREATE TABLE `external_transaction` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` VARCHAR(36) NOT NULL,
  `provider_id` INT(11) UNSIGNED NOT NULL,
  `user_id` INT(11) UNSIGNED NOT NULL,
  `time` DATETIME NOT NULL DEFAULT current_timestamp(),
  `type_id` INT(11) UNSIGNED NOT NULL,
  `status_id` INT(11) UNSIGNED NOT NULL,
  `request` TEXT DEFAULT NULL,
  `crypto_address` VARCHAR(255) DEFAULT NULL,
  `crypto_currency_id` INT(11) UNSIGNED NOT NULL,
  `network` VARCHAR(40) DEFAULT NULL,
  `crypto_transaction_id` VARCHAR(255) DEFAULT NULL,
  `crypto_amount` DECIMAL(65, 30) DEFAULT NULL,
  `usd_amount` DECIMAL(8, 2) DEFAULT NULL,
  `usd_amount_plus_fees` DECIMAL(8, 2) DEFAULT NULL,
  `euro_amount` DECIMAL(8, 2) DEFAULT NULL,
  `euro_amount_plus_fees` DECIMAL(8, 2) DEFAULT NULL,
  `user_balance_transaction_id` INT(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

ALTER TABLE `external_transaction` 
  ADD UNIQUE INDEX UK_external_transaction_transaction_id(order_id);

ALTER TABLE `external_transaction` 
  ADD INDEX IDX_external_transaction_user_id(user_id, time, type_id, status_id);

ALTER TABLE `external_transaction` 
  ADD CONSTRAINT `FK_external_transaction_crypto_currency_id` FOREIGN KEY (crypto_currency_id)
    REFERENCES external_crypto_currency(id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `external_transaction` 
  ADD CONSTRAINT `FK_external_transaction_provider_id` FOREIGN KEY (provider_id)
    REFERENCES external_provider(id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `external_transaction` 
  ADD CONSTRAINT `FK_external_transaction_status_id` FOREIGN KEY (status_id)
    REFERENCES external_status(id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `external_transaction` 
  ADD CONSTRAINT `FK_external_transaction_type_id` FOREIGN KEY (type_id)
    REFERENCES external_transaction_type(id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `external_transaction` 
  ADD CONSTRAINT `FK_external_transaction_user_id` FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `external_transaction` 
  ADD CONSTRAINT `FK_user_balance_transaction_id` FOREIGN KEY (user_balance_transaction_id)
    REFERENCES Users_BalanceTransactions_StableCrypto(id) ON DELETE NO ACTION;