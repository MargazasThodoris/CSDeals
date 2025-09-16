CREATE TABLE `Users_BillingAddresses` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) UNSIGNED NOT NULL COMMENT '->users.id',
  `time` INT(11) NOT NULL COMMENT 'UNIX timestamp if this entry',
  `firstName` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `lastName` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `address` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `addressAdditional` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `houseNumber` VARCHAR(255) NOT NULL,
  `postcode` VARCHAR(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `city` VARCHAR(255) NOT NULL,
  `state` VARCHAR(255) DEFAULT NULL,
  `country` VARCHAR(255) NOT NULL,
  `countryISO` CHAR(2) DEFAULT NULL,
  `phoneNumber` VARCHAR(30) DEFAULT NULL COMMENT 'Should include the + area code',
  `isActive` TINYINT(255) NOT NULL DEFAULT 1 COMMENT 'Whether these details are still the active details linked to the user. Set to 0 when replaced with new details',
  PRIMARY KEY (id, userId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Users'' billing address details as provided by the user';

ALTER TABLE `Users_BillingAddresses` 
  ADD INDEX userId(userId, isActive);

ALTER TABLE `Users_BillingAddresses` 
  ADD INDEX name(firstName, lastName);