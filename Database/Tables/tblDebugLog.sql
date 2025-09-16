CREATE TABLE `tblDebugLog` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `info` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `time` DATETIME DEFAULT current_timestamp(),
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;