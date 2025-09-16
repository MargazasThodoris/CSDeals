CREATE TABLE `userSales_IndexedSales` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `UUID` CHAR(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `onSiteHistoryId` BIGINT(11) UNSIGNED NOT NULL COMMENT '->onSiteInventories_ItemHistory.id',
  `botInventoryHistoryId` BIGINT(255) UNSIGNED DEFAULT NULL COMMENT '->botInventories_ItemHistory.id; Can possibly be null in the future when items are not Steam items',
  `userSaleId` INT(10) UNSIGNED NOT NULL COMMENT '->userSales_ListedItemsHistory.id',
  `botId` INT(255) UNSIGNED NOT NULL COMMENT '->bots.id',
  `steamId` BIGINT(255) UNSIGNED NOT NULL,
  `botDisabled` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'Should be the same value as bots.disabled',
  `totalAmount` INT(255) NOT NULL COMMENT 'Should be the same value as onSiteInventories_ItemHistory.amount',
  `amountReserved` INT(255) NOT NULL DEFAULT 0 COMMENT 'Amount reserved in ongoing orders',
  `amount` INT(255) GENERATED ALWAYS AS (`totalAmount` - `amountReserved`) STORED,
  `ownerUserId` INT(11) UNSIGNED DEFAULT NULL COMMENT '->users.id',
  `isRealMoneySale` SMALLINT(255) GENERATED ALWAYS AS (if(`priceInCurrency` = 0,0,1)) STORED COMMENT '0 if this listing is for trade-tokens, 1 if it is for EUR/USD or both',
  `ownerUserUUID` CHAR(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '->users.UUID',
  `privateSaleCode` CHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Set if this is a private listing',
  `featuredOrder` SMALLINT(255) DEFAULT 0 COMMENT 'lower means it will be displayed first',
  `featuredGroup` SMALLINT(255) DEFAULT NULL COMMENT 'used for groups like different apps and liquid items in the initial marketplace page',
  `price1` DECIMAL(10, 4) NOT NULL COMMENT 'main price of the item in USD/TT if using standard price. The final price if using pricedecay',
  `price2` DECIMAL(10, 4) DEFAULT NULL COMMENT 'Starting price if using priceDecay, null if using standard price',
  `isSellForUsd` SMALLINT(255) NOT NULL DEFAULT 0 COMMENT 'Flag whether seller accepts USD',
  `isSellForEur` SMALLINT(255) NOT NULL DEFAULT 0 COMMENT 'Flag whether seller accepts EUR',
  `isSellForBTC` SMALLINT(255) NOT NULL DEFAULT 0 COMMENT 'Flag whether seller accepts BTC',
  `priceInCurrency` INT(255) UNSIGNED NOT NULL COMMENT '0=tradetokens, 1=USD, 3=EUR. In which currency the columns price1 and price2 are set',
  `rateUsdEur` DECIMAL(11, 8) DEFAULT NULL,
  `userSaleType` SMALLINT(255) DEFAULT NULL COMMENT '0=static, 1=pricedecay',
  `userSaleTime` INT(255) UNSIGNED DEFAULT NULL COMMENT 'Value of userSales_ListedItemsHistory.time. Used for Price decay price calculation',
  `timespanSeconds` INT(10) UNSIGNED DEFAULT NULL COMMENT 'Setting for Price Decay',
  `currentPriceEUR` DECIMAL(10, 2) DEFAULT NULL COMMENT 'Updated via cron for decay prices. NULL if not real money sale but set even if seller only accepts USD',
  `currentPriceUSDorTT` DECIMAL(10, 2) DEFAULT NULL COMMENT 'Always set even if seller only accepts EUR',
  `marketname` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `assetid` BIGINT(20) UNSIGNED NOT NULL,
  `classid` BIGINT(255) UNSIGNED NOT NULL,
  `instanceid` INT(255) NOT NULL,
  `appid` MEDIUMINT(255) UNSIGNED NOT NULL,
  `rarityColor` CHAR(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nameColor` CHAR(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `systemPrice` DECIMAL(10, 4) DEFAULT NULL,
  `discountAmount` FLOAT(255, 4) GENERATED ALWAYS AS (if(`systemPrice` > 0,(`systemPrice` - `currentPriceUSDorTT`) / `systemPrice`,NULL)) STORED,
  `itemid` INT(10) UNSIGNED NOT NULL COMMENT '->items.id',
  `phaseitemid` INT(255) UNSIGNED DEFAULT NULL COMMENT '->items_phases.phaseitemid',
  `imageId` INT(255) DEFAULT NULL,
  `isMarketable` TINYINT(255) DEFAULT NULL,
  `isCommodity` TINYINT(255) NOT NULL,
  `allowStacking` TINYINT(255) DEFAULT 0 COMMENT 'used for Arcanas and dragonclaw hooks and other non commodity items that we want to stack',
  `tradableAfterTime` INT(10) UNSIGNED DEFAULT NULL,
  `itemType` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cs_paintwear` DOUBLE(15, 14) DEFAULT NULL,
  `cs_paintindex` SMALLINT(255) DEFAULT NULL,
  `cs_paintseed` SMALLINT(255) DEFAULT NULL,
  `cs_inspectCode` BIGINT(255) UNSIGNED DEFAULT NULL,
  `cs_sticker1_marketname` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cs_sticker2_marketname` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cs_sticker3_marketname` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cs_sticker4_marketname` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cs_sticker5_marketname` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cs_stickersJSON` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cs_screenshotPngId` INT(11) DEFAULT NULL,
  `cs_exterior` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cs_rarity` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cs_quality` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cs_isStattrak` TINYINT(255) DEFAULT NULL,
  `cs_nametag` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cs_weapon` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cs_phaseName` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cs_paintseedName` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `d2_rarity` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `d2_hero` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `d2_type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `d2_slot` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `d2_quality` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `d2_qualityColor` CHAR(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `d2_gemsJSON` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tf2_quality` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tf2_effectName` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tf2_effectId` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tf2_class` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tf2_inspectLinkCode` BIGINT(255) DEFAULT NULL,
  `tf2_wikilinkId` INT(255) DEFAULT NULL,
  `tf2_hasUncraftableTag` TINYINT(255) DEFAULT 0,
  `h1z1_type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `timeForSorting` INT(255) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Time when this item was added. Used to sort items by new first while ignoring edited prices',
  `additionalDataJSON` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `descriptionJSON` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Value of steamItems_Descriptions.description of the bot inventory history item',
  `isInBot` TINYINT(4) DEFAULT 1,
  PRIMARY KEY (id, UUID, onSiteHistoryId),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Normalized and indexed table for all user sale listings. Used for marketplace searches only. This table should not be used to validate any data in runtime, such as item availability.';

ALTER TABLE `userSales_IndexedSales` 
  ADD UNIQUE INDEX uniqueSale(userSaleId);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX appid(appid, currentPriceUSDorTT);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX appRecentlyAdded(isRealMoneySale, appid, timeForSorting);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX assetidSteamid(assetid, steamId) COMMENT 'Used for updating inspect data';

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX botInventoryHistoryId(botInventoryHistoryId);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX cs_exterior(isRealMoneySale, botDisabled, cs_exterior);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX cs_paintseed(isRealMoneySale, botDisabled, cs_paintseed);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX cs_paintwear(isRealMoneySale, botDisabled, cs_paintwear);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX cs_quality(isRealMoneySale, botDisabled, cs_quality);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX cs_rarity(isRealMoneySale, botDisabled, cs_rarity);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX cs_sticker1_marketname(isRealMoneySale, botDisabled, cs_sticker1_marketname);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX cs_sticker2_marketname(isRealMoneySale, botDisabled, cs_sticker2_marketname);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX cs_sticker3_marketname(isRealMoneySale, botDisabled, cs_sticker3_marketname);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX cs_sticker4_marketname(isRealMoneySale, botDisabled, cs_sticker4_marketname);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX cs_sticker5_marketname(isRealMoneySale, botDisabled, cs_sticker5_marketname);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX cs_weapon(isRealMoneySale, botDisabled, cs_weapon);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX currentPrice(isRealMoneySale, botDisabled, currentPriceUSDorTT);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX d2_hero(isRealMoneySale, botDisabled, d2_hero);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX d2_quality(isRealMoneySale, botDisabled, d2_quality);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX d2_rarity(isRealMoneySale, botDisabled, d2_rarity);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX d2_slot(isRealMoneySale, botDisabled, d2_slot);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX d2_type(isRealMoneySale, botDisabled, d2_type);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX featuredGroup(featuredGroup, featuredOrder);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX IDX_userSales_IndexedSales_marketname(marketname, cs_phaseName);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX itemid(itemid, phaseitemid, currentPriceUSDorTT) COMMENT 'Extra fields for item lookup for new cart items';

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX itemType(isRealMoneySale, botDisabled, itemType);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX loadAppItems(appid, botDisabled);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX marketname(isRealMoneySale, botDisabled, marketname);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX missingScreenshot(appid, cs_screenshotPngId, cs_paintwear);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX onSiteHistoryId(onSiteHistoryId);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX ownerUserId(isRealMoneySale, ownerUserId);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX privateSaleCode(privateSaleCode);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX systemPrice(systemPrice) COMMENT 'Might be required for sorting by discount';

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX tf2_class(isRealMoneySale, botDisabled, tf2_class);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX tf2_quality(isRealMoneySale, botDisabled, tf2_quality);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX userSaleId(userSaleId);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX userSales_IndexedSales_botId(botId);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX userSales_IndexedSales_ownerUserId(ownerUserId);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX userSales_IndexedSales_phaseitemid(phaseitemid);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX userSaleType(userSaleType) COMMENT 'Required for updating pricedecay prices';

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX userUUID(ownerUserUUID);

ALTER TABLE `userSales_IndexedSales` 
  ADD INDEX UUID(UUID);