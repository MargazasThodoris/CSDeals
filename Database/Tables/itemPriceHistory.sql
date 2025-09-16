CREATE TABLE `itemPriceHistory` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemid` INT(11) UNSIGNED NOT NULL COMMENT '->items.id',
  `phaseitemid` INT(11) UNSIGNED DEFAULT NULL COMMENT '->items_phases.phaseitemid; if this is a phase item, this will be ID in items_phases',
  `time` INT(11) UNSIGNED NOT NULL COMMENT 'when we first saw this price',
  `volume` INT(11) NOT NULL,
  `volumeLocal` INT(11) NOT NULL DEFAULT 0,
  `volumeLocalMarketized` INT(11) NOT NULL DEFAULT 0,
  `volumeSCM` INT(11) NOT NULL DEFAULT 0,
  `price` DECIMAL(8, 2) NOT NULL DEFAULT 0.00 COMMENT 'what''s the item priced originally before sell and buy percentages. This value is the actual item price multiplied by pricemodifier.
Either priceSA or priceLocal',
  `priceLocal` DECIMAL(8, 2) NOT NULL DEFAULT 0.00,
  `priceLocalMarketized` DECIMAL(8, 2) NOT NULL DEFAULT 0.00,
  `priceSA` DECIMAL(8, 2) NOT NULL DEFAULT 0.00 COMMENT 'Our own price calculated from the steamanalyst API',
  `priceSCM` DECIMAL(8, 2) NOT NULL DEFAULT 0.00,
  `overrideprice` DECIMAL(8, 2) NOT NULL DEFAULT 0.00,
  `itemPriceModifier` FLOAT NOT NULL DEFAULT 0 COMMENT 'This is a column in the items table and modifies the price for that item. This is manually set',
  `platformId` TINYINT(255) DEFAULT 0 COMMENT '0=csdeals, 1=tsf',
  PRIMARY KEY (id, itemid, time),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Whenever an item is added to an on-site or a Steam trade, the curent price data of the item is logged here.';

ALTER TABLE `itemPriceHistory` 
  ADD INDEX lookup(platformId, itemid, phaseitemid);

ALTER TABLE `itemPriceHistory` 
  ADD CONSTRAINT `itemPriceHistory_itemId` FOREIGN KEY (itemid)
    REFERENCES items(id);

ALTER TABLE `itemPriceHistory` 
  ADD CONSTRAINT `itemPriceHistory_phaseitemid` FOREIGN KEY (phaseitemid)
    REFERENCES items_phases(phaseitemid);