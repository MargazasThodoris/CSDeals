CREATE TABLE `Users_UsedClientIds` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) UNSIGNED NOT NULL COMMENT '->users.id',
  `firstTime` INT(255) UNSIGNED NOT NULL COMMENT 'When the client id was used by this user the first time',
  `lastTime` INT(255) UNSIGNED NOT NULL COMMENT 'When the client id was used by this user the last time',
  `clientId` INT(10) UNSIGNED DEFAULT NULL COMMENT '->WebClientIds.id',
  PRIMARY KEY (id, userId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Log of all web client IDs used by users';

ALTER TABLE `Users_UsedClientIds` 
  ADD UNIQUE INDEX uniq(userId, clientId);