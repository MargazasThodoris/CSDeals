CREATE TABLE `Bitskins_ItemPriceSnapshots` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemDetailsId` INT(10) UNSIGNED NOT NULL COMMENT 'Bitskins_ItemDetails.id',
  `totalItems` INT(255) NOT NULL,
  `lowestPrice` DECIMAL(8, 2) DEFAULT NULL,
  `highestPrice` DECIMAL(8, 2) DEFAULT NULL,
  `cumulativePrice` DECIMAL(10, 2) DEFAULT NULL,
  `recentSalesInfo_Hours` DECIMAL(8, 2) DEFAULT NULL,
  `recentSalesInfo_AveragePrice` DECIMAL(8, 2) DEFAULT NULL,
  `updatedAt` INT(10) UNSIGNED NOT NULL,
  `time` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = MYISAM,
CHARACTER SET utf8mb4,
CHECKSUM = 0,
COLLATE utf8mb4_general_ci,
COMMENT = 'Logs data fetched from the Bitskins item pricing APIs';

ALTER TABLE `Bitskins_ItemPriceSnapshots` 
  ADD INDEX itemDetailsId(itemDetailsId, time);