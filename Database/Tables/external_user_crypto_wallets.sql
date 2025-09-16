CREATE TABLE `external_user_crypto_wallets` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) UNSIGNED NOT NULL,
  `provider_id` INT(11) UNSIGNED DEFAULT NULL COMMENT 'This column represents which provider owns this wallet',
  `external_crypto_currency_id` INT(11) UNSIGNED NOT NULL,
  `external_crypto_network_id` INT(11) UNSIGNED NOT NULL,
  `address` LONGTEXT NOT NULL,
  `wallet_uuid` VARCHAR(255) DEFAULT NULL,
  `data` LONGTEXT BINARY CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `time_added` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

ALTER TABLE `external_user_crypto_wallets` 
  ADD CONSTRAINT `FK_external_user_crypto_wallets_crypto_currency_id` FOREIGN KEY (external_crypto_currency_id)
    REFERENCES external_crypto_currency(id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `external_user_crypto_wallets` 
  ADD CONSTRAINT `FK_external_user_crypto_wallets_crypto_network_id` FOREIGN KEY (external_crypto_network_id)
    REFERENCES external_crypto_network(id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `external_user_crypto_wallets` 
  ADD CONSTRAINT `FK_external_user_crypto_wallets_user_id` FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION;