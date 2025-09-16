CREATE TABLE `userSales_Marketplace_FilterColumnNamesTranslations` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `columnId` INT(11) UNSIGNED NOT NULL COMMENT '->userSales_Marketplace_FilterColumnNames.id',
  `languageId` INT(11) UNSIGNED NOT NULL COMMENT '->lang_languages.id',
  `text` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Text of the filter in this language',
  PRIMARY KEY (id, columnId, languageId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Automatically generated table for translations for game specific filters.';

ALTER TABLE `userSales_Marketplace_FilterColumnNamesTranslations` 
  ADD UNIQUE INDEX uniq(columnId, languageId);

ALTER TABLE `userSales_Marketplace_FilterColumnNamesTranslations` 
  ADD CONSTRAINT `userSales_Marketplace_FilterColumnNamesTranslations_column` FOREIGN KEY (columnId)
    REFERENCES userSales_Marketplace_FilterColumnNames(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `userSales_Marketplace_FilterColumnNamesTranslations` 
  ADD CONSTRAINT `userSales_Marketplace_FilterColumnNamesTranslations_language` FOREIGN KEY (languageId)
    REFERENCES lang_languages(id) ON DELETE CASCADE ON UPDATE CASCADE;