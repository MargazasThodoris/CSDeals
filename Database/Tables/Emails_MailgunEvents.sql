CREATE TABLE `Emails_MailgunEvents` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `event` VARCHAR(255) NOT NULL,
  `time` INT(11) NOT NULL,
  `messageSender` VARCHAR(255) DEFAULT NULL,
  `messageRecipients` VARCHAR(255) DEFAULT NULL,
  `messageSubject` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `messageBody` TEXT CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `messageBodyPlain` TEXT CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `deliveryFailed` TINYINT(255) DEFAULT 0,
  `eventDataJSON` TEXT DEFAULT NULL,
  PRIMARY KEY (id, event)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs all webhook notifications sent to us by mailgun';

ALTER TABLE `Emails_MailgunEvents` 
  ADD INDEX event(event);

ALTER TABLE `Emails_MailgunEvents` 
  ADD INDEX recipient(messageRecipients);

ALTER TABLE `Emails_MailgunEvents` 
  ADD INDEX sender(messageSender);