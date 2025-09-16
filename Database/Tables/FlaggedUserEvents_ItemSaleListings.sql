CREATE TABLE `FlaggedUserEvents_ItemSaleListings` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `userSaleId` INT(10) UNSIGNED NOT NULL,
  `onSiteHistoryId` INT(10) UNSIGNED NOT NULL,
  `onSiteTradeId` INT(10) UNSIGNED DEFAULT NULL,
  `flaggedUserEventId` INT(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci;

ALTER TABLE `FlaggedUserEvents_ItemSaleListings` 
  ADD INDEX IDX_37F7AEEB6236898E(flaggedUserEventId);

ALTER TABLE `FlaggedUserEvents_ItemSaleListings` 
  ADD INDEX userSale(userSaleId);

ALTER TABLE `FlaggedUserEvents_ItemSaleListings` 
  ADD CONSTRAINT `FK_37F7AEEB6236898E` FOREIGN KEY (flaggedUserEventId)
    REFERENCES FlaggedUserEvents(id);