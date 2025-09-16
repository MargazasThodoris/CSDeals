CREATE TABLE `external_provider_fees` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `external_provider_id` INT(11) UNSIGNED NOT NULL,
  `external_currency_id` INT(11) UNSIGNED DEFAULT NULL,
  `external_network_id` INT(11) UNSIGNED DEFAULT NULL,
  `provider_fee` FLOAT UNSIGNED NOT NULL,
  `csdeals_fee` FLOAT NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;