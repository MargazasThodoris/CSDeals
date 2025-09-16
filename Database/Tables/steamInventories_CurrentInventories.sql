CREATE TABLE `steamInventories_CurrentInventories` (
  `steamID64_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '->steamInventories_SteamIDs.id',
  `appid` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `contextid` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `historyId` BIGINT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '->steamInventories_ItemHistories.id',
  PRIMARY KEY (steamID64_id, appid, contextid, historyId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Stores only the current inventory of loaded Steam inventories. Upon inventory updating rows are deleted from this row by a trigger in steamInventories_ItemHistories and when a new item is seen, it is likewise updated here by a trigger. Used to more quickly look up the current inventory of any user. Only stores data required for the lookup and steamInventories_ItemHistories is joined for more data.';

ALTER TABLE `steamInventories_CurrentInventories` 
  ADD UNIQUE INDEX uniq(steamID64_id, historyId);

ALTER TABLE `steamInventories_CurrentInventories` 
  ADD INDEX bySteamid(steamID64_id, appid);