CREATE TABLE `Users_AuthorizedClientIds` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) UNSIGNED NOT NULL COMMENT '->users.id',
  `clientId` CHAR(10) NOT NULL COMMENT '->WebClientIds.id',
  `country` CHAR(2) NOT NULL COMMENT 'In which country this client was authorized',
  PRIMARY KEY (id, userId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Stores client IDs (cookie) that are authorized to access a user account. If the client is not authorized, additional authorization is required to access the account.';

ALTER TABLE `Users_AuthorizedClientIds` 
  ADD INDEX `index`(userId, clientId);