CREATE TABLE `external_transaction_cashout` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `provider_id` INT(11) UNSIGNED NOT NULL,
  `user_id` INT(11) UNSIGNED NOT NULL,
  `time` DATETIME NOT NULL DEFAULT current_timestamp(),
  `iban` VARCHAR(255) NOT NULL,
  `type_id` INT(11) UNSIGNED NOT NULL,
  `currency` CHAR(3) NOT NULL COMMENT 'The currency where cashout will be perfomed, thus target currency',
  `status_id` INT(11) UNSIGNED NOT NULL DEFAULT 1,
  `usd_amount` DECIMAL(11, 5) NOT NULL,
  `usd_amount_fee` DECIMAL(11, 5) DEFAULT NULL,
  `balance_transaction_id` INT(11) UNSIGNED DEFAULT NULL,
  `address` VARCHAR(255) DEFAULT NULL,
  `town_city` VARCHAR(255) DEFAULT NULL,
  `country_state` VARCHAR(255) DEFAULT NULL,
  `zipcode` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

ALTER TABLE `external_transaction_cashout` 
  ADD INDEX IDX_external_transaction_user_id(user_id, time, type_id, status_id);

ALTER TABLE `external_transaction_cashout` 
  ADD INDEX FK_external_transaction_cashout_provider_id(provider_id);

ALTER TABLE `external_transaction_cashout` 
  ADD CONSTRAINT `FK_external_transaction_cashout_balance_transaction_id` FOREIGN KEY (balance_transaction_id)
    REFERENCES Users_BalanceTransactions_StableCrypto(id) ON DELETE NO ACTION;

ALTER TABLE `external_transaction_cashout` 
  ADD CONSTRAINT `FK_external_transaction_cashout_status_id` FOREIGN KEY (status_id)
    REFERENCES external_status(id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `external_transaction_cashout` 
  ADD CONSTRAINT `FK_external_transaction_cashout_type_id` FOREIGN KEY (type_id)
    REFERENCES external_transaction_type(id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `external_transaction_cashout` 
  ADD CONSTRAINT `FK_external_transaction_cashout_user_id` FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE NO ACTION;