CREATE TABLE `steamItems_Translations` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `languageFileId` SMALLINT(6) DEFAULT NULL COMMENT '->steamItems_languageFiles.ID',
  `itemid` INT(11) DEFAULT NULL COMMENT '->items.id',
  `appid` INT(255) NOT NULL,
  `translatedMarketname` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Stores translations of Steam items';

ALTER TABLE `steamItems_Translations` 
  ADD UNIQUE INDEX uniq(itemid, languageFileId);

ALTER TABLE `steamItems_Translations` 
  ADD INDEX languageFileId(languageFileId);

ALTER TABLE `steamItems_Translations` 
  ADD FULLTEXT INDEX search(translatedMarketname);