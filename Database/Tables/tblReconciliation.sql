CREATE TABLE `tblReconciliation` (
  `date_time` VARCHAR(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `update_time` DATETIME DEFAULT current_timestamp(),
  `users_account_virtutrade_usd` DECIMAL(14, 4) DEFAULT NULL,
  `users_account_usd` DECIMAL(14, 4) DEFAULT NULL,
  `users_account_banned_usd` DECIMAL(14, 4) DEFAULT NULL,
  `users_account_inactive_usd` DECIMAL(14, 4) DEFAULT NULL,
  `users_account_net_usd` DECIMAL(14, 4) DEFAULT NULL,
  `users_account_tokens` DECIMAL(14, 4) DEFAULT NULL,
  `company_btc_wallet_usd` DECIMAL(14, 4) DEFAULT NULL,
  `company_skinsback_balance_usd` DECIMAL(14, 4) DEFAULT NULL,
  `company_cryptocom_balance_usdt` DECIMAL(14, 4) DEFAULT NULL,
  `company_revolut_balance_usd` DECIMAL(14, 4) DEFAULT NULL,
  `company_adyen_balance_usd` DECIMAL(14, 4) DEFAULT NULL,
  `company_inventory_usd` DECIMAL(39, 6) DEFAULT NULL,
  `users_inventory_usd` DECIMAL(39, 6) DEFAULT NULL,
  `users_inventory_banned_usd` DECIMAL(39, 6) DEFAULT NULL,
  `users_inventory_inactive_usd` DECIMAL(14, 4) DEFAULT NULL,
  PRIMARY KEY (date_time)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;