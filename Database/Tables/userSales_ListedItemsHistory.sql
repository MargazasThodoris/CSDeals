CREATE TABLE `userSales_ListedItemsHistory` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `onSiteHistoryId` BIGINT(20) UNSIGNED NOT NULL COMMENT '->onSiteInventories_ItemHistory.id',
  `ownerUserId` INT(10) UNSIGNED DEFAULT NULL COMMENT '->users.id',
  `ownerAdyenAccountHolderLocalId` INT(255) DEFAULT NULL COMMENT '->Adyen_AccountHolders.id; Used to find out where the payment should be paid',
  `isRealMoneySale` SMALLINT(255) GENERATED ALWAYS AS (if(`priceInCurrency` = 0 or `priceInCurrency` = 100,0,1)) STORED COMMENT '0 if this listing is for trade-tokens, 1 if it is for EUR/USD or both',
  `isSellForUsd` SMALLINT(255) NOT NULL DEFAULT 0 COMMENT 'Flag whether seller accepts USD',
  `isSellForEur` SMALLINT(255) NOT NULL DEFAULT 0 COMMENT 'Flag whether seller accepts EUR',
  `isSellForBTC` SMALLINT(255) NOT NULL DEFAULT 0 COMMENT 'Flag whether seller accepts BTC',
  `priceInCurrency` SMALLINT(255) UNSIGNED DEFAULT 1 COMMENT '0=tradetokens, 1=USD, 3=EUR. In which currency the columns price1 and price2 are set',
  `rateUsdEur` DECIMAL(11, 8) DEFAULT NULL COMMENT 'Used to calculate currentPriceEUR if using priceDecay. This is only saved once when the item is listed for sale',
  `status` SMALLINT(255) DEFAULT NULL COMMENT '1=withdrawn, 2=edited, 3=sold, 4=sold other currency, 5=traded from tradebot 6=replaced by new id',
  `fee` DECIMAL(5, 4) UNSIGNED DEFAULT 0.0000 COMMENT 'Sales fee to be charged from the seller on sale. e.g. 0.02 for 2%',
  `type` SMALLINT(255) DEFAULT NULL COMMENT '0=static, 1=pricedecay',
  `price1` DECIMAL(11, 4) DEFAULT NULL COMMENT 'main price of the item in USD/TT if using standard price. The final price if using pricedecay',
  `price2` DECIMAL(11, 4) DEFAULT NULL,
  `timespanSeconds` INT(255) UNSIGNED DEFAULT NULL COMMENT 'Timespan setting for price decay',
  `privateSaleCode` CHAR(10) DEFAULT NULL COMMENT 'If set, this is required to purchase and to see the item',
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'UNIX timestamp of this entry',
  `removedTime` INT(10) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp when the item was no longer listed for sale',
  `statusChangeTime` INT(255) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp when the status changed last time',
  `priceDecayAddTime` INT(255) DEFAULT 0 COMMENT 'Updated when item was off from the market for some reason and then back in. This is added to column time when calculating PriceDecay price.',
  `priceHistoryId` INT(255) UNSIGNED DEFAULT NULL COMMENT '->itemPriceHistory.id',
  `isActive` TINYINT(4) GENERATED ALWAYS AS (if(`status` is null,1,NULL)) VIRTUAL COMMENT '1 if this item is still listed for sale, otherwise 0',
  PRIMARY KEY (id, onSiteHistoryId),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Stores history of all items listed for sale on the marketplace or on the trade bot for trade-tokens. Includes old listings and current active listings, indicated by the status column.';

ALTER TABLE `userSales_ListedItemsHistory` 
  ADD UNIQUE INDEX `unique`(onSiteHistoryId, isActive, priceInCurrency);

ALTER TABLE `userSales_ListedItemsHistory` 
  ADD INDEX privateSaleCode(privateSaleCode) COMMENT 'Not unique, because when we update a row, the link remains the same';

ALTER TABLE `userSales_ListedItemsHistory` 
  ADD INDEX isActive(isActive, priceInCurrency);

ALTER TABLE `userSales_ListedItemsHistory` 
  ADD INDEX ownerUserId(ownerUserId, status);

ALTER TABLE `userSales_ListedItemsHistory` 
  ADD INDEX ownerActive(ownerUserId, isActive);

ALTER TABLE `userSales_ListedItemsHistory` 
  ADD CONSTRAINT `onSiteHistoryId` FOREIGN KEY (onSiteHistoryId)
    REFERENCES onSiteInventories_ItemHistory(id);

ALTER TABLE `userSales_ListedItemsHistory` 
  ADD CONSTRAINT `ownerUserId` FOREIGN KEY (ownerUserId)
    REFERENCES users(id);

ALTER TABLE `userSales_ListedItemsHistory` 
  ADD CONSTRAINT `userSales_ListedItemsHistory_ownerAdyenAccountHolderLocalId` FOREIGN KEY (ownerAdyenAccountHolderLocalId)
    REFERENCES Adyen_AccountHolders(id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `userSales_ListedItemsHistory` 
  ADD CONSTRAINT `userSales_ListedItemsHistory_priceHistoryId` FOREIGN KEY (priceHistoryId)
    REFERENCES itemPriceHistory(id) ON DELETE NO ACTION ON UPDATE NO ACTION;