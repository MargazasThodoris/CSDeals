CREATE TABLE `mailingListEmailAddresses` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mailingListId` INT(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT 'Mailing list ID in our local system',
  `IPstr` VARCHAR(46) NOT NULL COMMENT 'The IP who approved joining on the list',
  `email` VARCHAR(255) NOT NULL COMMENT 'email address',
  `time` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (id, mailingListId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Simple mailing list index for local mailing list system. When customers agree to join a mailing list, they are added here.
As of 21.12.2023, this system was never used.';