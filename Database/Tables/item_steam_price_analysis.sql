CREATE TABLE `item_steam_price_analysis` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `item_id` INT(11) UNSIGNED NOT NULL,
  `avg30` DECIMAL(8, 2) NOT NULL,
  `sales30` INT(11) NOT NULL,
  `avg7` DECIMAL(8, 2) NOT NULL,
  `sales7` INT(11) NOT NULL,
  `avg90` DECIMAL(8, 2) NOT NULL,
  `sales90` INT(11) NOT NULL,
  `last_sale_price` DECIMAL(8, 2) NOT NULL,
  `lowest_listed_price` DECIMAL(8, 2) NOT NULL,
  `highest_buy_order_price` DECIMAL(8, 2) NOT NULL,
  `count` INT(11) NOT NULL,
  `inflated` TINYINT(1) NOT NULL,
  `created_at` DATETIME NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` DATETIME NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_unicode_ci;

ALTER TABLE `item_steam_price_analysis` 
  ADD INDEX IDX_25BB31EB126F525E(item_id);

ALTER TABLE `item_steam_price_analysis` 
  ADD CONSTRAINT `FK_25BB31EB126F525E` FOREIGN KEY (item_id)
    REFERENCES items(id);