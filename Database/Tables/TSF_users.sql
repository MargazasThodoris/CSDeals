CREATE TABLE `TSF_users` (
  `id` INT(11) UNSIGNED NOT NULL,
  `steamid` BIGINT(20) UNSIGNED NOT NULL,
  `lastaction` INT(11) NOT NULL DEFAULT 0 COMMENT 'When was the user''s last action',
  `TSFbalance` DECIMAL(10, 4) NOT NULL DEFAULT 0.0000,
  `lastCountry` CHAR(2) DEFAULT NULL COMMENT 'used to mark the buyer country in sales',
  `isadmin` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'if this user is an admin',
  `ismod` TINYINT(4) NOT NULL DEFAULT 0,
  `forceEnableUsernameBonus` TINYINT(4) NOT NULL DEFAULT 0,
  `tradetoken` CHAR(8) DEFAULT NULL,
  `lastcached` INT(11) NOT NULL DEFAULT 0 COMMENT 'When the user profile was last loaded. used for giveaways, updating name and such.',
  `lastnamecached` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `lastcacheattempt` INT(10) UNSIGNED NOT NULL,
  `personaname` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `customurl` VARCHAR(64) NOT NULL DEFAULT '',
  `avatarurl` VARCHAR(256) NOT NULL DEFAULT '',
  `credits` INT(11) NOT NULL DEFAULT 0,
  `exp` INT(10) UNSIGNED NOT NULL,
  `level` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
  `tradeCooldownTillTime` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `expbeforegiveaway` INT(11) NOT NULL DEFAULT 0 COMMENT 'how much exp the user had when the gleam giveaway started',
  `giveawayexpclaimed` INT(11) NOT NULL DEFAULT 0 COMMENT 'how much exp has been used for the ongoing giveaway',
  `selectedLanguageID` TINYINT(4) NOT NULL DEFAULT 1,
  `steamlevel` MEDIUMINT(9) DEFAULT NULL,
  `friendCount` SMALLINT(255) DEFAULT NULL,
  `ownscsgo` TINYINT(4) NOT NULL DEFAULT 0,
  `bantime` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'when the user was banned. If banned and the user sends a trade offer, the user will be blocked by the bot and the offer will be declined.',
  `timeadded` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `isingroup` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'is he in the main tradeskinsfast group',
  `lastinventoryattempt` INT(11) NOT NULL DEFAULT 0 COMMENT 'used so people don''t spam to load inventories',
  `inventorycachetime` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `additionalKillswitchTolerance` DECIMAL(8, 2) NOT NULL DEFAULT 0.00 COMMENT 'If set, user can earn this much more before the killswitch is triggered',
  `ignorekillswitches` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'If set, normal security killswitches won''t be triggered by this user',
  `stealBack` DECIMAL(8, 4) NOT NULL DEFAULT 0.0000 COMMENT 'This is a temporary field. If set, if the user trades value in, it won''t be credited if we still have value left in this field',
  `referrerLockedTillTime` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'when this time comes, the referrerUserId will be reset',
  `referrerUserId` INT(10) UNSIGNED DEFAULT NULL COMMENT 'used for paying out commissions for this user. Automatically unset by a cron script',
  `peakSteamInvValue` DECIMAL(10, 2) DEFAULT NULL COMMENT 'Used to store the highest price we''ve ever seen for the user''s inventory. Used for trust factor',
  `emailAddress` VARCHAR(1000) DEFAULT NULL,
  `2FAauthSecret` CHAR(16) DEFAULT NULL,
  `2FAenableTime` INT(255) DEFAULT NULL,
  `2FAdisableAfterTime` INT(255) DEFAULT NULL COMMENT 'The 2FA can''t be disabled instantly, instead it will take 3 days to get disabled',
  `2FArequireOnce` TINYINT(255) DEFAULT 0 COMMENT 'Only require once per session',
  `isAccountClosed` TINYINT(255) DEFAULT 0,
  `is2FAenabled` TINYINT(255) GENERATED ALWAYS AS (if(`2FAenableTime` <> 0 and (`2FAdisableAfterTime` is null or `2FAdisableAfterTime` > unix_timestamp()),1,0)) VIRTUAL,
  PRIMARY KEY (id, steamid)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_general_ci,
COMMENT = 'Users from the keyvendor group and friends will be automatically added to this table. isfriend and isgroup columns will be updated on an interval.';

ALTER TABLE `TSF_users` 
  ADD UNIQUE INDEX steamid(steamid);

ALTER TABLE `TSF_users` 
  ADD UNIQUE INDEX id(id);

ALTER TABLE `TSF_users` 
  ADD CONSTRAINT `tsfUserId` FOREIGN KEY (id)
    REFERENCES users(id);