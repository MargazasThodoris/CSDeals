CREATE TABLE `lang_translationApplications` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(10) UNSIGNED NOT NULL COMMENT '->users.id',
  `email` VARCHAR(255) DEFAULT NULL COMMENT 'This is saved in case the user changes their email address on csdeals',
  `time` INT(10) UNSIGNED DEFAULT NULL,
  `languages` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'The languages the user applied for',
  `text` TEXT DEFAULT NULL,
  `status` SMALLINT(255) NOT NULL DEFAULT 0 COMMENT '0=pending, 1=approved, 2=disapproved',
  PRIMARY KEY (id, userId)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci,
COMMENT = 'Applications sent by users to apply for the website translation program';

ALTER TABLE `lang_translationApplications` 
  ADD CONSTRAINT `translationApplications_userId` FOREIGN KEY (userId)
    REFERENCES users(id);