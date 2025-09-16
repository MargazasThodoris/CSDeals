CREATE TABLE `Users_AwaitingEmailAddressVerifications` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) UNSIGNED NOT NULL COMMENT '->users.id',
  `emailAddress` VARCHAR(320) DEFAULT NULL,
  `time` INT(10) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestmap of this entry',
  `isCanceled` TINYINT(255) DEFAULT 0,
  `isExpired` TINYINT(255) GENERATED ALWAYS AS (if(`time` > unix_timestamp() - 3600 * 8,0,1)) VIRTUAL,
  PRIMARY KEY (id, userId),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Email addresses are deleted from here when they are verified and left here and marked isCanceled if the user either links another email address before verifying or if they never verify.';

ALTER TABLE `Users_AwaitingEmailAddressVerifications` 
  ADD INDEX user(userId, isCanceled);