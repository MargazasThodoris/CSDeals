CREATE TABLE `Bitskins_ItemSaleHistory` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemid` INT(11) NOT NULL,
  `time` INT(10) UNSIGNED DEFAULT NULL,
  `price` DECIMAL(12, 4) DEFAULT NULL,
  `wear_value` DOUBLE(15, 14) DEFAULT NULL,
  PRIMARY KEY (id, itemid)
)
ENGINE = MYISAM,
CHARACTER SET utf8mb4,
CHECKSUM = 0,
COLLATE utf8mb4_general_ci;

ALTER TABLE `Bitskins_ItemSaleHistory` 
  ADD UNIQUE INDEX uniq(itemid, time, price);