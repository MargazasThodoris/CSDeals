CREATE TABLE `user_setting` (
  `user_id` INT(11) UNSIGNED NOT NULL,
  `rule` LONGTEXT BINARY CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`rule`)),
  `time` DATETIME NOT NULL DEFAULT current_timestamp(),
  `note` TEXT DEFAULT NULL,
  `creator_id` INT(11) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (user_id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `user_setting` 
  ADD CONSTRAINT `FK_user_setting_creator_id` FOREIGN KEY (creator_id)
    REFERENCES users(id) ON DELETE NO ACTION;

ALTER TABLE `user_setting` 
  ADD CONSTRAINT `FK_user_setting_user_id` FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE NO ACTION;