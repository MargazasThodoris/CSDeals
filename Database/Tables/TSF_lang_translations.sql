CREATE TABLE `TSF_lang_translations` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `stringID` INT(10) UNSIGNED NOT NULL,
  `langID` SMALLINT(6) NOT NULL DEFAULT 1 COMMENT 'from lang_languages',
  `iscurrent` TINYINT(4) NOT NULL COMMENT 'this revision is the current one in use. To change the revision in use, set this to 0 and then to 1 on the correct row',
  `revision` TINYINT(4) NOT NULL DEFAULT 0,
  `text` TEXT NOT NULL,
  `parsedText` TEXT NOT NULL COMMENT 'same as text but variables are parsed to suit sprintf. Also percent signs are escaped with another percent sign',
  `timeadded` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (id, stringID, langID, iscurrent)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci;

ALTER TABLE `TSF_lang_translations` 
  ADD UNIQUE INDEX uniq1(stringID, langID, revision);