CREATE TABLE `KYC_Passed_users_volume` (
  `userId` INT(11) NOT NULL,
  `volumeEUR` DECIMAL(12, 2) DEFAULT NULL,
  PRIMARY KEY (userId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;