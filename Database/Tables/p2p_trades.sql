CREATE TABLE `p2p_trades` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `identifier` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'csdeals user id',
  `user_id` INT(11) UNSIGNED NOT NULL COMMENT 'csdeals user id',
  `p2p_provider_id` INT(11) UNSIGNED NOT NULL COMMENT 'c5, etc..',
  `p2p_status_id` INT(11) UNSIGNED NOT NULL COMMENT 'pending, paid, error',
  `status_code` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `status_message` LONGTEXT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `p2p_item_market_hash_name` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `p2p_seller_id` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'This will be the seller identifier',
  `p2p_seller_username` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'This will be the seller username',
  `amount_eur` DECIMAL(12, 8) NOT NULL,
  `amount_usd` DECIMAL(12, 8) NOT NULL,
  `fee_amount_usd` DECIMAL(8, 2) DEFAULT NULL COMMENT 'CSDEALS fee amount',
  `provider_fee_amount_usd` DECIMAL(8, 2) DEFAULT NULL COMMENT 'PROVIDER fee amount',
  `p2p_buyer_steam_id` VARCHAR(255) DEFAULT NULL COMMENT 'buyer steam id',
  `p2p_buyer_steam_token` VARCHAR(255) DEFAULT NULL COMMENT 'buyer steam token',
  `p2p_buyer_steam_trade_url` VARCHAR(255) DEFAULT NULL COMMENT 'buyer trade url',
  `data` LONGTEXT BINARY CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `time_added` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  `time_updated` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

ALTER TABLE `p2p_trades` 
  ADD UNIQUE INDEX identifier(identifier);

ALTER TABLE `p2p_trades` 
  ADD CONSTRAINT `p2p_trades_ibfk_1` FOREIGN KEY (user_id)
    REFERENCES users(id);

ALTER TABLE `p2p_trades` 
  ADD CONSTRAINT `p2p_trades_ibfk_2` FOREIGN KEY (p2p_provider_id)
    REFERENCES p2p_providers(id);

ALTER TABLE `p2p_trades` 
  ADD CONSTRAINT `p2p_trades_ibfk_3` FOREIGN KEY (p2p_status_id)
    REFERENCES p2p_statuses(id);