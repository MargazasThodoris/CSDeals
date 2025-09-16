CREATE TABLE `valve_localizationStrings` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `languageFileId` SMALLINT(6) NOT NULL,
  `file` TINYINT(255) NOT NULL COMMENT '0=items_, 1=dota_ or equivalent',
  `appid` INT(255) NOT NULL,
  `key` VARCHAR(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '' COMMENT 'column in indexedsales:englishText',
  `text` VARCHAR(10000) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (id, languageFileId, file, appid, `key`)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_unicode_ci,
COMMENT = 'This table is used to translate specific words from english to other languages, for example the Dota2 item type texts';

ALTER TABLE `valve_localizationStrings` 
  ADD UNIQUE INDEX uniq(appid, languageFileId, file, `key`);