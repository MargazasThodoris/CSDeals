CREATE TABLE `userSales_Marketplace_MainCategoriesTranslations` (
  `categoryId` INT(11) UNSIGNED NOT NULL COMMENT '->userSales_Marketplace_MainCategories.id',
  `languageId` INT(8) UNSIGNED NOT NULL COMMENT '->lang_languages.id',
  `text` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Translated category name shown to the user',
  PRIMARY KEY (categoryId, languageId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Automatically generated table for translations for game specific filters'' categories.';

ALTER TABLE `userSales_Marketplace_MainCategoriesTranslations` 
  ADD UNIQUE INDEX uniq(categoryId, languageId);

ALTER TABLE `userSales_Marketplace_MainCategoriesTranslations` 
  ADD CONSTRAINT `userSales_Marketplace_MainCategoriesTranslations_` FOREIGN KEY (languageId)
    REFERENCES lang_languages(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `userSales_Marketplace_MainCategoriesTranslations` 
  ADD CONSTRAINT `userSales_Marketplace_MainCategoriesTranslations_categoryId` FOREIGN KEY (categoryId)
    REFERENCES userSales_Marketplace_MainCategories(categoryId) ON DELETE CASCADE ON UPDATE CASCADE;