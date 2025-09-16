CREATE TABLE `onSiteTrades_Trades` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `toUserId` INT(10) UNSIGNED NOT NULL COMMENT '->users.id; To whom the trade is sent',
  `UUID` CHAR(36) DEFAULT NULL COMMENT 'Trade UUID. Expose this instead of id to users.',
  `tradeType` VARCHAR(255) DEFAULT NULL COMMENT '1=withdrawal, 2=trade bot trade,  3=return from sale',
  `parentSteamTradeId` INT(10) UNSIGNED DEFAULT NULL COMMENT '->steamTrades_Trades.id;
If this is an additional onsitetrade on the side of a steam trade offer, this will be set to the id in tradeoffers table',
  `fromUserId` INT(10) UNSIGNED DEFAULT NULL COMMENT '->users.id; NULL if the trade is from the website',
  `toSenderInventoryId` INT(10) UNSIGNED NOT NULL COMMENT '->onSiteInventories_Inventories.id; To which inventory to deliver the trade recipient''s items in the trade',
  `toRecipientInventoryId` INT(255) UNSIGNED NOT NULL COMMENT '->onSiteInventories_Inventories.id; To which inventory to deliver the trade sender''s items in the trade',
  `state` SMALLINT(6) NOT NULL DEFAULT 0 COMMENT '0=active, 1=accepted, 2=declined, 3=canceled, 4=waiting for trade bot trade to complete, 5=canceled because trade offer was not completed. Refer to the source code documentation for more state constants',
  `time` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'UNIX timestamp of when the trade was sent',
  `message` VARCHAR(64) NOT NULL DEFAULT '' COMMENT 'Message in the trade',
  `autoAccept` TINYINT(4) NOT NULL COMMENT 'Flag 1/0. Trades with a linked steam trade offer will be autoaccepted',
  `reserveItems` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'Flag 1/0. If set to 1, items in this trade will be reserved. Items will also be reserved if parentSteamTradeId is set',
  `hasItemsReservedElsewhere` TINYINT(255) DEFAULT 0 COMMENT 'Flag 1/0. If some of the trade items are reserved elsewhere, this is set to 1 and the trade can''t be accepted',
  `platformId` TINYINT(4) DEFAULT 0 COMMENT '0 for CSDEALS, 1 for tradeskinsfast',
  `isSystemTrade` TINYINT(255) DEFAULT 0 COMMENT 'Flag 1/0. Cannot be accepted or declined by the user and is not shown to the user. Used for Adyen orders.',
  `isActive` TINYINT(255) GENERATED ALWAYS AS (if(`state` < 10,1,0)) STORED COMMENT 'Flag 1/0. Whether the trade is still active',
  `isAccepted` TINYINT(255) GENERATED ALWAYS AS (`state` = 11) VIRTUAL COMMENT 'Flag 1/0. Whether the trade is accepted and completed',
  PRIMARY KEY (id, toUserId),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'History of all created on-site trades. Historical and currently active.';

ALTER TABLE `onSiteTrades_Trades` 
  ADD UNIQUE INDEX searchBySteamTrade(parentSteamTradeId);

ALTER TABLE `onSiteTrades_Trades` 
  ADD UNIQUE INDEX UUID(UUID);

ALTER TABLE `onSiteTrades_Trades` 
  ADD INDEX platformId(platformId);

ALTER TABLE `onSiteTrades_Trades` 
  ADD INDEX toUserId(toUserId, isActive, tradeType);

ALTER TABLE `onSiteTrades_Trades` 
  ADD INDEX isActive(isActive, tradeType);

ALTER TABLE `onSiteTrades_Trades` 
  ADD CONSTRAINT `onSiteTradeToSteamTrade` FOREIGN KEY (parentSteamTradeId)
    REFERENCES steamTrades_Trades(id);

ALTER TABLE `onSiteTrades_Trades` 
  ADD CONSTRAINT `onSiteTrades_Trades_fromUserId` FOREIGN KEY (fromUserId)
    REFERENCES users(id);

ALTER TABLE `onSiteTrades_Trades` 
  ADD CONSTRAINT `onSiteTrades_Trades_toRecipientInventoryId` FOREIGN KEY (toRecipientInventoryId)
    REFERENCES onSiteInventories_Inventories(id);

ALTER TABLE `onSiteTrades_Trades` 
  ADD CONSTRAINT `onSiteTrades_Trades_toSenderInventoryId` FOREIGN KEY (toSenderInventoryId)
    REFERENCES onSiteInventories_Inventories(id);

ALTER TABLE `onSiteTrades_Trades` 
  ADD CONSTRAINT `onSiteTrades_Trades_toUserId` FOREIGN KEY (toUserId)
    REFERENCES users(id);