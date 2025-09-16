CREATE TABLE `Emails_SentEmailTemplates` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `templateId` INT(11) UNSIGNED NOT NULL COMMENT '->Emails_TemplateVersions.id',
  `emailAddress` VARCHAR(300) NOT NULL,
  `timeQueued` INT(10) UNSIGNED NOT NULL,
  `timeSent` INT(10) UNSIGNED NOT NULL,
  `userId` INT(11) UNSIGNED DEFAULT NULL COMMENT '->users.id',
  `templateDataJSON` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs sent template emails (transactional emails).';

ALTER TABLE `Emails_SentEmailTemplates` 
  ADD INDEX user(userId);

ALTER TABLE `Emails_SentEmailTemplates` 
  ADD INDEX email(emailAddress);

ALTER TABLE `Emails_SentEmailTemplates` 
  ADD CONSTRAINT `emails_SentEmailTemplates_templateId` FOREIGN KEY (templateId)
    REFERENCES Emails_TemplateVersions(id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `Emails_SentEmailTemplates` 
  ADD CONSTRAINT `emails_SentEmailTemplates_userid` FOREIGN KEY (userId)
    REFERENCES users(id);