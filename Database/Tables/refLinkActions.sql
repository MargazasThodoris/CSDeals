CREATE TABLE `refLinkActions` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `refLinkId` INT(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '->referralLinks.id',
  `actionid` INT(11) NOT NULL DEFAULT 0 COMMENT 'The user action. 1=login, 2=register, 3=unlogged in visit, 4=logged in visit',
  `userid` INT(11) UNSIGNED DEFAULT NULL COMMENT '->users.id; if a user is related',
  `time` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'UNIX timestamp when this action happened',
  `IPstr` VARCHAR(46) NOT NULL COMMENT 'IP of the client',
  `HTTPreferer` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id, refLinkId, actionid)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs user actions that happen after they accessed the website through a referral link';

ALTER TABLE `refLinkActions` 
  ADD INDEX refLinkId(refLinkId, time, actionid);

ALTER TABLE `refLinkActions` 
  ADD CONSTRAINT `refLinkActionsLinkId` FOREIGN KEY (refLinkId)
    REFERENCES referralLinks(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `refLinkActions` 
  ADD CONSTRAINT `refLinkActionsLinkUserId` FOREIGN KEY (userid)
    REFERENCES users(id);