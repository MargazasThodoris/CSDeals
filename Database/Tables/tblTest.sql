CREATE TABLE `tblTest` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) DEFAULT NULL,
  `time` BIGINT(20) NOT NULL DEFAULT unix_timestamp(),
  `remove_time` BIGINT(20) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `tblTest` 
  ADD CONSTRAINT `CK_tblTest` CHECK (`remove_time` - `time` > 5 or `remove_time` is null);