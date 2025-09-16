CREATE TABLE `botInventories_AdditionalItemData` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `origin` SMALLINT(255) DEFAULT NULL COMMENT 'origin as reported by steam API',
  `tf2_unusualEffectDefindex` SMALLINT(6) DEFAULT NULL,
  `tf2_containedItemDefindex` SMALLINT(255) DEFAULT NULL,
  `tf2_containedItemId` INT(11) DEFAULT NULL COMMENT 'for wrapped items, we will show this item instead of the gift item',
  `tf2_containedItemEffectDefindex` SMALLINT(6) DEFAULT NULL,
  `tf2_containedItemImageURL` VARCHAR(255) DEFAULT NULL COMMENT 'We can get this from the item schema from API GetSchemaItems',
  `dataJSON` LONGTEXT BINARY CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Required for building item names for TF2',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Stores additional data related to TF2 items in bot inventories';