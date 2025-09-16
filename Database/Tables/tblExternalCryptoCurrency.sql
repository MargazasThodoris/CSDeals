CREATE TABLE `tblExternalCryptoCurrency` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `symbol` CHAR(3) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;