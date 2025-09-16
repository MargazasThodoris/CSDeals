CREATE TABLE `items_phases` (
  `phaseitemid` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '->items.id; parent item id. Called id because if we ever look up item by the ID for some reason, we want to match the parent id of this',
  `latestSteamAnalystHistoryId` INT(20) UNSIGNED NOT NULL DEFAULT 0,
  `marketname` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `iconpath` VARCHAR(300) NOT NULL DEFAULT '',
  `volume` INT(25) NOT NULL DEFAULT 0 COMMENT ' OPSkins 7-day price and volume ignores days without any sales. For most CS:GO items, this is the previous 7 days, but for rare or unpopular items, these sales can occur over the period of weeks or months.',
  `volumeLocalMarketized` INT(11) NOT NULL DEFAULT 0,
  `average` DECIMAL(7, 2) NOT NULL DEFAULT 0.00 COMMENT 'just copied from the latest itemhistory. Used for analysis',
  `averagedate` DATE NOT NULL DEFAULT '0000-00-00',
  `price` DECIMAL(8, 2) NOT NULL DEFAULT -1.00 COMMENT ' Calculated price of this item. -1 if couldn''t be reliably calculated',
  `lastSuccessfulPrice` DECIMAL(8, 2) DEFAULT NULL,
  `priceLocal` DECIMAL(8, 2) NOT NULL DEFAULT 0.00 COMMENT 'The price we calculated ourself. We will use either this or priceSA for the actual item price in the price column',
  `priceLocalMarketized` DECIMAL(8, 2) NOT NULL DEFAULT 0.00,
  `priceSA` DECIMAL(8, 2) NOT NULL DEFAULT 0.00 COMMENT 'Our own price calculated from the steamanalyst API',
  `pricebtc` DECIMAL(7, 2) NOT NULL DEFAULT 0.00 COMMENT 'we use a different calculation for calculating the btcprice than trading price',
  `overrideprice` DECIMAL(8, 2) DEFAULT NULL COMMENT 'we can set the price manually to override the calculated price by setting this field',
  `pricechange` DOUBLE NOT NULL DEFAULT -1 COMMENT 'calculated by comparing the current calculated price to the median price of a longer time span. -1 if couldn''t be reliably calculated',
  `volatility` DOUBLE NOT NULL COMMENT 'the ratio between the lowest and highest normalized_min in the past 7 days',
  `saledaycount` SMALLINT(6) NOT NULL DEFAULT 0 COMMENT 'from the last X days how many days have had sales on opskins for this item. We get this by checking the itemhistory table',
  `volumedate` DATE NOT NULL DEFAULT '0000-00-00',
  `pricedate` DATE NOT NULL DEFAULT '0000-00-00',
  `boughttoday` INT(11) NOT NULL COMMENT 'how many of this item we have bought today. gets reset every 24 hours',
  `maxbuyperday` INT(11) NOT NULL DEFAULT 10 COMMENT '-1 means unlimited',
  `maxstock` INT(11) NOT NULL COMMENT '-1 means unlimited. How many of this item we can have in stock at  once',
  `pricinggroup` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'Which pricing calculation group to be used for this item. Used so we can have different pricing for keys. 0 means default pricing by price',
  `disablebuy` TINYINT(4) NOT NULL DEFAULT 0 COMMENT '1 if this item isn''t allowed to be traded in or sold',
  `paintindex` MEDIUMINT(9) NOT NULL DEFAULT -1 COMMENT 'if this item is a doppler, paintindex is the index of the phase. marketname will be the same as the item name',
  `ispriceunstable` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'flag if the price is unstable. Set when recalculating prices. Can be set when the price is dropping for example',
  `priceModifier` FLOAT NOT NULL DEFAULT 0 COMMENT 'If not set, multiply the price by 1+this to get the final price',
  `priceModifierOnly` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'If set, don''t update the item data from our API, but just apply the priceModifier to the normal stats',
  `overridemaxstock` INT(11) DEFAULT NULL COMMENT 'if this is set, maxstock will be set to this instead of the calculated one',
  `unstablereason` VARCHAR(255) DEFAULT '',
  `canUsePriceAsSuggestion` TINYINT(255) DEFAULT 0,
  `finalPrice` DECIMAL(8, 2) GENERATED ALWAYS AS (if(`overrideprice` >= 0,`overrideprice`,`price`)) STORED,
  `liquidity` FLOAT DEFAULT 0,
  `trade_bot_buy_price` DECIMAL(8, 2) NOT NULL DEFAULT 0.00,
  `trade_bot_sell_price` DECIMAL(8, 2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (phaseitemid, id),
  INDEX phaseitemid(phaseitemid)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Some specific CS2 items have different phases with different data for those items. The phase is determined by the item''s paintindex';

ALTER TABLE `items_phases` 
  ADD UNIQUE INDEX uniq(id, paintindex);

ALTER TABLE `items_phases` 
  ADD INDEX iconpath(iconpath) COMMENT 'Used to delete unused item image files';

ALTER TABLE `items_phases` 
  ADD CONSTRAINT `items_phases_itemid` FOREIGN KEY (id)
    REFERENCES items(id) ON DELETE CASCADE ON UPDATE CASCADE;