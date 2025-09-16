CREATE TABLE `tradeBot_ItemPriceHistory` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemid` INT(11) NOT NULL COMMENT '->items.id',
  `phaseitemid` INT(11) DEFAULT NULL COMMENT '->items_phases.phaseitemid',
  `time` INT(10) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp of this entry',
  `buyMultiplier` FLOAT(9, 6) UNSIGNED NOT NULL COMMENT 'the current buy price multiplier in the trade bot. This is multiplied by priceModifiersResultMultiplier to get the final value.
This is null for items that are being traded from the bot, because it would be calculated wrong.
to get the final trading price, multiply this with the item price and priceModifiersResultMultiplier and do floor(x*100)/100',
  `sellMultiplier` FLOAT(9, 6) UNSIGNED NOT NULL COMMENT 'the current sell price multiplier in the trade bot. This is multiplied by priceModifiersResultMultiplier to get the final value.
This is null for items that are being traded to the bot, because it would be calculated wrong',
  `sellValue` DECIMAL(8, 4) DEFAULT NULL COMMENT 'how much the bot sells this item for.',
  `buyValue` DECIMAL(8, 4) DEFAULT NULL COMMENT 'This DOES NOT include the bonus but DOES include priceModifiersResultMultiplier and to get the final price, you must do (buyValue/buyMultiplier*(buyMultiplier+bonus))',
  `tradeBotPriceMultiplier` DECIMAL(5, 4) NOT NULL DEFAULT 1.0000,
  `individualPriceSettingId` BIGINT(20) DEFAULT NULL COMMENT '->tradeBot_IndividualItemPriceSettings.id',
  `appliedPriceModifiersFlags` INT(255) NOT NULL,
  `priceModifiersResultMultiplier` FLOAT(255, 5) DEFAULT NULL,
  `platformId` TINYINT(4) DEFAULT 0,
  PRIMARY KEY (id, itemid),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Log of trade bot pricing on every item that was included in a tradebot trade';

ALTER TABLE `tradeBot_ItemPriceHistory` 
  ADD INDEX lookup(platformId, itemid, phaseitemid);