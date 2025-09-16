CREATE TABLE `items_PriceAnalysis` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemid` INT(11) UNSIGNED NOT NULL,
  `phaseitemid` INT(255) UNSIGNED DEFAULT NULL,
  `time` INT(10) UNSIGNED NOT NULL,
  `volumeSCM` INT(255) DEFAULT NULL,
  `volumeSCM30d` INT(255) DEFAULT NULL,
  `volume2` INT(255) DEFAULT NULL,
  `calculatedPrice1` DECIMAL(8, 2) DEFAULT NULL,
  `calculatedPrice2` DECIMAL(8, 2) DEFAULT NULL,
  `calculatedPrice3` DECIMAL(8, 2) DEFAULT NULL,
  `calculatedPrice4` DECIMAL(8, 2) DEFAULT NULL,
  `calculatedPrice5` DECIMAL(8, 2) DEFAULT NULL,
  `priceDate` DATE DEFAULT NULL,
  `volumeDate` DATE DEFAULT NULL,
  `buyoutPrice` DECIMAL(8, 2) DEFAULT NULL,
  `csmoneyLowestPrice` DECIMAL(8, 2) DEFAULT NULL,
  `lootfarmMarketPrice` DECIMAL(8, 2) DEFAULT NULL,
  `lootfarmPrice` DECIMAL(8, 2) DEFAULT NULL,
  `csgotraderappCsgotrader` DECIMAL(8, 2) DEFAULT NULL,
  `csgotraderappCsmoney` DECIMAL(8, 2) DEFAULT NULL,
  `csgotraderappCsgoempire` DECIMAL(8, 2) DEFAULT NULL,
  `csgotraderappSwapgg` DECIMAL(8, 2) DEFAULT NULL,
  `csgotraderappCsgoexo` DECIMAL(8, 2) DEFAULT NULL,
  `csgotraderappBuffStarting` DECIMAL(10, 4) DEFAULT NULL,
  `csgotraderappBuffHighestOrder` DECIMAL(8, 2) DEFAULT NULL,
  `csgotraderappBitskins` DECIMAL(8, 2) DEFAULT NULL,
  `csgotraderappLootfarm` DECIMAL(8, 2) DEFAULT NULL,
  `csgotraderappCsgotm` DECIMAL(10, 4) DEFAULT NULL,
  `csgotraderappSkinportSuggested` DECIMAL(8, 2) DEFAULT NULL,
  `csgotraderappSkinportStartingAt` DECIMAL(8, 2) DEFAULT NULL,
  `csgotraderappSteam90d` DECIMAL(8, 2) DEFAULT NULL,
  `csgotraderappSteam30d` DECIMAL(8, 2) DEFAULT NULL,
  `csgotraderappSteam7d` DECIMAL(8, 2) DEFAULT NULL,
  `csgotraderappSteam24h` DECIMAL(8, 2) DEFAULT NULL,
  `maxstock1` INT(255) DEFAULT NULL,
  `maxstock2` INT(255) DEFAULT NULL,
  `isPriceUnstable` TINYINT(255) DEFAULT 0,
  `isPriceUnstable2` TINYINT(255) DEFAULT 0,
  `stabilityScore` FLOAT(255, 0) DEFAULT 0,
  `unstableReason` VARCHAR(1024) DEFAULT NULL,
  `unstableReason2` VARCHAR(1024) DEFAULT NULL,
  `canUsePriceAsSuggestion` TINYINT(255) DEFAULT 0,
  `uniqueHelper` INT(255) UNSIGNED GENERATED ALWAYS AS (ifnull(`phaseitemid`,0)) VIRTUAL,
  PRIMARY KEY (id, itemid)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'For data derived from pricing history from multiple sources. Used for price analysis and for working on pricing algorithms';

ALTER TABLE `items_PriceAnalysis` 
  ADD UNIQUE INDEX `unique`(itemid, time, uniqueHelper);

ALTER TABLE `items_PriceAnalysis` 
  ADD INDEX itemidTime(itemid, phaseitemid, time);

ALTER TABLE `items_PriceAnalysis` 
  ADD CONSTRAINT `_phaseitemid` FOREIGN KEY (phaseitemid)
    REFERENCES items_phases(phaseitemid) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `items_PriceAnalysis` 
  ADD CONSTRAINT `items_PriceAnalysis_itemid` FOREIGN KEY (itemid)
    REFERENCES items(id) ON DELETE CASCADE ON UPDATE CASCADE;