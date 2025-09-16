CREATE TABLE `Items_BackpackTFPriceHistories` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemid` INT(11) UNSIGNED DEFAULT NULL COMMENT '->items.id',
  `marketName` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Used if itemid is not set (if we couldn''t find an item with this name). This is stored so we can look up the pricing for new items in the database',
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'UNIX timestamp of the entry',
  `tradable` TINYINT(255) NOT NULL,
  `craftable` TINYINT(255) NOT NULL,
  `priceindex` SMALLINT(255) NOT NULL COMMENT 'The priceindex is an attribute that is applied to priced items that share the same definition index and quality. For most items, it is zero. Otherwise, the use varies by context:

Particle effects: The priceindex will correspond to the ID of the particle as documented in the Valve Web API.

Crates: The priceindex corresponds to the crate series.

Strangifiers/Unusualifiers: The priceindex of a Strangifier/Unusualifier corresponds to the definition index of the item it can be used on.

Chemistry Sets: The priceindex of a Chemistry Set is a hyphen-delimited string of two numbers; the definition index and the quality of the item. 1086-14 is the priceindex for a Collector''s Festive Wrangler.',
  `price` DECIMAL(12, 4) NOT NULL,
  `priceLow` DECIMAL(12, 4) DEFAULT NULL,
  `priceHigh` DECIMAL(12, 4) DEFAULT NULL,
  `isUnreliable` TINYINT(255) DEFAULT 0 COMMENT 'set when inserting the data. Check previous entry and if the price is a lot different, set this to 1',
  `uniqHelper` VARCHAR(255) GENERATED ALWAYS AS (ifnull(`marketName`,`itemid`)) VIRTUAL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs third party pricing data related to TF2 items, based on the item''s characteristics';

ALTER TABLE `Items_BackpackTFPriceHistories` 
  ADD UNIQUE INDEX uniq(craftable, tradable, priceindex, time, uniqHelper);

ALTER TABLE `Items_BackpackTFPriceHistories` 
  ADD INDEX search(itemid, marketName);

ALTER TABLE `Items_BackpackTFPriceHistories` 
  ADD CONSTRAINT `Items_BackpackTFPriceHistories_itemId` FOREIGN KEY (itemid)
    REFERENCES items(id) ON DELETE CASCADE ON UPDATE CASCADE;