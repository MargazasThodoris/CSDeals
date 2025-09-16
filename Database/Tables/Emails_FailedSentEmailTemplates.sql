CREATE TABLE `Emails_FailedSentEmailTemplates` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `templateId` INT(11) UNSIGNED NOT NULL COMMENT '->Emails_TemplateVersions.id',
  `emailAddress` VARCHAR(300) NOT NULL,
  `subject` VARCHAR(255) NOT NULL,
  `paramsJSON` TEXT DEFAULT NULL COMMENT 'Parameters passed onto mailgun',
  `time` INT(11) NOT NULL,
  `userId` INT(11) UNSIGNED DEFAULT NULL COMMENT '->users.id; To which user this email was to be sent',
  `templateDataJSON` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Data used to hydrate the template',
  `sendErrorMessage` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs emails that failed to be sent using mailgun and our own templates';

ALTER TABLE `Emails_FailedSentEmailTemplates` 
  ADD INDEX queue(templateId);

ALTER TABLE `Emails_FailedSentEmailTemplates` 
  ADD CONSTRAINT `Emails_FailedSends_TempalteId` FOREIGN KEY (templateId)
    REFERENCES Emails_TemplateVersions(id);

ALTER TABLE `Emails_FailedSentEmailTemplates` 
  ADD CONSTRAINT `Emails_FailedSends_userId` FOREIGN KEY (userId)
    REFERENCES users(id);