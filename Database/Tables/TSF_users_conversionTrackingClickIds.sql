CREATE TABLE `TSF_users_conversionTrackingClickIds` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) NOT NULL,
  `cookieType` TINYINT(4) NOT NULL,
  `timeAdded` INT(10) UNSIGNED NOT NULL,
  `value` VARCHAR(255) NOT NULL,
  PRIMARY KEY (id, userId, cookieType)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `TSF_users_conversionTrackingClickIds` 
  ADD UNIQUE INDEX uniq(userId, cookieType, value);