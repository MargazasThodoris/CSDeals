CREATE TABLE `Bitskins_ItemDetails` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemId` INT(11) UNSIGNED DEFAULT NULL COMMENT '->items.id',
  `appId` INT(11) UNSIGNED NOT NULL DEFAULT 0,
  `contextId` INT(11) UNSIGNED NOT NULL DEFAULT 0,
  `marketHashName` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Links Bitskins items to local itemId, if the item exists locally. For logging item price snapshots we don''t use local item IDs, but rather the item IDs in this table.';

ALTER TABLE `Bitskins_ItemDetails` 
  ADD UNIQUE INDEX uniq(appId, contextId, marketHashName);

ALTER TABLE `Bitskins_ItemDetails` 
  ADD INDEX itemId(itemId);