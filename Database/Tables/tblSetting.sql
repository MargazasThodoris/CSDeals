CREATE TABLE `tblSetting` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `modification_time` DATETIME NOT NULL DEFAULT current_timestamp(),
  `modified_by_user_id` INT(11) UNSIGNED NOT NULL,
  `active` BIT(1) NOT NULL DEFAULT b'0',
  `group_id` INT(11) DEFAULT 0,
  `profile_id` INT(11) NOT NULL,
  PRIMARY KEY (id, name)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `tblSetting` 
  ADD CONSTRAINT `FK_tblSetting_group_id` FOREIGN KEY (group_id)
    REFERENCES tblUserGroup(id) ON DELETE NO ACTION;

ALTER TABLE `tblSetting` 
  ADD CONSTRAINT `FK_tblSetting_profile_id` FOREIGN KEY (profile_id)
    REFERENCES tblSettingProfile(id) ON DELETE NO ACTION;