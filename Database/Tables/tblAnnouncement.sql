CREATE TABLE `tblAnnouncement` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `type_id` INT(11) NOT NULL,
  `title` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `text` VARCHAR(255) NOT NULL,
  `html` TINYTEXT DEFAULT NULL,
  `parameters` VARCHAR(255) DEFAULT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `tblAnnouncement` 
  ADD CONSTRAINT `FK_tblAnnouncement_type_id` FOREIGN KEY (type_id)
    REFERENCES tblAnnouncementType(id) ON DELETE NO ACTION;