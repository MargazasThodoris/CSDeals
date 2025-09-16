CREATE TABLE `CSGOFiles_englishTokens` (
  `id` INT(10) UNSIGNED NOT NULL,
  `token` VARCHAR(128) NOT NULL,
  `value` VARCHAR(1024) DEFAULT NULL,
  PRIMARY KEY (id, token)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;