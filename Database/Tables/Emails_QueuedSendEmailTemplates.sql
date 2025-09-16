CREATE TABLE `Emails_QueuedSendEmailTemplates` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `templateId` INT(11) UNSIGNED NOT NULL COMMENT '->Emails_TemplateVersions.id',
  `emailAddress` VARCHAR(300) NOT NULL,
  `subject` VARCHAR(255) NOT NULL COMMENT 'Email subject',
  `paramsId` INT(11) UNSIGNED DEFAULT NULL COMMENT '->Emails_QueuedSendEmailTemplatesParams.id',
  `time` INT(11) NOT NULL COMMENT 'UNIX timestamp when this was queued',
  `userId` INT(11) UNSIGNED DEFAULT NULL COMMENT '->users.id',
  `templateDataJSON` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Data to pass onto the template',
  `isBackgroundJob` TINYINT(255) DEFAULT 0 COMMENT 'Whether this email should be send by a daemon instead of on runtime',
  PRIMARY KEY (id),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `Emails_QueuedSendEmailTemplates` 
  ADD INDEX queue(templateId);

ALTER TABLE `Emails_QueuedSendEmailTemplates` 
  ADD CONSTRAINT `emails_queuedSendTemplates_paramsId` FOREIGN KEY (paramsId)
    REFERENCES Emails_QueuedSendEmailTemplatesParams(id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `Emails_QueuedSendEmailTemplates` 
  ADD CONSTRAINT `emails_queuedSendTemplates_templateId` FOREIGN KEY (templateId)
    REFERENCES Emails_TemplateVersions(id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `Emails_QueuedSendEmailTemplates` 
  ADD CONSTRAINT `emails_queuedSendTemplates_userId` FOREIGN KEY (userId)
    REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION;