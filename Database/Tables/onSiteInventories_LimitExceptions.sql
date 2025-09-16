CREATE TABLE `onSiteInventories_LimitExceptions` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(10) UNSIGNED NOT NULL COMMENT '->users.id',
  `appid` INT(11) DEFAULT NULL,
  `limit` INT(255) DEFAULT NULL COMMENT 'New limit of items',
  PRIMARY KEY (id, userId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Overrides default limit of items the user can have in their sales+on-site inventory';

ALTER TABLE `onSiteInventories_LimitExceptions` 
  ADD UNIQUE INDEX lookup(userId, appid);

ALTER TABLE `onSiteInventories_LimitExceptions` 
  ADD CONSTRAINT `onSiteInvLimitsUserId` FOREIGN KEY (userId)
    REFERENCES users(id);