CREATE TABLE `Users_BusinessDetails` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `addressAdditional` VARCHAR(255) NOT NULL,
  `registrationNumber` VARCHAR(255) NOT NULL,
  `companyType` INT(11) NOT NULL,
  `postcode` VARCHAR(255) NOT NULL,
  `city` VARCHAR(255) NOT NULL,
  `state` VARCHAR(255) NOT NULL,
  `countryISO` VARCHAR(2) NOT NULL,
  `details` LONGTEXT NOT NULL COMMENT '(DC2Type:json)',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci;