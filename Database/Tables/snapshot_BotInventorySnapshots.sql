CREATE TABLE `snapshot_BotInventorySnapshots` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `historyId` BIGINT(11) UNSIGNED DEFAULT NULL COMMENT '->botInventories_ItemHistory.id',
  `requestId` INT(10) UNSIGNED DEFAULT NULL COMMENT '->snapshot_Requests.id',
  `imageId` INT(10) UNSIGNED DEFAULT NULL COMMENT '->snapshot_Images.id',
  `isHandled` TINYINT(255) DEFAULT 0 COMMENT 'flag whether this item has been snapshot',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Links items from our bots'' inventories to the CSGO snapshots taken from them using our snapshot system';

ALTER TABLE `snapshot_BotInventorySnapshots` 
  ADD UNIQUE INDEX uniq(historyId);

ALTER TABLE `snapshot_BotInventorySnapshots` 
  ADD INDEX searchForDelete(isHandled, imageId);