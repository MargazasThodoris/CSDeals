CREATE TABLE `integration` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `api_domain` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `conversion_rate` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_unicode_ci;