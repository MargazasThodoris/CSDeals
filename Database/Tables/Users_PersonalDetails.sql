CREATE TABLE `Users_PersonalDetails` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) UNSIGNED NOT NULL COMMENT '->users.id',
  `time` INT(11) NOT NULL COMMENT 'UNIX timestamp of this entry',
  `dateOfBirth` DATE NOT NULL,
  `nationality` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `birthCountry` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `isActive` TINYINT(255) NOT NULL DEFAULT 1 COMMENT 'Whether these details are still the active details linked to the user. Set to 0 when replaced with new details',
  PRIMARY KEY (id, userId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Personal details of users as submitted by the user.';

ALTER TABLE `Users_PersonalDetails` 
  ADD INDEX userId(userId, isActive);