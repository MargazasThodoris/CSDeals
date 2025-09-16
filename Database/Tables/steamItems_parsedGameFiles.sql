CREATE TABLE `steamItems_parsedGameFiles` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appid` INT(11) NOT NULL,
  `defindex` INT(255) NOT NULL,
  `itemid` INT(11) DEFAULT NULL COMMENT '->items.id',
  `dataJSON` LONGTEXT BINARY CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (id, appid, defindex)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci,
COMMENT = 'Data parsed from CSGO and Dota 2 game files and linked to the local item, if possible';

ALTER TABLE `steamItems_parsedGameFiles` 
  ADD UNIQUE INDEX uniq(appid, defindex);

ALTER TABLE `steamItems_parsedGameFiles` 
  ADD INDEX itemid(itemid);