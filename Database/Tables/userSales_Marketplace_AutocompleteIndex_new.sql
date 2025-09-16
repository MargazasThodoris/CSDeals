CREATE TABLE `userSales_Marketplace_AutocompleteIndex_new` (
  `marketname` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `appid` INT(255) NOT NULL,
  `itemid` INT(255) UNSIGNED NOT NULL COMMENT '->items.id; 
Used to look up the translation and for looking up this row by translation',
  `formattedName` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mainCategoryId` INT(255) UNSIGNED DEFAULT NULL COMMENT '->userSales_Marketplace_MainCategories.categoryId',
  `subCategoryId` INT(11) UNSIGNED DEFAULT NULL COMMENT '->userSales_Marketplace_SubCategories.id',
  `cs_exterior` VARCHAR(255) DEFAULT NULL,
  `cs_weapon` VARCHAR(255) DEFAULT NULL
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Automatically generated table of marketplace search autocomplete results';

ALTER TABLE `userSales_Marketplace_AutocompleteIndex_new` 
  ADD UNIQUE INDEX uniq(marketname, mainCategoryId, subCategoryId);

ALTER TABLE `userSales_Marketplace_AutocompleteIndex_new` 
  ADD INDEX itemid(itemid);

ALTER TABLE `userSales_Marketplace_AutocompleteIndex_new` 
  ADD INDEX userSales_Marketplace_AutocompleteIndex_mainCategoryId(mainCategoryId);

ALTER TABLE `userSales_Marketplace_AutocompleteIndex_new` 
  ADD INDEX userSales_Marketplace_AutocompleteIndex_subCategoryId(subCategoryId);