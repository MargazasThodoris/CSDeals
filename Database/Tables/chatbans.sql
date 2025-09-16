CREATE TABLE `chatbans` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` INT(11) UNSIGNED NOT NULL COMMENT '->users.id',
  `time` INT(11) NOT NULL DEFAULT 0 COMMENT 'UNIX timestamp of the ban',
  `duration` INT(11) NOT NULL DEFAULT 0 COMMENT '0 means permanent',
  `bannedby` INT(11) UNSIGNED DEFAULT NULL COMMENT '->users.id; banner user ID',
  `messageid` INT(11) UNSIGNED DEFAULT NULL COMMENT '->chatmessages.id; message ID of the reason. Optional',
  `reason` VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Reason to show to the user',
  `removed` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'if the ban is removed',
  PRIMARY KEY (id, userid, time, duration, removed)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `chatbans` 
  ADD CONSTRAINT `chatban_bannedby` FOREIGN KEY (bannedby)
    REFERENCES users(id) ON DELETE SET NULL ON UPDATE SET NULL;

ALTER TABLE `chatbans` 
  ADD CONSTRAINT `chatban_messageid` FOREIGN KEY (messageid)
    REFERENCES chatmessages(id) ON UPDATE SET NULL;

ALTER TABLE `chatbans` 
  ADD CONSTRAINT `chatban_userid` FOREIGN KEY (userid)
    REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE;