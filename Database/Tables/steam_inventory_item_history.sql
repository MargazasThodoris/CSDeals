CREATE TABLE `steam_inventory_item_history` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `item_id` INT(11) UNSIGNED DEFAULT NULL,
  `description_id` INT(11) UNSIGNED DEFAULT NULL,
  `steamid` BIGINT(20) UNSIGNED NOT NULL,
  `appid` INT(11) NOT NULL,
  `contextid` INT(11) NOT NULL,
  `assetid` VARCHAR(255) NOT NULL,
  `classid` VARCHAR(255) NOT NULL,
  `instanceid` VARCHAR(255) NOT NULL,
  `amount` INT(11) NOT NULL,
  `seen_at` INT(11) NOT NULL,
  `gone_at` INT(11) NOT NULL,
  `is_tradable` TINYINT(1) NOT NULL,
  `is_marketable` TINYINT(1) NOT NULL,
  `is_commodity` TINYINT(1) NOT NULL,
  `is_active` TINYINT(1) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_unicode_ci;

ALTER TABLE `steam_inventory_item_history` 
  ADD INDEX IDX_D4BD97BE126F525E(item_id);

ALTER TABLE `steam_inventory_item_history` 
  ADD INDEX IDX_D4BD97BED9F966B(description_id);

ALTER TABLE `steam_inventory_item_history` 
  ADD CONSTRAINT `FK_D4BD97BE126F525E` FOREIGN KEY (item_id)
    REFERENCES items(id);

ALTER TABLE `steam_inventory_item_history` 
  ADD CONSTRAINT `FK_D4BD97BED9F966B` FOREIGN KEY (description_id)
    REFERENCES steamItems_Descriptions(id);