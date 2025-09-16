CREATE TABLE `chatmessages` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `roomid` TINYINT(4) NOT NULL DEFAULT 1 COMMENT '0=global system messages, 1=english, 2=russian, 3=chinese, 11=trade, 10=offerwalls',
  `userid` INT(11) UNSIGNED DEFAULT NULL COMMENT '->users.id',
  `time` INT(11) NOT NULL DEFAULT 0 COMMENT 'UNIX timestamp of the message',
  `message` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '0' COMMENT 'Message to show in the chat',
  `uncensoredmessage` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'only set if something was censored',
  `removed` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'if the message is removed',
  PRIMARY KEY (id, roomid),
  INDEX id(id),
  INDEX id_2(id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci,
COMMENT = 'Website chat messages';

ALTER TABLE `chatmessages` 
  ADD CONSTRAINT `chatmessages_userid` FOREIGN KEY (userid)
    REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION;