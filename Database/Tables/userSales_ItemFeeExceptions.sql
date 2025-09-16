CREATE TABLE `userSales_ItemFeeExceptions` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemId` INT(10) UNSIGNED NOT NULL,
  `marketname` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `realMoneyFee` DECIMAL(4, 3) DEFAULT NULL,
  `tradeBotFee` DECIMAL(4, 3) DEFAULT NULL,
  `realMoneyBonusFee` DECIMAL(4, 3) DEFAULT NULL,
  `tradeBotBonusFee` DECIMAL(4, 3) DEFAULT NULL,
  PRIMARY KEY (id, itemId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `userSales_ItemFeeExceptions` 
  ADD UNIQUE INDEX itemId(itemId);