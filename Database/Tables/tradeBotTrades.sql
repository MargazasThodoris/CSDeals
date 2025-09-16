CREATE TABLE `tradeBotTrades` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `userid` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '->users.id',
  `steamTradeId` INT(11) UNSIGNED DEFAULT NULL COMMENT '->steamTrades_Trades.id',
  `onSiteTradeId` INT(11) UNSIGNED DEFAULT NULL COMMENT '->onSiteTrades_Trades.id',
  `time` INT(255) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'UNIX timestamp of the trade',
  `platformId` TINYINT(255) NOT NULL DEFAULT 0 COMMENT '0=csdeals, 1=tradeskinsfast',
  `isAccepted` TINYINT(255) NOT NULL DEFAULT 0 COMMENT '1 if the trade was accepted',
  `bonusAmount` DECIMAL(4, 3) NOT NULL DEFAULT 0.000 COMMENT 'how many percent of bonus the user got. We can use this and the data in itempricehistory to calculate the offer values',
  `userItemsPrice` DECIMAL(8, 2) NOT NULL DEFAULT 0.00 COMMENT 'Our system price of the user''s items in USD',
  `botItemsPrice` DECIMAL(8, 2) NOT NULL DEFAULT 0.00 COMMENT 'Our system price of the bot''s items in USD. Includes all bot items values, including our own and usersales',
  `userSaleBotItemsPrice` DECIMAL(8, 2) NOT NULL DEFAULT 0.00 COMMENT 'Total system price in USD of the any usersale items',
  `userOfferItemsValue` DECIMAL(12, 4) NOT NULL DEFAULT 0.0000 COMMENT 'Value is the value of the offer on the trade bot, not the actual value of the items',
  `botOfferItemsValue` DECIMAL(12, 4) NOT NULL DEFAULT 0.0000 COMMENT 'Trade-token value of the items from the bot',
  `userSaleItemsSellPrice` DECIMAL(12, 4) NOT NULL DEFAULT 0.0000 COMMENT 'Trade-token price of usersale items',
  `userTradeBotBalanceChange` DECIMAL(12, 4) NOT NULL DEFAULT 0.0000 COMMENT 'Amount how much the user''s trade-token balance will change',
  `userTSFBalanceChange` DECIMAL(12, 4) NOT NULL COMMENT 'Amount how much the user''s TSF balance will change',
  `itemPricesByApp` LONGTEXT BINARY CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Used to store above columns data per app',
  PRIMARY KEY (id, userid)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'All trade bot trades, completed or not';

ALTER TABLE `tradeBotTrades` 
  ADD UNIQUE INDEX steamTradeId(steamTradeId);

ALTER TABLE `tradeBotTrades` 
  ADD UNIQUE INDEX onSiteTradeId(onSiteTradeId);

ALTER TABLE `tradeBotTrades` 
  ADD INDEX userId(userid, isAccepted);

ALTER TABLE `tradeBotTrades` 
  ADD INDEX time(time, userid);