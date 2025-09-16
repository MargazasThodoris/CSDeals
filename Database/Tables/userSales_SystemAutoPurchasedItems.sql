CREATE TABLE `userSales_SystemAutoPurchasedItems` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userSaleId` INT(11) NOT NULL,
  `time` INT(255) NOT NULL,
  `itemid` INT(255) NOT NULL,
  `amount` INT(255) NOT NULL DEFAULT 1,
  `currency` INT(10) UNSIGNED NOT NULL,
  `salePrice` DECIMAL(11, 4) NOT NULL,
  `phaseitemid` INT(255) DEFAULT NULL,
  `ourOnSiteHistoryId` INT(255) DEFAULT NULL,
  `listedForSaleOnSiteHistoryId` INT(11) DEFAULT NULL,
  `listForSaleAfterTimestamp` INT(255) UNSIGNED DEFAULT NULL,
  `isDetectedInOwnInventory` TINYINT(255) GENERATED ALWAYS AS (if(`ourOnSiteHistoryId` is null,0,1)) VIRTUAL,
  `isWaitingToBeListed` TINYINT(255) GENERATED ALWAYS AS (if(`listedForSaleOnSiteHistoryId` is null,1,0)) STORED,
  `isOnSale` TINYINT(255) GENERATED ALWAYS AS (if(`listedForSaleOnSiteHistoryId` is not null and `resellPrice` is null,1,0)) VIRTUAL,
  `resellPrice` DECIMAL(12, 4) DEFAULT NULL,
  `resellCurrency` SMALLINT(255) DEFAULT NULL,
  PRIMARY KEY (id, userSaleId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'OBSOLETE: History of items automatically purchased by the system and their related data';

ALTER TABLE `userSales_SystemAutoPurchasedItems` 
  ADD INDEX search(time, itemid, phaseitemid);

ALTER TABLE `userSales_SystemAutoPurchasedItems` 
  ADD INDEX isDetectedInOwnInventory(isDetectedInOwnInventory);

ALTER TABLE `userSales_SystemAutoPurchasedItems` 
  ADD INDEX isWaitingToBeListed(isWaitingToBeListed);

ALTER TABLE `userSales_SystemAutoPurchasedItems` 
  ADD INDEX isOnSale(isOnSale);