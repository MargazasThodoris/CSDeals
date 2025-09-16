CREATE TABLE `TSF_lang_languages` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tag` CHAR(4) NOT NULL,
  `name` VARCHAR(32) NOT NULL,
  `foreignName` VARCHAR(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `iconpath` VARCHAR(255) NOT NULL,
  PRIMARY KEY (id, tag, name)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;