CREATE TABLE `onSiteInventories_ItemsToIdentify` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID in the steamInventories_SteamIDs table',
  `botId` INT(11) NOT NULL,
  `steamTradeId` BIGINT(20) NOT NULL,
  `steamTradeItemId` BIGINT(20) UNSIGNED NOT NULL,
  `itemid` INT(10) UNSIGNED NOT NULL,
  `phaseitemid` INT(10) UNSIGNED DEFAULT NULL,
  `toInventoryId` INT(11) DEFAULT NULL,
  `classid` INT(11) DEFAULT NULL,
  `instanceid` INT(11) DEFAULT NULL,
  `amount` VARCHAR(255) DEFAULT NULL,
  `time` INT(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (id, botId, steamTradeId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Items are inserted here when a Steam trade has been accepted. When we update the bot inventory and see new items, we will match them with this table and deliver them to the correct inventoryId.

UPDATE: We won''t match new items with this table, but instead botInventories_ChangesToIdentify. This table is obsolete, but still used for debugging and problem/error handling purposes.';