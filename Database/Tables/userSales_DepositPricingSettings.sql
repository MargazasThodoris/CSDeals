CREATE TABLE `userSales_DepositPricingSettings` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(255) UNSIGNED NOT NULL COMMENT '->users.id',
  `steamTradeItemId` BIGINT(20) UNSIGNED DEFAULT NULL COMMENT '->steamTrades_Items.id',
  `onSiteTradeItemId` BIGINT(20) UNSIGNED DEFAULT NULL COMMENT '->onSiteTrades_Items.id',
  `steamTradeId` BIGINT(255) DEFAULT NULL COMMENT '->steamTrades_Trades.id',
  `onSiteTradeId` BIGINT(255) DEFAULT NULL COMMENT '->onSiteTrades_Trades.id',
  `isRealMoneySale` SMALLINT(255) GENERATED ALWAYS AS (if(`priceInCurrency` = 0,0,1)) STORED COMMENT '0 if this listing is for trade-tokens, 1 if it is for EUR/USD or both',
  `priceInCurrency` SMALLINT(255) NOT NULL DEFAULT 1 COMMENT '1=USD, 3=EUR. In which currency the columns price1 and price2 are set',
  `rateUsdEur` DECIMAL(11, 8) DEFAULT NULL,
  `fee` DECIMAL(5, 4) UNSIGNED NOT NULL DEFAULT 0.0000 COMMENT 'Sales fee to be charged from the seller on sale. e.g. 0.02 for 2%',
  `type` SMALLINT(255) NOT NULL DEFAULT 0 COMMENT '0=static, 1=pricedecay',
  `price1` DECIMAL(10, 4) NOT NULL DEFAULT 900000.0000 COMMENT 'main price of the item in USD/TT if using standard price. The final price if using pricedecay',
  `price2` DECIMAL(10, 4) DEFAULT NULL,
  `isSellForUsd` SMALLINT(255) DEFAULT 0 COMMENT 'Flag whether seller accepts USD',
  `isSellForEur` SMALLINT(255) DEFAULT 0 COMMENT 'Flag whether seller accepts EUR',
  `isSellForBTC` SMALLINT(255) DEFAULT 0 COMMENT 'Flag whether seller accepts BTC',
  `timespanSeconds` INT(10) UNSIGNED DEFAULT NULL COMMENT 'Timespan setting for price decay',
  `isPrivateSale` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'If set, the privateSaleCode will be generated to ListedItemsHistory when it''s inserted',
  `appliedToOnSiteHistoryId` BIGINT(20) UNSIGNED DEFAULT NULL COMMENT '->onSiteInventories_ItemHistory.id; Set when the user sale listing is created',
  `priceHistoryId` INT(255) UNSIGNED DEFAULT NULL COMMENT '->itemPriceHistory.id',
  `ownerAdyenAccountHolderLocalId` INT(255) DEFAULT NULL COMMENT '->Adyen_AccountHolders.id',
  `isActive` TINYINT(255) NOT NULL DEFAULT 1 COMMENT 'Whether these settings have not yet been applied to a listing',
  PRIMARY KEY (id, userId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'When a user is listing an item for sale, the pricing settings are stored here. When the trade is complete, this table is read so the listings can be created.
Includes all historical and pending entries.';

ALTER TABLE `userSales_DepositPricingSettings` 
  ADD UNIQUE INDEX uniq(steamTradeItemId, onSiteTradeItemId, priceInCurrency);

ALTER TABLE `userSales_DepositPricingSettings` 
  ADD INDEX userId(userId, isActive);

ALTER TABLE `userSales_DepositPricingSettings` 
  ADD INDEX onSiteTradeId(onSiteTradeId);

ALTER TABLE `userSales_DepositPricingSettings` 
  ADD INDEX steamTradeId(steamTradeId);

ALTER TABLE `userSales_DepositPricingSettings` 
  ADD CONSTRAINT `appliedToOnSiteItemId` FOREIGN KEY (appliedToOnSiteHistoryId)
    REFERENCES onSiteInventories_ItemHistory(id);

ALTER TABLE `userSales_DepositPricingSettings` 
  ADD CONSTRAINT `onSiteTradeItemId` FOREIGN KEY (onSiteTradeItemId)
    REFERENCES onSiteTrades_Items(id);

ALTER TABLE `userSales_DepositPricingSettings` 
  ADD CONSTRAINT `steamTradeItemId` FOREIGN KEY (steamTradeItemId)
    REFERENCES steamTrades_Items(id);