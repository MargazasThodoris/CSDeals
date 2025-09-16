CREATE TABLE `steamInventories_LoadHistory` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `steamID64_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '->steamInventories_SteamIDs.id',
  `appid` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `contextid` INT(10) UNSIGNED NOT NULL,
  `time` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'UNIX timestamp of the attempt',
  `totalItems` INT(11) NOT NULL DEFAULT 0 COMMENT 'errorcode if failed to load',
  `loadErrorCode` SMALLINT(4) NOT NULL DEFAULT 0 COMMENT '0 if successful',
  PRIMARY KEY (id, steamID64_id)
)
ENGINE = MYISAM,
CHARACTER SET latin1,
CHECKSUM = 0,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs load attempts of Steam inventories, successful or not';

ALTER TABLE `steamInventories_LoadHistory` 
  ADD INDEX app(appid, contextid);

ALTER TABLE `steamInventories_LoadHistory` 
  ADD INDEX bySteamId(steamID64_id, appid);