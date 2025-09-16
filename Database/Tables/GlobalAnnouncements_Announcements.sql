CREATE TABLE `GlobalAnnouncements_Announcements` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` INT(10) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp',
  `HTML` TEXT DEFAULT NULL COMMENT 'Inner HTML content of the announcement',
  `class` VARCHAR(255) DEFAULT NULL COMMENT 'HTML classes that should be used for the announcement HTML element',
  `isActive` TINYINT(255) DEFAULT 1 COMMENT 'Whether the announcement is still active and visible on the site',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Contents of global announcements';

ALTER TABLE `GlobalAnnouncements_Announcements` 
  ADD INDEX isActive(isActive);