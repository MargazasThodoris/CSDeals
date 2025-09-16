CREATE TABLE `lang_translations` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `stringID` INT(10) NOT NULL COMMENT '->lang_textIDs.stringID',
  `langID` INT(6) UNSIGNED NOT NULL DEFAULT 1 COMMENT '->lang_languages.id',
  `iscurrent` TINYINT(4) NOT NULL COMMENT 'this revision is the current one in use. To change the revision in use, set this to 0 and then to 1 on the correct row',
  `revision` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'Incrementing number for stringID+langID',
  `text` TEXT NOT NULL COMMENT 'Unparsed raw text',
  `parsedText` TEXT NOT NULL COMMENT 'same as text but variables are parsed to suit sprintf. Also percent signs are escaped with another percent sign',
  `timeadded` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (id, stringID, langID, iscurrent)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci,
COMMENT = 'Translations for specific strings and languages';

ALTER TABLE `lang_translations` 
  ADD UNIQUE INDEX uniq1(stringID, langID, revision);

ALTER TABLE `lang_translations` 
  ADD CONSTRAINT `translations_langID` FOREIGN KEY (langID)
    REFERENCES lang_languages(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `lang_translations` 
  ADD CONSTRAINT `translations_stringID` FOREIGN KEY (stringID)
    REFERENCES lang_textIDs(stringID) ON DELETE CASCADE ON UPDATE CASCADE;