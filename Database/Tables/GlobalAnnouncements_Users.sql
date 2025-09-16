CREATE TABLE `GlobalAnnouncements_Users` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `announcementId` INT(11) UNSIGNED NOT NULL COMMENT '->GlobalAnnouncements_Announcements.id',
  `userId` INT(11) UNSIGNED NOT NULL COMMENT '->users.id',
  PRIMARY KEY (id, announcementId, userId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'The users who should be shown the global announcement';

ALTER TABLE `GlobalAnnouncements_Users` 
  ADD CONSTRAINT `GlobalAnnouncements_Users_announcementId` FOREIGN KEY (announcementId)
    REFERENCES GlobalAnnouncements_Announcements(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `GlobalAnnouncements_Users` 
  ADD CONSTRAINT `GlobalAnnouncements_Users_userid` FOREIGN KEY (userId)
    REFERENCES users(id);