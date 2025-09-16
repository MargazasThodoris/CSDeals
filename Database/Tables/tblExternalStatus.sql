CREATE TABLE `tblExternalStatus` (
  `id` INT(11) NOT NULL,
  `code` VARCHAR(255) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;