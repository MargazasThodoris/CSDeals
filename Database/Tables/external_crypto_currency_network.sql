CREATE TABLE `external_crypto_currency_network` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `external_crypto_currency_id` INT(11) UNSIGNED NOT NULL,
  `external_crypto_network_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

ALTER TABLE `external_crypto_currency_network` 
  ADD CONSTRAINT `external_crypto_currency_network_FK_external_crypto_currency_id` FOREIGN KEY (external_crypto_currency_id)
    REFERENCES external_crypto_currency(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `external_crypto_currency_network` 
  ADD CONSTRAINT `external_crypto_currency_network_FK_external_crypto_network_id` FOREIGN KEY (external_crypto_network_id)
    REFERENCES external_crypto_network(id) ON DELETE CASCADE ON UPDATE CASCADE;