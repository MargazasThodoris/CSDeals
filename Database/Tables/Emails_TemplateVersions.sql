CREATE TABLE `Emails_TemplateVersions` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` INT(10) UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `versionTimestamp` INT(10) UNSIGNED NOT NULL,
  `html` TEXT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `isSavedOnMailgun` TINYINT(255) NOT NULL DEFAULT 1,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `Emails_TemplateVersions` 
  ADD UNIQUE INDEX ver(name, versionTimestamp);