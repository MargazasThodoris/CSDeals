CREATE TABLE `Users_Bans` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(10) UNSIGNED NOT NULL COMMENT '->users.id;',
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'UNIX timestamp when the user was banned',
  `endTime` INT(255) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp when this ban expires',
  `removedTime` INT(255) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp when this ban was removed by an admin',
  `userReason` VARCHAR(255) DEFAULT NULL COMMENT 'Reason for the ban shown to the user',
  `adminNotes` VARCHAR(1000) DEFAULT NULL,
  `isActive` TINYINT(255) DEFAULT 1 COMMENT 'Whether the ban is still active',
  `canConfiscateBalance` TINYINT(255) DEFAULT 0 COMMENT 'Used when user charges back a payment for more than they have in their balance. OBSOLETE: For old balance system',
  `type` SMALLINT(255) NOT NULL DEFAULT 0 COMMENT '0=default (ban all actions as configured in APIs and website), 1=monetary ban (ban deposits and withdrawals and purchases)',
  PRIMARY KEY (id, userId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Stores user bans, historical and currently active';