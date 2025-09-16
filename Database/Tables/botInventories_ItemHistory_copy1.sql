CREATE TABLE `botInventories_ItemHistory_copy1` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `botid` INT(10) UNSIGNED NOT NULL COMMENT '->bots.id',
  `itemid` INT(10) UNSIGNED NOT NULL COMMENT '->items.id',
  `assetid` BIGINT(20) UNSIGNED NOT NULL,
  `classid` BIGINT(20) UNSIGNED NOT NULL,
  `instanceid` BIGINT(10) UNSIGNED NOT NULL,
  `iscommodity` TINYINT(4) NOT NULL DEFAULT 0,
  `isstattrak` TINYINT(4) NOT NULL DEFAULT 0,
  `nametag` VARCHAR(50) NOT NULL,
  `tags` TEXT CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `inspectcode` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'the inspect link is always in this format: steam:\\/\\/rungame\\/730\\/76561202255233023\\/+csgo_econ_action_preview%20S%owner_steamid%A1237827406D4777456144419302390 and this value is what comes after D',
  `timeseen` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'when we first saw this item',
  `receiveprice` DECIMAL(6, 2) NOT NULL DEFAULT 0.00 COMMENT 'the price of this when we received it',
  `timegone` INT(11) NOT NULL DEFAULT 0 COMMENT 'when we noticed all items in this stack are gone',
  `giveprice` DECIMAL(6, 2) NOT NULL DEFAULT 0.00 COMMENT 'the price of this when we saw it gone',
  `amount` INT(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT 'Amount of items in the stack. This will be updated if the stack amount changes. When the stack is gone, this column will remain at the final stack amount and it will not be logged to botInventories_ItemStackAmountChanges',
  `descriptionId` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `stickers` TEXT CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT 'json array [[name, url],...]',
  `paintwear` DOUBLE(15, 14) DEFAULT NULL,
  `paintseed` MEDIUMINT(8) UNSIGNED DEFAULT NULL,
  `paintindex` MEDIUMINT(8) DEFAULT NULL,
  `tradableAfterTime` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'UNIX timestamp after which the item becomes tradable',
  `additionalItemDataId` INT(255) UNSIGNED DEFAULT NULL COMMENT '->botInventories_AdditionalItemData.id',
  `isActive` TINYINT(4) GENERATED ALWAYS AS (if(`timegone` = 0,1,0)) STORED COMMENT 'Whether the item is still on the bot',
  PRIMARY KEY (id, botid),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'History of all Steam items that have been seen in the bot inventories.';

ALTER TABLE `botInventories_ItemHistory_copy1` 
  ADD UNIQUE INDEX uniq(botid, assetid, itemid, timegone);

ALTER TABLE `botInventories_ItemHistory_copy1` 
  ADD INDEX fasterInventoryRead(timegone);

ALTER TABLE `botInventories_ItemHistory_copy1` 
  ADD INDEX fasterAnalytics(timeseen);

ALTER TABLE `botInventories_ItemHistory_copy1` 
  ADD INDEX currentInv(isActive, botid);

ALTER TABLE `botInventories_ItemHistory_copy1` 
  ADD INDEX botInventoryAdditionalItemDataId(additionalItemDataId);

ALTER TABLE `botInventories_ItemHistory_copy1` 
  ADD CONSTRAINT `botInventories_ItemHistory_copy1_ibfk_1` FOREIGN KEY (additionalItemDataId)
    REFERENCES botInventories_AdditionalItemData(id);

ALTER TABLE `botInventories_ItemHistory_copy1` 
  ADD CONSTRAINT `botInventories_ItemHistory_copy1_ibfk_2` FOREIGN KEY (botid)
    REFERENCES bots(id);

ALTER TABLE `botInventories_ItemHistory_copy1` 
  ADD CONSTRAINT `botInventories_ItemHistory_copy1_ibfk_3` FOREIGN KEY (itemid)
    REFERENCES items(id);