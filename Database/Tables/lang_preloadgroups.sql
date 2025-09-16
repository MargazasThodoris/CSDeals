CREATE TABLE `lang_preloadgroups` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `scriptpath` VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'The PHP script in which we should load this group''s strings',
  PRIMARY KEY (id, scriptpath),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Preload groups to load all translated strings at once that are related to a specific page.';