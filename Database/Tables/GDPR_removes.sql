CREATE TABLE `GDPR_removes` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` INT(10) UNSIGNED DEFAULT NULL,
  `IPid` BIGINT(11) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Table to log which data have/should have been deleted by GDPR data removal requests';

ALTER TABLE `GDPR_removes` 
  ADD UNIQUE INDEX IPid(IPid);