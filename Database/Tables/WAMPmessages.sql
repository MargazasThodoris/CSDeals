CREATE TABLE `WAMPmessages` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'UNIX timestamp',
  `userid` INT(11) NOT NULL DEFAULT 0 COMMENT '->users.id',
  `data` TEXT NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Log of all messages sent to clients by SSE/Websockets';