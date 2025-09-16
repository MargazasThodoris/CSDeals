CREATE TABLE `carts_items` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cartId` INT(10) UNSIGNED NOT NULL COMMENT '->carts_carts.id',
  `onSiteHistoryId` BIGINT(11) UNSIGNED NOT NULL COMMENT '->onSiteInventories_ItemHistory.id',
  `userSaleIndexId` INT(255) UNSIGNED NOT NULL COMMENT '->userSales_IndexedSales.id; May be a value that does not exist if the item is not available',
  `unavailableAmount` INT(255) DEFAULT 0 COMMENT 'Updated whenever the cart is fetched',
  `amount` INT(255) NOT NULL COMMENT 'Original amount that we added to the cart. Final amount is this minus unavailableAmount',
  `autoRemoveAfter` INT(255) UNSIGNED DEFAULT NULL COMMENT 'Used to clear unavailable items from carts after they have been seen by the user',
  `timeAdded` INT(255) UNSIGNED DEFAULT NULL,
  `priceWhenAddedEUR` DECIMAL(10, 2) DEFAULT NULL,
  `priceWhenAddedUSD` DECIMAL(10, 2) DEFAULT NULL COMMENT 'Used to find this item again if the price is edited',
  `userSaleId` INT(10) UNSIGNED NOT NULL,
  `botId` INT(255) UNSIGNED NOT NULL,
  `steamId` BIGINT(255) UNSIGNED NOT NULL,
  `botDisabled` TINYINT(255) DEFAULT 0,
  `ownerUserId` INT(11) DEFAULT NULL,
  `ownerUserUUID` CHAR(36) DEFAULT NULL,
  `privateSaleCode` CHAR(10) DEFAULT NULL,
  `price1` DECIMAL(10, 2) DEFAULT NULL,
  `price2` DECIMAL(10, 2) DEFAULT NULL,
  `rateUsdEur` DECIMAL(11, 8) DEFAULT NULL,
  `userSaleType` SMALLINT(255) DEFAULT NULL,
  `userSaleTime` INT(255) UNSIGNED DEFAULT NULL,
  `timespanSeconds` INT(10) UNSIGNED DEFAULT NULL,
  `priceDecayAddTime` INT(11) NOT NULL DEFAULT 0,
  `lastSeenPriceUSD` DECIMAL(10, 2) NOT NULL COMMENT 'Updated every time the cart is opened. Used to show the price of unavailable items',
  `lastSeenPriceEUR` DECIMAL(10, 2) NOT NULL,
  `marketname` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `assetid` BIGINT(20) UNSIGNED NOT NULL,
  `classid` BIGINT(255) UNSIGNED NOT NULL,
  `instanceid` INT(255) NOT NULL,
  `appid` MEDIUMINT(255) UNSIGNED NOT NULL,
  `rarityColor` CHAR(6) DEFAULT NULL,
  `nameColor` CHAR(6) DEFAULT NULL,
  `systemPrice` DECIMAL(10, 4) DEFAULT NULL,
  `discountAmount` FLOAT(255, 4) GENERATED ALWAYS AS (if(`systemPrice` > 0,(`systemPrice` - `lastSeenPriceUSD`) / `systemPrice`,NULL)) STORED,
  `itemid` INT(10) UNSIGNED NOT NULL,
  `phaseitemid` INT(255) UNSIGNED DEFAULT NULL,
  `imageId` INT(255) DEFAULT NULL,
  `isMarketable` TINYINT(255) DEFAULT NULL,
  `isCommodity` TINYINT(255) NOT NULL,
  `allowStacking` TINYINT(255) DEFAULT 0 COMMENT 'used for Arcanas and dragonclaw hooks and other non commodity items that we want to stack',
  `tradableAfterTime` INT(10) UNSIGNED DEFAULT NULL,
  `itemType` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `cs_paintwear` DOUBLE(15, 14) DEFAULT NULL,
  `cs_paintindex` SMALLINT(255) DEFAULT NULL,
  `cs_paintseed` SMALLINT(255) DEFAULT NULL,
  `cs_inspectCode` BIGINT(255) UNSIGNED DEFAULT NULL,
  `cs_sticker1_marketname` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `cs_sticker2_marketname` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `cs_sticker3_marketname` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `cs_sticker4_marketname` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `cs_sticker5_marketname` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `cs_stickersJSON` TEXT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `cs_screenshotPngId` INT(11) DEFAULT NULL,
  `cs_exterior` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `cs_rarity` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `cs_quality` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cs_isStattrak` TINYINT(255) DEFAULT NULL,
  `cs_nametag` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cs_weapon` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `cs_phaseName` VARCHAR(255) DEFAULT NULL,
  `cs_paintseedName` VARCHAR(255) DEFAULT NULL,
  `d2_rarity` VARCHAR(255) DEFAULT NULL,
  `d2_hero` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `d2_type` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `d2_slot` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `d2_quality` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `d2_qualityColor` CHAR(6) DEFAULT NULL,
  `d2_gemsJSON` TEXT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `tf2_quality` VARCHAR(255) DEFAULT NULL,
  `tf2_effectName` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `tf2_effectId` VARCHAR(255) DEFAULT NULL,
  `tf2_class` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `tf2_inspectLinkCode` BIGINT(255) DEFAULT NULL,
  `tf2_wikilinkId` INT(255) DEFAULT NULL,
  `tf2_hasUncraftableTag` TINYINT(255) DEFAULT 0,
  `h1z1_type` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `additionalDataJSON` TEXT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `descriptionJSON` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isAllUnavailable` TINYINT(255) GENERATED ALWAYS AS (if(`unavailableAmount` = `amount`,1,0)) STORED COMMENT 'Used for finding unavailable items that we can clear to make room to the cart',
  PRIMARY KEY (id, cartId, onSiteHistoryId, userSaleIndexId),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Index of items in the cart. The entries may have data that do not correlate with the actual item, if the data is outdated. This is the data that the item had when it was added to the cart.

Does not have foreign keys configured completely.';

ALTER TABLE `carts_items` 
  ADD INDEX `unique`(cartId, userSaleIndexId);

ALTER TABLE `carts_items` 
  ADD INDEX cartId(cartId, onSiteHistoryId) COMMENT 'onSiteHistoryId is required to check if this cart has a specific item';

ALTER TABLE `carts_items` 
  ADD INDEX autoRemoveAfter(autoRemoveAfter);

ALTER TABLE `carts_items` 
  ADD INDEX available(cartId, isAllUnavailable);

ALTER TABLE `carts_items` 
  ADD INDEX userSaleType(userSaleType) COMMENT 'Required for updating decay prices';

ALTER TABLE `carts_items` 
  ADD CONSTRAINT `carts_items_ibfk_1` FOREIGN KEY (cartId)
    REFERENCES carts_carts(id) ON DELETE CASCADE;

ALTER TABLE `carts_items` 
  ADD CONSTRAINT `carts_items_onSiteHistoryId` FOREIGN KEY (onSiteHistoryId)
    REFERENCES onSiteInventories_ItemHistory(id) ON DELETE CASCADE;