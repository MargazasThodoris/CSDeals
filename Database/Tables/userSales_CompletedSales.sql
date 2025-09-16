CREATE TABLE `userSales_CompletedSales` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userSaleId` INT(10) UNSIGNED NOT NULL COMMENT '->userSales_ListedItemsHistory.id',
  `sellerAdyenAccountHolderLocalId` INT(10) DEFAULT NULL COMMENT '->Adyen_AccountHolders.id',
  `currency` INT(255) DEFAULT NULL COMMENT '0=Trade-tokens, 1=USD, 3=EUR',
  `rateUsdCurrency` DECIMAL(10, 5) DEFAULT NULL COMMENT 'for example EUR/USD if price was in euro',
  `rateEurCurrency` DECIMAL(10, 5) DEFAULT NULL COMMENT 'for example USD/EUR if price was in USD',
  `itemId` INT(255) UNSIGNED DEFAULT NULL COMMENT '->items.id',
  `phaseItemId` INT(255) UNSIGNED DEFAULT NULL COMMENT '->items_phases.phaseitemid',
  `userId` INT(11) UNSIGNED DEFAULT NULL COMMENT '->users.id; Seller user ID',
  `buyerUserId` INT(255) UNSIGNED DEFAULT NULL COMMENT '->users.id; Buyer user ID',
  `buyerCountry` CHAR(2) DEFAULT NULL COMMENT '2 letter country coded',
  `amount` INT(255) NOT NULL COMMENT 'quantity of items',
  `salePrice` DECIMAL(12, 4) NOT NULL COMMENT 'price per item',
  `sellerBalanceTxId` INT(255) DEFAULT NULL COMMENT 'userbalancetransactions.id, the transaction of payment to seller. 
OBSOLETE: Uses old balance system',
  `isBitcoinSale` TINYINT(255) DEFAULT NULL COMMENT 'Flag 1/0 whether seller receives Bitcoin balance',
  `isPrivateSale` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'Flag 1/0 whether this was a private listing',
  `onSiteTradeId` INT(255) UNSIGNED DEFAULT NULL COMMENT '->onSiteTrades_Trades.id; on-site trade of the purchase order',
  `time` INT(11) DEFAULT NULL COMMENT 'UNIX timestamp of the purchase',
  `sameHouseholdSaleIP` VARCHAR(64) DEFAULT NULL COMMENT 'If the sale is flagged as a same household sale (same IP in the past 3 days), this is the ID in userIPs
',
  `isSameHouseholdSale` TINYINT(255) UNSIGNED GENERATED ALWAYS AS (if(`sameHouseholdSaleIP` is null,0,1)) STORED COMMENT 'Flag 1/0 whether the buyer and seller are from the same household',
  PRIMARY KEY (id, userSaleId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'History of sales of items on the marketplace for real money and on the tradebot for trade-tokens of items listed by users.';

ALTER TABLE `userSales_CompletedSales` 
  ADD INDEX time(time);

ALTER TABLE `userSales_CompletedSales` 
  ADD INDEX userId(userId, time, isSameHouseholdSale);

ALTER TABLE `userSales_CompletedSales` 
  ADD INDEX buyerUserId(buyerUserId, time, isSameHouseholdSale);

ALTER TABLE `userSales_CompletedSales` 
  ADD INDEX sellerToBuyer(userId, buyerUserId, time);

ALTER TABLE `userSales_CompletedSales` 
  ADD INDEX onSiteTrade(onSiteTradeId);

ALTER TABLE `userSales_CompletedSales` 
  ADD CONSTRAINT `completedSaleBuyerUserId` FOREIGN KEY (buyerUserId)
    REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `userSales_CompletedSales` 
  ADD CONSTRAINT `completedSaleHistoryId` FOREIGN KEY (userSaleId)
    REFERENCES userSales_ListedItemsHistory(id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `userSales_CompletedSales` 
  ADD CONSTRAINT `completedSaleSellerUserId` FOREIGN KEY (userId)
    REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `userSales_CompletedSales` 
  ADD CONSTRAINT `completedSales_onSiteTradeId` FOREIGN KEY (onSiteTradeId)
    REFERENCES onSiteTrades_Trades(id);

ALTER TABLE `userSales_CompletedSales` 
  ADD CONSTRAINT `completedSales_sellerAdyenAccountHolderLocalId` FOREIGN KEY (sellerAdyenAccountHolderLocalId)
    REFERENCES Adyen_AccountHolders(id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `userSales_CompletedSales` 
  ADD CONSTRAINT `itemId` FOREIGN KEY (itemId)
    REFERENCES items(id);

ALTER TABLE `userSales_CompletedSales` 
  ADD CONSTRAINT `phaseItemId` FOREIGN KEY (phaseItemId)
    REFERENCES items_phases(phaseitemid);