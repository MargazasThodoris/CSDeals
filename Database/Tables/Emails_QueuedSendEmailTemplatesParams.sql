CREATE TABLE `Emails_QueuedSendEmailTemplatesParams` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `paramsJSON` TEXT DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Params to be passed onto mailgun API for sending the email. Separated from tables Emails_FailedSentEmailTemplates, Emails_QueuedSendEmailTemplates, Emails_SentEmailTemplates, so that we can share the same data between them';