CREATE TABLE `p2p_items` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `p2p_provider_id` INT(11) UNSIGNED NOT NULL,
  `provider_item_id` VARCHAR(255) NOT NULL,
  `market_hash_name` VARCHAR(255) NOT NULL,
  `market_price` DECIMAL(8, 2) DEFAULT NULL COMMENT 'This  is the usd price converted and with fees applied',
  `iconpath` VARCHAR(1024) DEFAULT NULL COMMENT 'Path of the icon in the Steam CDN',
  `appid` INT(11) NOT NULL DEFAULT 730,
  `data` LONGTEXT BINARY CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `time_added` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

ALTER TABLE `p2p_items` 
  ADD INDEX provider_item_id(provider_item_id);

ALTER TABLE `p2p_items` 
  ADD CONSTRAINT `p2p_items_p2p_provider_id` FOREIGN KEY (p2p_provider_id)
    REFERENCES p2p_providers(id) ON DELETE CASCADE ON UPDATE CASCADE;