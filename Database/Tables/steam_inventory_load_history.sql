CREATE TABLE `steam_inventory_load_history` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `provider_id` INT(11) NOT NULL,
  `steam_id` BIGINT(20) NOT NULL,
  `appid` INT(11) NOT NULL,
  `contextid` INT(11) NOT NULL,
  `created_at` DATETIME NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `count` INT(11) NOT NULL,
  `error` SMALLINT(6) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_unicode_ci;

ALTER TABLE `steam_inventory_load_history` 
  ADD INDEX IDX_6481B500A53A8AA(provider_id);

ALTER TABLE `steam_inventory_load_history` 
  ADD CONSTRAINT `FK_6481B500A53A8AA` FOREIGN KEY (provider_id)
    REFERENCES steam_inventory_loading_provider(id);