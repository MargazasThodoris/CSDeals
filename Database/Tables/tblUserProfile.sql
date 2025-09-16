CREATE TABLE `tblUserProfile` (
  `user_id` INT(11) UNSIGNED NOT NULL,
  `is_suspicious` BIT(1) NOT NULL DEFAULT b'0',
  `is_kyc` BIT(1) NOT NULL DEFAULT b'0',
  `is_kyt` BIT(1) NOT NULL DEFAULT b'0',
  `is_tradelocked` BIT(1) NOT NULL DEFAULT b'0',
  `is_whitelisted` BIT(1) DEFAULT b'0',
  PRIMARY KEY (user_id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `tblUserProfile` 
  ADD CONSTRAINT `FK_tblUserProfile_user_id` FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE NO ACTION;