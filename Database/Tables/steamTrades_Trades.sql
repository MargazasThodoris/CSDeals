CREATE TABLE `steamTrades_Trades` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `botid` INT(11) NOT NULL DEFAULT 0 COMMENT '->bots.id',
  `tradeofferid` BIGINT(20) UNSIGNED NOT NULL COMMENT 'The Steam tradeoffer id',
  `userid` INT(11) NOT NULL DEFAULT 0 COMMENT '->users.id; to which user we are sending the trade',
  `tradeid` BIGINT(20) NOT NULL DEFAULT 0 COMMENT 'The Steam tradeid. This is determined when the trade has been accepted. This value is set from the API request result',
  `UUID` CHAR(36) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL COMMENT 'Used instead of id when exposing the ID publicly',
  `tradeType` TINYINT(255) DEFAULT NULL COMMENT '1=withdrawal, 2=trade bot trade,  3=return from sale',
  `toInventoryId` INT(10) UNSIGNED DEFAULT NULL COMMENT 'To which inventory the deposited items will be moved after they are identified in the bot inventory. If no items are deposited, this doesn''t have any effect.',
  `offerstate` SMALLINT(11) DEFAULT NULL COMMENT 'Steam tradeoffer state. Will be 0 if sending is pending or it has failed',
  `tradestatus` SMALLINT(11) DEFAULT NULL COMMENT 'Steam trade status',
  `offerSentTime` INT(10) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp when the tradeoffer was sent',
  `sendFailedTime` INT(10) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp when the tradeoffer was attempted to be sent and failed',
  `offerCanceledTime` INT(10) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp when the tradeoffer was cancelled if we cancelled the trade',
  `confAcceptTime` INT(10) UNSIGNED DEFAULT NULL COMMENT 'Timestamp when the tradeoffer mobile confirmation was completed. This might be zero even if the confirmation is accepted',
  `stateChangedTime` INT(10) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp when we last noticed a change to the tradeoffer state',
  `timeQueued` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'UNIX timestamp when this tradeoffer was queued (when this entry was created)',
  `cancelOfferAfterTime` INT(10) UNSIGNED DEFAULT NULL COMMENT 'If the offer is active after this amount of seconds has passed, cancel it. If not set, using the default hardcoded value. This is NOT A TIMESTAMP',
  `failReason` VARCHAR(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT 'Set if sending the offer failed',
  `domain` VARCHAR(64) DEFAULT NULL COMMENT 'from which domain the trade was generated',
  `platformId` TINYINT(255) DEFAULT 0 COMMENT '0=csdeals,1 =tradeskinsfast',
  `isCompleted` TINYINT(4) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Set to 1 when the items have been transfered',
  `itemsIdentified` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'Set to 1 when the items have been identified in the botInventories_ChangesToIdentify. This is used so we can include these items in overstock calculations',
  `tradeOfferMessage` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Message to be set into the Steam tradeoffer',
  `isActive` TINYINT(4) GENERATED ALWAYS AS (if(`offerstate` in (2,9,11),1,0)) STORED COMMENT '1 if the tradeoffer is active on Steam',
  `isAccepted` TINYINT(4) GENERATED ALWAYS AS (if(`offerstate` = 3 or `tradestatus` = 3,1,0)) STORED COMMENT '1 if the tradeoffer is accepted on Steam',
  `isInQueue` TINYINT(4) GENERATED ALWAYS AS (if(`offerstate` is null and `sendFailedTime` is null and `offerSentTime` is null,1,0)) STORED COMMENT '1 if the tradeoffer is still queued to be sent',
  `sendFailed` TINYINT(4) GENERATED ALWAYS AS (if(`sendFailedTime` > 0,1,0)) STORED COMMENT '1 if sending the tradeoffer failed',
  PRIMARY KEY (id, botid, tradeofferid, userid, tradeid),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'History of all sent Steam tradeoffers and tradeoffers queued to be sent currently';

ALTER TABLE `steamTrades_Trades` 
  ADD UNIQUE INDEX UUID(UUID);

ALTER TABLE `steamTrades_Trades` 
  ADD INDEX quickLookup(botid, offerstate, offerSentTime, sendFailedTime);

ALTER TABLE `steamTrades_Trades` 
  ADD INDEX fasterToPay(offerstate);

ALTER TABLE `steamTrades_Trades` 
  ADD INDEX unidentifiedItems(itemsIdentified, timeQueued) COMMENT 'We need this to do max stock ';

ALTER TABLE `steamTrades_Trades` 
  ADD INDEX userIdActiveOffers(userid, isActive, offerstate);

ALTER TABLE `steamTrades_Trades` 
  ADD INDEX platformId(platformId);

ALTER TABLE `steamTrades_Trades` 
  ADD INDEX timeQueued(timeQueued);

ALTER TABLE `steamTrades_Trades` 
  ADD INDEX tradeid(tradeid) COMMENT 'required to match response from GetTradeHistory API to trades here';

ALTER TABLE `steamTrades_Trades` 
  ADD INDEX tradeofferid(tradeofferid);

ALTER TABLE `steamTrades_Trades` 
  ADD INDEX queue(isInQueue, userid);

ALTER TABLE `steamTrades_Trades` 
  ADD INDEX isActive(isActive, userid);