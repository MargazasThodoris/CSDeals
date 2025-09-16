CREATE TABLE `Bitskins_ListingsHistory` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `bitskinsItemDetailsId` INT(10) UNSIGNED NOT NULL COMMENT '->Bitskins_ItemDetails.id',
  `bitskinsImageId` INT(10) UNSIGNED NOT NULL COMMENT '->Bitskins_SteamImages.id',
  `itemId` VARCHAR(64) NOT NULL COMMENT 'The item ID assigned by Bitskins, not local item id',
  `assetId` BIGINT(20) UNSIGNED NOT NULL,
  `classId` INT(10) UNSIGNED NOT NULL,
  `instanceId` INT(10) UNSIGNED NOT NULL,
  `phase` VARCHAR(32) DEFAULT NULL COMMENT 'name of the phase',
  `price` DECIMAL(10, 2) UNSIGNED NOT NULL,
  `discount` DECIMAL(10, 4) NOT NULL COMMENT 'As determined by Bitskins',
  `withdrawableAt` INT(10) UNSIGNED DEFAULT NULL,
  `time` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id, bitskinsItemDetailsId),
  INDEX id(id)
)
ENGINE = MYISAM,
CHARACTER SET latin1,
CHECKSUM = 0,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs all new Bitskins listings from their websocket API';

ALTER TABLE `Bitskins_ListingsHistory` 
  ADD INDEX itemidTime(itemId, time);

ALTER TABLE `Bitskins_ListingsHistory` 
  ADD INDEX bitskinsListingDetailsId(bitskinsItemDetailsId);

ALTER TABLE `Bitskins_ListingsHistory` 
  ADD INDEX bitskinsListingImageId(bitskinsImageId);