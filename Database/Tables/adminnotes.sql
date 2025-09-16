CREATE TABLE `adminnotes` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` INT(11) DEFAULT NULL,
  `time` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  `note` TEXT DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Manual notes of important events and changes to correlate them to business performance';

ALTER TABLE `adminnotes` 
  ADD FULLTEXT INDEX IDX_adminnotes_note(note);