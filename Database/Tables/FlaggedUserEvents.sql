CREATE TABLE `FlaggedUserEvents` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `time` INT(10) UNSIGNED NOT NULL,
  `type` INT(11) NOT NULL,
  `timeReviewed` INT(10) UNSIGNED DEFAULT NULL,
  `reviewedByUserId` INT(11) DEFAULT NULL,
  `isReviewed` TINYINT(1) NOT NULL,
  `manualNotes` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `reviewerActionsTaken` LONGTEXT NOT NULL COMMENT '(DC2Type:json_array)',
  `automaticActionsTaken` LONGTEXT NOT NULL COMMENT '(DC2Type:json_array)',
  `additionalDetailsJson` LONGTEXT DEFAULT NULL COMMENT '(DC2Type:json)',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci;

ALTER TABLE `FlaggedUserEvents` 
  ADD INDEX time(time);

ALTER TABLE `FlaggedUserEvents` 
  ADD INDEX isReviewed(isReviewed);