CREATE TABLE `Giveaways_Groups` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '%s will be replaced by the ID of the giveaway in this group',
  PRIMARY KEY (id),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;