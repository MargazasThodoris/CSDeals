CREATE TABLE `Users_PenaltyFees` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) UNSIGNED NOT NULL,
  `amount` DECIMAL(8, 2) NOT NULL DEFAULT 0.00,
  `time` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  `currency` CHAR(3) NOT NULL,
  `source_balance_account` VARCHAR(25) DEFAULT NULL,
  `target_balance_account` VARCHAR(25) DEFAULT NULL,
  `request` TEXT DEFAULT NULL,
  `response` TEXT DEFAULT NULL,
  `bitcoin_value` DECIMAL(8, 2) DEFAULT 0.00,
  `status` BIT(1) NOT NULL DEFAULT b'1',
  `category` VARCHAR(255) NOT NULL DEFAULT 'INACTIVE',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `Users_PenaltyFees` 
  ADD CONSTRAINT `FK_Users_PenaltyFees_user_id` FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE NO ACTION;