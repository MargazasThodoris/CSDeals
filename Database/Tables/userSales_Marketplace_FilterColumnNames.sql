CREATE TABLE `userSales_Marketplace_FilterColumnNames` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `filterColumnName` VARCHAR(255) NOT NULL COMMENT 'name of the column in userSales_IndexedSales',
  `appid` SMALLINT(255) UNSIGNED NOT NULL,
  `translationKey` VARCHAR(255) DEFAULT NULL COMMENT 'Translation key in the game file',
  `english` VARCHAR(255) NOT NULL COMMENT 'English text of the filter',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Manually created list of marketplace search filters. Includes the corresponding table column, translation key in the game files and the english text for the filter fetched from the game files.';

ALTER TABLE `userSales_Marketplace_FilterColumnNames` 
  ADD UNIQUE INDEX uniq(filterColumnName, appid);