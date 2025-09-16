CREATE TABLE `Support_SupportTickets` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` INT(10) UNSIGNED NOT NULL,
  `status` SMALLINT(255) NOT NULL DEFAULT 0,
  `title` VARCHAR(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'Contact request title submitted by user',
  `content` TEXT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'Contact request content submitted by user',
  `emailAddress` VARCHAR(255) DEFAULT NULL COMMENT 'Email address submitted by user',
  `userId` INT(10) UNSIGNED DEFAULT NULL COMMENT '->users.id; Set if the user was logged in',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Log of submitted Contact Us forms';

ALTER TABLE `Support_SupportTickets` 
  ADD INDEX userId(userId);