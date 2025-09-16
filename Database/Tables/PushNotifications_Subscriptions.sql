CREATE TABLE `PushNotifications_Subscriptions` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `endpoint` VARCHAR(1000) NOT NULL,
  `publicKey` CHAR(88) NOT NULL,
  `authToken` CHAR(22) NOT NULL,
  `sessionId` VARCHAR(30) NOT NULL COMMENT 'PHP session ID',
  `subscribeTime` INT(10) UNSIGNED DEFAULT NULL,
  `lastSeen` INT(255) UNSIGNED DEFAULT NULL,
  `userId` INT(11) UNSIGNED DEFAULT NULL COMMENT '->users.id; stored in case the user logs out, but then keep this so we can send notifications to the user even if they are no longer logged in on the session (if sessionid is not in Users_ActiveSessionIds)',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Stores details about subscribed Push notification browser clients. Look more into Push API: https://developer.mozilla.org/en-US/docs/Web/API/Push_API ';

ALTER TABLE `PushNotifications_Subscriptions` 
  ADD INDEX sessionid(sessionId);

ALTER TABLE `PushNotifications_Subscriptions` 
  ADD INDEX endpoint(endpoint);

ALTER TABLE `PushNotifications_Subscriptions` 
  ADD INDEX search(userId);

ALTER TABLE `PushNotifications_Subscriptions` 
  ADD CONSTRAINT `pushNotificationsSubUserId` FOREIGN KEY (userId)
    REFERENCES users(id);