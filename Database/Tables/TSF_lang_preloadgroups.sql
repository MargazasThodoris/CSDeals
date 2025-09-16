CREATE TABLE `TSF_lang_preloadgroups` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `scriptpath` VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY (id, scriptpath)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;