CREATE TABLE `tblAnnouncementContext` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `announcement_id` INT(11) DEFAULT NULL,
  `user_id` INT(11) UNSIGNED DEFAULT NULL,
  `context` VARCHAR(255) NOT NULL DEFAULT 'ALL',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `tblAnnouncementContext` 
  ADD CONSTRAINT `FK_tblAnnouncementContext_announcement_id` FOREIGN KEY (announcement_id)
    REFERENCES tblAnnouncement(id) ON DELETE NO ACTION;

ALTER TABLE `tblAnnouncementContext` 
  ADD CONSTRAINT `FK_tblAnnouncementContext_user_id` FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE NO ACTION;