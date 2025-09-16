CREATE TABLE `Currencies_Currencies` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ISO` CHAR(3) NOT NULL,
  `symbol` CHAR(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (id, ISO),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Currencies whose exchange rate we track and that are available on the website as display currency settings';

ALTER TABLE `Currencies_Currencies` 
  ADD UNIQUE INDEX active(ISO);