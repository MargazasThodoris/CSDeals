CREATE TABLE `TSF_Users_ActiveSessionIds` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` INT(11) NOT NULL,
  `sessionId` VARCHAR(30) DEFAULT NULL,
  `country` CHAR(255) DEFAULT NULL,
  `time` INT(255) DEFAULT NULL,
  PRIMARY KEY (id, userid)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Used to index all users to their session IDs so we can log them out when they log in with another session ID';

ALTER TABLE `TSF_Users_ActiveSessionIds` 
  ADD INDEX userid(userid);

ALTER TABLE `TSF_Users_ActiveSessionIds` 
  ADD INDEX sessionId(sessionId);