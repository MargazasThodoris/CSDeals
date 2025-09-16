CREATE TABLE `userSales_Marketplace_ParsedMenus` (
  `languageId` INT(11) UNSIGNED NOT NULL COMMENT '->lang_languages.id',
  `JSON` LONGTEXT DEFAULT NULL,
  PRIMARY KEY (languageId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Programmatically generated menu structures for categories and subcategories of items per app for each language. Updated by a cron script.';

ALTER TABLE `userSales_Marketplace_ParsedMenus` 
  ADD UNIQUE INDEX uniq(languageId);

ALTER TABLE `userSales_Marketplace_ParsedMenus` 
  ADD CONSTRAINT `userSales_Marketplace_ParsedMenus_lang` FOREIGN KEY (languageId)
    REFERENCES lang_languages(id) ON DELETE CASCADE ON UPDATE CASCADE;