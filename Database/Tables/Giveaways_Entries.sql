CREATE TABLE `Giveaways_Entries` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `giveawayid` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `userid` INT(11) NOT NULL DEFAULT 0,
  `entrycount` INT(11) NOT NULL DEFAULT 1,
  `firstentrytime` INT(11) NOT NULL DEFAULT 0,
  `removedtime` INT(11) NOT NULL DEFAULT 0 COMMENT 'if the entries were removed',
  `retweetTweetId` BIGINT(20) UNSIGNED DEFAULT NULL,
  `mentionsTweetId` BIGINT(20) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (id, giveawayid, userid)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `Giveaways_Entries` 
  ADD UNIQUE INDEX uniq(giveawayid, userid, removedtime);

ALTER TABLE `Giveaways_Entries` 
  ADD INDEX userId(userid) COMMENT 'Used to find winning entires for user';