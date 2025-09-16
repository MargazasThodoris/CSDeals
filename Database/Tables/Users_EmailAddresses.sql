CREATE TABLE `Users_EmailAddresses` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(10) UNSIGNED NOT NULL COMMENT '->users.id',
  `emailAddress` VARCHAR(1000) NOT NULL,
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'UNIX timestamp of this entry',
  `isActive` TINYINT(255) DEFAULT 1,
  PRIMARY KEY (id, userId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Stores active and historical email addresses linked to user accounts';

ALTER TABLE `Users_EmailAddresses` 
  ADD INDEX userId(userId, isActive);