CREATE TABLE `Users_Notifications` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) UNSIGNED NOT NULL COMMENT '->users.id',
  `contentId` INT(11) NOT NULL COMMENT '->Users_NotificationsContents.id; If the text should be read from a global notification, use this',
  `channelsFlags` SMALLINT(255) DEFAULT 1 COMMENT '1=website notification, 2=email, 4=push notification, 8=sms.
Refer to source code documentation for constants',
  `timeRead` INT(255) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp',
  `isRead` TINYINT(255) GENERATED ALWAYS AS (if(`timeRead` is null,0,1)) STORED,
  PRIMARY KEY (id, userId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Log of all notifications sent to users';

ALTER TABLE `Users_Notifications` 
  ADD INDEX userId(userId, isRead);