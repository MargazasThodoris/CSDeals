CREATE TABLE `Emails_UnsubscribeClicks` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) UNSIGNED NOT NULL COMMENT '->users.id',
  `emailAddress` VARCHAR(320) NOT NULL,
  `creationTime` INT(255) UNSIGNED NOT NULL,
  `clickTime` INT(255) UNSIGNED DEFAULT NULL,
  `templateId` INT(11) UNSIGNED DEFAULT NULL COMMENT '->Emails_TemplateVersions.id',
  PRIMARY KEY (id, userId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs clicks on the unsubscribe link on outgoing emails';

ALTER TABLE `Emails_UnsubscribeClicks` 
  ADD CONSTRAINT `Emails_UnsubscribeClicks_templateId` FOREIGN KEY (templateId)
    REFERENCES Emails_TemplateVersions(id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `Emails_UnsubscribeClicks` 
  ADD CONSTRAINT `Emails_UnsubscribeClicks_userId` FOREIGN KEY (userId)
    REFERENCES users(id);