CREATE TABLE `Giveaways_Giveaways` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `winclaimtransactionid` INT(11) NOT NULL DEFAULT 0 COMMENT 'The ID in userbalancetransaction when the win has been claimed. Temporarily set to -1 before making the transaction to make sure nothing gets doublecredited',
  `winclaimtradeid` INT(11) UNSIGNED DEFAULT NULL COMMENT 'if the win has been claimed, this is the trade id. If the offer wasn''t accepted, this will be set back to NULL',
  `name` VARCHAR(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT 'Name of the giveaway',
  `requirebonusandgroup` TINYINT(4) NOT NULL DEFAULT 1 COMMENT 'if bonus is required to join this giveaway',
  `entrycost` INT(11) NOT NULL DEFAULT 0 COMMENT 'entry cost in credits. 0 if free',
  `maxentries` INT(11) NOT NULL DEFAULT 1 COMMENT '0 for unlimited',
  `entries` INT(255) NOT NULL DEFAULT 0 COMMENT 'How many entries are in this giveaway currently. Simple counter to prevent always looking up total entries',
  `participants` INT(255) DEFAULT 0 COMMENT 'How many participants are in this giveaway currently. Simple counter to prevent always looking up total entries',
  `starttime` INT(11) NOT NULL DEFAULT 0 COMMENT 'UNIX timestamp when the giveaway was started',
  `endtime` INT(11) NOT NULL DEFAULT 0 COMMENT 'UNIX timestamp when the giveaway ends',
  `minvalue` DECIMAL(6, 2) NOT NULL DEFAULT 0.00 COMMENT 'Minimum prize in trade-tokens',
  `maxvalue` DECIMAL(6, 2) NOT NULL DEFAULT 0.00 COMMENT 'Maximum prize in trade-tokens',
  `winvalue` DECIMAL(6, 2) NOT NULL DEFAULT 0.00 COMMENT 'Prize in trade-tokens. Random value between minvalue and maxvalue.',
  `winningentryid` INT(11) NOT NULL COMMENT 'calculated when the winner is chosen. ID in the entries table',
  `giveawaygroup` INT(11) UNSIGNED DEFAULT NULL COMMENT '->Giveaways_Groups.id; Groups are used to make new giveaways when a previous one ends',
  `retweetTweetId` VARCHAR(30) DEFAULT NULL COMMENT 'If joining this requires a retweet',
  `requireFollowTwitter` TINYINT(255) DEFAULT 0,
  `requireTwitterMentionsCount` SMALLINT(255) DEFAULT 0,
  `tweetImageFileName` VARCHAR(255) DEFAULT NULL COMMENT 'from /server/twitterImages/',
  `tweetText` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Text included in the automatically posted Tweet',
  `isClaimingLocked` TINYINT(255) DEFAULT 0 COMMENT 'Set to 1 temporarily before trade is queued to prevent double withdrawals',
  PRIMARY KEY (id, winclaimtransactionid),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `Giveaways_Giveaways` 
  ADD INDEX `group`(giveawaygroup);

ALTER TABLE `Giveaways_Giveaways` 
  ADD CONSTRAINT `Giveaways_groupId` FOREIGN KEY (giveawaygroup)
    REFERENCES Giveaways_Groups(id);

ALTER TABLE `Giveaways_Giveaways` 
  ADD CONSTRAINT `Giveaways_winclaimtradeid` FOREIGN KEY (winclaimtradeid)
    REFERENCES onSiteTrades_Trades(id);