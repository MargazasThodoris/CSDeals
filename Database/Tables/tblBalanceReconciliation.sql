CREATE TABLE `tblBalanceReconciliation` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `data` LONGTEXT BINARY CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `time` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `bitcoin_price` DECIMAL(8, 2) DEFAULT NULL,
  `usd_amount_old_users` DECIMAL(10, 4) DEFAULT NULL,
  `bitcoin_amount_users` DECIMAL(12, 2) DEFAULT NULL,
  `bitcoin_amount_usd_users` DECIMAL(14, 4) DEFAULT NULL,
  `euro_amount_adyen_company` DECIMAL(8, 2) DEFAULT NULL,
  `usd_amount_adyen_company` DECIMAL(8, 2) DEFAULT NULL,
  `token_amount_users` DECIMAL(10, 2) DEFAULT NULL,
  `bitcoin_amount_company` DECIMAL(12, 2) DEFAULT NULL,
  `bitcoin_amount_usd_company` DECIMAL(14, 4) DEFAULT NULL,
  `bitcoin_deposits_usd_users` DECIMAL(14, 4) DEFAULT NULL,
  `bitcoin_withdraws_usd_users` DECIMAL(14, 4) DEFAULT NULL,
  `euro_usd_rate` DECIMAL(10, 2) DEFAULT NULL,
  `euro_amount_revolut_company` DECIMAL(12, 2) DEFAULT NULL,
  `usd_amount_revolut_company` DECIMAL(12, 2) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci;

ALTER TABLE `tblBalanceReconciliation` 
  ADD CONSTRAINT `data` CHECK (json_valid(`data`));