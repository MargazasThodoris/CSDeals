CREATE TABLE `lang_languages` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tag` CHAR(5) NOT NULL,
  `name` VARCHAR(32) NOT NULL,
  `foreignName` VARCHAR(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `iconpath` VARCHAR(255) NOT NULL,
  `BCP47` VARCHAR(255) DEFAULT NULL COMMENT 'for example pt-br',
  `weblateLangName` VARCHAR(255) DEFAULT NULL,
  `weblateGroupId` INT(6) DEFAULT 0,
  `isEnabledForWeb` TINYINT(255) DEFAULT 0 COMMENT 'If users can switch to this language on the website',
  PRIMARY KEY (id, tag, name),
  INDEX id(id),
  INDEX id_2(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;