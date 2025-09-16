CREATE TABLE `users` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `steamid` BIGINT(20) UNSIGNED NOT NULL,
  `UUID` CHAR(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `lastaction` INT(11) NOT NULL DEFAULT 0 COMMENT 'When was the user''s last action',
  `balance` DECIMAL(10, 4) NOT NULL DEFAULT 0.0000 COMMENT 'user trade-tokens',
  `USDBalance` DECIMAL(10, 4) NOT NULL DEFAULT 0.0000 COMMENT 'real money balance in old VirtuTrade system before Adyen',
  `balanceBTC` DECIMAL(12, 8) NOT NULL DEFAULT 0.00000000 COMMENT 'User''s Bitcoin balance',
  `balanceStableCryptoUSD` DECIMAL(14, 4) NOT NULL DEFAULT 0.0000 COMMENT 'Convert to and from `balanceBTC`. Use 4 decimals so we can add and deduct EUR values accurately while they are converted to USD',
  `balanceAdyenIndividualAvailableEur` DECIMAL(8, 2) NOT NULL DEFAULT 0.00 COMMENT 'Locally cached balance of user''s EUR BalanceAccount. Refreshed from Adyen balance change webhooks',
  `balanceAdyenIndividualReservedEur` DECIMAL(8, 2) NOT NULL DEFAULT 0.00 COMMENT 'Locally cached reserved balance of user''s EUR BalanceAccount. Refreshed from Adyen balance change webhooks.',
  `balanceAdyenIndividualAvailableUsd` DECIMAL(8, 2) NOT NULL DEFAULT 0.00 COMMENT 'Locally cached balance of user''s USD BalanceAccount. Refreshed from Adyen balance change webhooks',
  `balanceAdyenIndividualReservedUsd` DECIMAL(8, 2) NOT NULL COMMENT 'Locally cached reserved balance of user''s USD BalanceAccount. Refreshed from Adyen balance change webhooks.',
  `adyenIndividualBalanceAccountEurLocalId` INT(255) DEFAULT NULL COMMENT 'Adyen_BalanceAccounts.id',
  `adyenIndividualBalanceAccountUsdLocalId` INT(11) DEFAULT NULL COMMENT 'Adyen_BalanceAccounts.id',
  `adyenIndividualBalanceAccountPayoutFxLocalId` INT(255) DEFAULT NULL COMMENT 'Adyen_BalanceAccounts.id',
  `adyenBusinessBalanceAccountEurLocalId` INT(255) DEFAULT NULL COMMENT 'unused. For the future if we set up Adyen business accounts so that one business may have multiple CS.Deals accounts. Additionally business balance is separate from individual balance.',
  `adyenBusinessBalanceAccountUsdLocalId` INT(11) DEFAULT NULL COMMENT 'unused. For the future if we set up Adyen business accounts so that one business may have multiple CS.Deals accounts. Additionally business balance is separate from individual balance.',
  `adyenBusinessBalanceAccountPayoutFxLocalId` INT(255) DEFAULT NULL COMMENT 'unused. For the future if we set up Adyen business accounts so that one business may have multiple CS.Deals accounts. Additionally business balance is separate from individual balance.',
  `adyenIndividualLegalEntityLocalId` INT(255) UNSIGNED DEFAULT NULL COMMENT 'Adyen_LegalEntities.id',
  `adyenIndividualAccountHolderLocalId` INT(255) DEFAULT NULL COMMENT 'Adyen_AccountHolders.id',
  `adyenBusinessLegalEntityLocalId` INT(255) UNSIGNED DEFAULT NULL COMMENT 'unused. For the future if we set up Adyen business accounts so that one business may have multiple CS.Deals accounts. Additionally business balance is separate from individual balance',
  `adyenBusinessAccountHolderLocalId` INT(255) DEFAULT NULL COMMENT 'unused. For the future if we set up Adyen business accounts so that one business may have multiple CS.Deals accounts. Additionally business balance is separate from individual balance',
  `adyenIndividualIsBalanceRestricted` TINYINT(255) NOT NULL DEFAULT 1 COMMENT 'Updated from webhooks sent by Adyen regarding account capabilities',
  `adyenBusinessIsBalanceRestricted` TINYINT(255) NOT NULL DEFAULT 1 COMMENT 'unused. For the future if we set up Adyen business accounts so that one business may have multiple CS.Deals accounts. Additionally business balance is separate from individual balance.',
  `adyenIndividualIsVerifiedForReceivingPayments` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'Updated from webhooks sent by Adyen regarding account capabilities',
  `adyenBusinessIsVerifiedForReceivingPayments` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'unused. For the future if we set up Adyen business accounts so that one business may have multiple CS.Deals accounts. Additionally business balance is separate from individual balance',
  `adyenStoredPaymentMethodTokensArray` VARCHAR(1024) DEFAULT NULL,
  `lastCountry` CHAR(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'used to mark the buyer country in sales. Updated from the IP address when user loads a webpage',
  `isadmin` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'if this user is an admin',
  `ismod` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'if the user is a moderator',
  `forceEnableUsernameBonus` TINYINT(4) NOT NULL DEFAULT 0,
  `overrideMarketplaceSalesFee` DECIMAL(4, 3) UNSIGNED DEFAULT NULL COMMENT 'Example: set to 0.01 to set the user''s sales fee at 1% for real money sales. NULL for default sales fee',
  `lastcached` INT(11) NOT NULL DEFAULT 0 COMMENT 'When the user profile was last loaded. used for giveaways, updating name and such.',
  `lastnamecached` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `lastcacheattempt` INT(10) UNSIGNED NOT NULL,
  `tradetoken` CHAR(8) DEFAULT NULL COMMENT 'Token for the Steam trade-URL',
  `personaname` VARCHAR(32) NOT NULL COMMENT 'Nickname of the Steam account',
  `customurl` VARCHAR(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT 'vanity url name of the Steam account',
  `avatarurl` VARCHAR(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT 'URL of the Steam avatar',
  `steamAccountTimeCreated` INT(255) UNSIGNED DEFAULT NULL,
  `credits` INT(11) NOT NULL DEFAULT 0 COMMENT 'User can use these for giveaways. Gained from selling/buying/trading',
  `exp` INT(10) UNSIGNED NOT NULL COMMENT 'Gained from selling/buying/trading, determines the level of the user',
  `level` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Level of account on CS.Deals. Just for shows. Calculated from exp column every time the user gets exp',
  `tradeCooldownTillTime` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'If the Steam account is untradable, we set this value so we prevent the user from trying to make trades to prevent us from making unnecessary requests to Steam',
  `offerTrustPoints` INT(11) NOT NULL DEFAULT 0 COMMENT 'User gets 10000 trust points for each dollar earned on offers',
  `expbeforegiveaway` INT(11) NOT NULL DEFAULT 0 COMMENT 'how much exp the user had when the gleam giveaway started',
  `giveawayexpclaimed` INT(11) NOT NULL DEFAULT 0 COMMENT 'how much exp has been used for the ongoing giveaway',
  `selectedLanguageID` TINYINT(4) NOT NULL DEFAULT 1 COMMENT 'languages.id. Which language the user is using on the website',
  `steamlevel` MEDIUMINT(9) DEFAULT NULL COMMENT 'Level of the Steam account',
  `friendCount` SMALLINT(255) DEFAULT NULL COMMENT 'Number of friends on Steam',
  `ownscsgo` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'If the user owns CSGO on their Steam account',
  `isBannedFromGiveaways` TINYINT(255) NOT NULL DEFAULT 0,
  `timeadded` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'When the user was created',
  `isingroup` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'is he in the main cs.deals group',
  `isingroup2` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'If the user is in the CSGO88 group',
  `lastinventoryattempt` INT(11) NOT NULL DEFAULT 0 COMMENT 'used so people don''t spam to load inventories',
  `inventorycachetime` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'When the user''s Steam inventory was last cached',
  `lastfailedgiveawayjoin` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'when the user last time unsuccessfully tried to join a giveaway',
  `additionalKillswitchTolerance` DECIMAL(8, 2) NOT NULL DEFAULT 0.00 COMMENT 'If set, user can earn this much more before the killswitch is triggered',
  `ignorekillswitches` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'If set, normal security killswitches won''t be triggered by this user',
  `stealBack` DECIMAL(8, 4) NOT NULL DEFAULT 0.0000 COMMENT 'This is a temporary field. If set, if the user trades value in, it won''t be credited if we still have value left in this field',
  `referrerLockedTillTime` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'when this time comes, the referrerUserId will be reset',
  `referrerUserId` INT(10) UNSIGNED DEFAULT NULL COMMENT 'used for paying out commissions for this user. Automatically unset by a cron script',
  `favoriteSteamAppId` INT(10) UNSIGNED DEFAULT NULL COMMENT 'Used to autoselect this app when listing items for sale',
  `peakSteamInvValue` DECIMAL(10, 2) DEFAULT NULL COMMENT 'Used to store the highest price we''ve ever seen for the user''s inventory. Used for trust factor',
  `totalPurchases30dUSD` DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
  `totalSales30dUSD` DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
  `emailAddress` VARCHAR(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'current active email address saved on the account',
  `requireVerificationForSEPACashout` TINYINT(255) DEFAULT 0,
  `isMarketplaceStorePublic` TINYINT(255) DEFAULT 0,
  `2FAauthSecret` CHAR(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `2FAenableTime` INT(255) DEFAULT NULL,
  `2FAdisableAfterTime` INT(255) DEFAULT NULL COMMENT 'The 2FA can''t be disabled instantly, instead it will take 3 days to get disabled',
  `2FArequireOnce` TINYINT(255) DEFAULT 0 COMMENT 'Only require once per session',
  `verificationCompleteTime` INT(10) UNSIGNED DEFAULT NULL COMMENT 'When the in-house ID document verification was completed',
  `thirdPartyVerificationLevel` INT(255) UNSIGNED NOT NULL DEFAULT 0 COMMENT '1 means IDs have been verified of the user by a third party (Trulioo)',
  `thirdPartyVerificationIsPendingReview` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'This is set to 1 if Trulioo sends status=REVIEW. Set to 0 manually after document is reviewed',
  `totalBitcoinDepositsEUR` DECIMAL(11, 2) NOT NULL DEFAULT 0.00 COMMENT 'How much user has deposited in BTC after Adyen integration. Value in EUR',
  `totalCryptoSalesEUR` DECIMAL(11, 2) NOT NULL DEFAULT 0.00 COMMENT 'After 1000€ is reached, require KYC from this user to list more items for sale for crypto',
  `allowAdditonalPaypalAddressPayment` TINYINT(255) DEFAULT 0 COMMENT 'if 1, the user can deposit from a third paypal address within 3 days without getting banned and then set back to 0',
  `businessAccountDetailsId` INT(255) UNSIGNED DEFAULT NULL COMMENT 'Obsolete. For old balance system. Used for cashout and invoice details',
  `businessId` INT(11) DEFAULT NULL COMMENT 'Users_BusinessDetails.id. Many users can have the same business',
  `isAccountClosed` TINYINT(255) DEFAULT 0 COMMENT 'If the account is closed, the user can''t log into it',
  `accountClosedTime` INT(10) UNSIGNED DEFAULT NULL COMMENT 'added on 23.11.2021',
  `is2FAenabled` TINYINT(255) GENERATED ALWAYS AS (if(`2FAenableTime` <> 0 and (`2FAdisableAfterTime` is null or `2FAdisableAfterTime` > unix_timestamp()),1,0)) VIRTUAL,
  `isFlaggedHighRisk` TINYINT(255) DEFAULT 0 COMMENT 'Disable all monetary actions to this account. Account was accessed from a high risk country',
  `isMonetaryActionsRestricted` TINYINT(255) DEFAULT 0 COMMENT 'User won''t be able to make payments or payouts. Flagged by suspicious activity and removed by admins',
  `shouldBanAfterLargeSale` TINYINT(255) DEFAULT 0 COMMENT 'Used to ban scammers who steal balance from users',
  `usePseudonymInChat` TINYINT(255) DEFAULT 1,
  `pseudonym` VARCHAR(255) DEFAULT NULL COMMENT 'Automatically generated pseudonym for the user to hide their identity in the website chat',
  `chatName` VARCHAR(255) GENERATED ALWAYS AS (if(`usePseudonymInChat` <> 0 and `pseudonym` is not null,`pseudonym`,`personaname`)) VIRTUAL,
  `allow_notification_itemsale_push` TINYINT(255) DEFAULT 1 COMMENT 'Send push notification on item sales',
  `allow_notification_itemsale_email` TINYINT(255) DEFAULT 1,
  `allow_notification_deposit_push` TINYINT(255) DEFAULT 1,
  `allow_notification_deposit_email` TINYINT(255) DEFAULT 1,
  `allow_notification_cashout_email` TINYINT(255) DEFAULT 1,
  `allow_notification_security_push` TINYINT(255) DEFAULT 1,
  `allow_notification_login_push` TINYINT(255) DEFAULT 1,
  `allow_notification_login_email` TINYINT(255) DEFAULT 1,
  `allow_notification_news_email` TINYINT(255) DEFAULT 1,
  `allow_notification_giveaway_push` TINYINT(255) DEFAULT 1,
  `allow_notification_giveaway_email` TINYINT(255) DEFAULT 1,
  `allow_notification_other_push` TINYINT(255) DEFAULT 1,
  `allow_notification_other_email` TINYINT(255) DEFAULT 1,
  `bridge_auth_token` TEXT DEFAULT NULL,
  PRIMARY KEY (id, steamid, UUID),
  UNIQUE INDEX UK_users_id(id),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci,
COMMENT = 'Website user accounts';

ALTER TABLE `users` 
  ADD UNIQUE INDEX steamid(steamid);

ALTER TABLE `users` 
  ADD UNIQUE INDEX UUID(UUID);

ALTER TABLE `users` 
  ADD INDEX emailAddress(emailAddress);

ALTER TABLE `users` 
  ADD INDEX adyenIndividualLegalEntityId(adyenIndividualLegalEntityLocalId);

ALTER TABLE `users` 
  ADD INDEX adyenBusinessLegalEntityId(adyenBusinessLegalEntityLocalId);

ALTER TABLE `users` 
  ADD INDEX adyenIndividualBalanceAccountUsdId(adyenIndividualBalanceAccountUsdLocalId);

ALTER TABLE `users` 
  ADD INDEX adyenBusinessBalanceAccountUsdId(adyenBusinessBalanceAccountUsdLocalId);

ALTER TABLE `users` 
  ADD INDEX adyenIndividualBalanceAccountEurId(adyenIndividualBalanceAccountEurLocalId);

ALTER TABLE `users` 
  ADD INDEX adyenBusinessBalanceAccountEurId(adyenBusinessBalanceAccountEurLocalId);

ALTER TABLE `users` 
  ADD CONSTRAINT `userToBusiness` FOREIGN KEY (businessAccountDetailsId)
    REFERENCES Users_BusinessAccountDetails_newtemplate(id);