CREATE TABLE `kount_logs` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) UNSIGNED NOT NULL,
  `kount_transaction_id` VARCHAR(250) DEFAULT NULL,
  `kount_session_id` VARCHAR(250) NOT NULL,
  `payment_processor_type` VARCHAR(250) NOT NULL,
  `payment_processor_reference` VARCHAR(250) NOT NULL,
  `payment_status` INT(11) NOT NULL DEFAULT 0 COMMENT '0 - pending, 1 - paid, 2 - failed',
  `payment_status_reason` VARCHAR(250) DEFAULT NULL,
  `data` LONGTEXT BINARY CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`data`)),
  `auto` VARCHAR(25) DEFAULT NULL,
  `score` INT(11) DEFAULT NULL,
  `error_message` LONGTEXT DEFAULT NULL,
  `time_added` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `kount_logs` 
  ADD CONSTRAINT `KeyUserId` FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION;