CREATE TABLE `Users_AuthorizedTwitterAccounts` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) UNSIGNED NOT NULL COMMENT '->users.id',
  `time` INT(255) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp of this entry',
  `timeUnauthorized` INT(255) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp when the user unauthorized this token',
  `oauth_token` VARCHAR(255) DEFAULT NULL COMMENT 'As received from Twitter',
  `oauth_token_secret` VARCHAR(255) DEFAULT NULL COMMENT 'As received from Twitter',
  `twitter_user_id` BIGINT(20) UNSIGNED DEFAULT NULL COMMENT 'As received from Twitter',
  `screen_name` VARCHAR(255) DEFAULT NULL COMMENT 'As received from Twitter',
  `isActive` TINYINT(255) GENERATED ALWAYS AS (if(`timeUnauthorized` is null,1,0)) STORED COMMENT 'Whether the authorization is still valid',
  PRIMARY KEY (id, userId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Links user accounts to Twitter account authorizations';

ALTER TABLE `Users_AuthorizedTwitterAccounts` 
  ADD INDEX twitter_user_id(twitter_user_id);

ALTER TABLE `Users_AuthorizedTwitterAccounts` 
  ADD INDEX userId(userId, isActive);

ALTER TABLE `Users_AuthorizedTwitterAccounts` 
  ADD CONSTRAINT `twitterUserId` FOREIGN KEY (userId)
    REFERENCES users(id);