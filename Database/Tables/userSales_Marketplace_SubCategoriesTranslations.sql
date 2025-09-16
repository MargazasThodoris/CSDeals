CREATE TABLE `userSales_Marketplace_SubCategoriesTranslations` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `categoryId` INT(10) UNSIGNED NOT NULL COMMENT '->userSales_Marketplace_SubCategories.id',
  `languageId` INT(8) UNSIGNED NOT NULL COMMENT '->lang_languages.id',
  `text` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'shown to the user',
  PRIMARY KEY (id, categoryId, languageId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Automatically generated table for translations for game specific filters'' categories'' subcategories.';

ALTER TABLE `userSales_Marketplace_SubCategoriesTranslations` 
  ADD UNIQUE INDEX uniq(categoryId, languageId);

ALTER TABLE `userSales_Marketplace_SubCategoriesTranslations` 
  ADD CONSTRAINT `userSales_Marketplace_SubCategoriesTranslations_categoryId` FOREIGN KEY (categoryId)
    REFERENCES userSales_Marketplace_SubCategories(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `userSales_Marketplace_SubCategoriesTranslations` 
  ADD CONSTRAINT `userSales_Marketplace_SubCategoriesTranslations_languageId` FOREIGN KEY (languageId)
    REFERENCES lang_languages(id) ON DELETE CASCADE ON UPDATE CASCADE;