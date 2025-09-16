CREATE TABLE `Emails_Inbound` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `toAddress` VARCHAR(255) NOT NULL,
  `from` VARCHAR(255) DEFAULT NULL,
  `time` INT(11) NOT NULL,
  `contentJSON` TEXT DEFAULT NULL,
  `notes` VARCHAR(1000) DEFAULT NULL,
  PRIMARY KEY (id, toAddress)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs incoming emails to us. Received from mailgun webhook notifications.';

ALTER TABLE `Emails_Inbound` 
  ADD INDEX toAddress(toAddress);