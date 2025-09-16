CREATE TABLE `user_integration_cashout` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_integration_id` INT(11) NOT NULL,
  `btx_stable_crypto_id` INT(10) UNSIGNED DEFAULT NULL,
  `amount_usd` VARCHAR(255) NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 0,
  `tip_status` TINYINT(1) NOT NULL DEFAULT 0,
  `created_at` DATETIME NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_unicode_ci;

ALTER TABLE `user_integration_cashout` 
  ADD CONSTRAINT `user_integration_cashout_ibfk_1` FOREIGN KEY (user_integration_id)
    REFERENCES user_integration(id);

ALTER TABLE `user_integration_cashout` 
  ADD CONSTRAINT `user_integration_cashout_ibfk_2` FOREIGN KEY (btx_stable_crypto_id)
    REFERENCES Users_BalanceTransactions_StableCrypto(id);