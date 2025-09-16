CREATE TABLE `tblFraudRule` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(500) NOT NULL,
  `created` TIME NOT NULL DEFAULT current_timestamp(),
  `enabled` BIT(1) NOT NULL DEFAULT b'1',
  `description` VARCHAR(255) DEFAULT NULL,
  `body` LONGTEXT BINARY CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `score` INT(11) DEFAULT 0,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;