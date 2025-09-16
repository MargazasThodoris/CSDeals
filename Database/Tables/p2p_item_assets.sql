CREATE TABLE `p2p_item_assets` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `p2p_item_id` INT(11) UNSIGNED NOT NULL,
  `provider_product_id` VARCHAR(255) NOT NULL,
  `inspect_link` VARCHAR(512) DEFAULT NULL,
  `iconpath` VARCHAR(1024) DEFAULT NULL,
  `image_url` VARCHAR(1024) NOT NULL,
  `amount_eur` DECIMAL(12, 8) NOT NULL,
  `amount_usd` DECIMAL(12, 8) NOT NULL,
  `assetid` BIGINT(10) DEFAULT NULL,
  `classid` BIGINT(10) DEFAULT NULL,
  `instanceid` BIGINT(10) DEFAULT NULL,
  `steam_id` VARCHAR(250) DEFAULT NULL,
  `steam_username` VARCHAR(250) DEFAULT NULL,
  `steam_avatar_url` VARCHAR(512) DEFAULT NULL,
  `paint_index` INT(11) DEFAULT NULL COMMENT 'Only cs items but very important',
  `paint_seed` INT(11) DEFAULT NULL COMMENT 'Only cs items but very important',
  `wear` DECIMAL(18, 16) DEFAULT NULL COMMENT 'Only cs items but very important',
  `fade_percentage` DECIMAL(18, 16) DEFAULT NULL COMMENT 'Only cs items but very important',
  `attributes` LONGTEXT BINARY CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attributes`)),
  `data` LONGTEXT BINARY CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `time_added` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `time_updated` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

ALTER TABLE `p2p_item_assets` 
  ADD INDEX paint_seed(paint_seed);

ALTER TABLE `p2p_item_assets` 
  ADD INDEX paint_index(paint_index);

ALTER TABLE `p2p_item_assets` 
  ADD INDEX fade_percentage(fade_percentage);

ALTER TABLE `p2p_item_assets` 
  ADD INDEX wear(wear);

ALTER TABLE `p2p_item_assets` 
  ADD INDEX provider_product_id(provider_product_id);

ALTER TABLE `p2p_item_assets` 
  ADD CONSTRAINT `p2p_item_assets_p2p_items_id` FOREIGN KEY (p2p_item_id)
    REFERENCES p2p_items(id) ON DELETE CASCADE ON UPDATE CASCADE;