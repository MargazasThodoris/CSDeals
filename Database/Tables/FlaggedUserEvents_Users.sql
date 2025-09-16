CREATE TABLE `FlaggedUserEvents_Users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `userId` INT(10) UNSIGNED NOT NULL,
  `banId` INT(255) UNSIGNED DEFAULT NULL,
  `flaggedUserEventId` INT(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci;

ALTER TABLE `FlaggedUserEvents_Users` 
  ADD INDEX IDX_5CA3EC426236898E(flaggedUserEventId);

ALTER TABLE `FlaggedUserEvents_Users` 
  ADD INDEX userId(userId);

ALTER TABLE `FlaggedUserEvents_Users` 
  ADD CONSTRAINT `FK_5CA3EC426236898E` FOREIGN KEY (flaggedUserEventId)
    REFERENCES FlaggedUserEvents(id);