CREATE TABLE `users_pendingAdConversions` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) NOT NULL,
  `type` INT(255) NOT NULL,
  `time` INT(11) DEFAULT NULL,
  `completeTime` INT(255) DEFAULT NULL,
  `expiryTime` INT(11) DEFAULT NULL,
  `data` TEXT DEFAULT NULL COMMENT 'this can be javascript for facebook conversions or json data for google offline conversions (CSV file)',
  `isPending` TINYINT(255) DEFAULT 1,
  PRIMARY KEY (id, userId, type)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `users_pendingAdConversions` 
  ADD INDEX typeTime(isPending, type, userId, expiryTime);