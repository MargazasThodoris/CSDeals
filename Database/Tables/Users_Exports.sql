CREATE TABLE `Users_Exports` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `UUID` CHAR(36) NOT NULL,
  `userId` INT(255) NOT NULL COMMENT '->users.id',
  `type` SMALLINT(255) NOT NULL COMMENT 'Refer to source code documentation',
  `creationTime` INT(11) NOT NULL COMMENT 'UNIX timestamp',
  `completeTime` INT(255) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp',
  `fromTime` INT(10) UNSIGNED NOT NULL COMMENT 'UNIX timestamp of starting time for the selected export period',
  `toTime` INT(10) UNSIGNED NOT NULL COMMENT 'UNIX timestamp of ending time for the selected export period',
  `isComplete` INT(255) UNSIGNED NOT NULL DEFAULT 0,
  `expiryTime` INT(10) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp when the generated file is deleted',
  `isDeleted` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'set to 1 when file is deleted',
  PRIMARY KEY (id, UUID, userId, type)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Table for user generated exports';

ALTER TABLE `Users_Exports` 
  ADD UNIQUE INDEX UUID(UUID);