CREATE TABLE `pseudonym_nouns` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `text` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Table of nouns used for the user pseudonym generation.';