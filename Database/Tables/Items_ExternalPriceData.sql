CREATE TABLE `Items_ExternalPriceData` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemid` INT(11) UNSIGNED NOT NULL COMMENT '->items.id',
  `phaseitemid` INT(255) UNSIGNED DEFAULT NULL COMMENT '->items_phases.phaseitemid',
  `time` INT(11) DEFAULT NULL,
  `localPrice` DECIMAL(7, 2) DEFAULT NULL,
  `csmoneyPrice` DECIMAL(7, 2) DEFAULT NULL,
  `lootfarmPrice` DECIMAL(7, 2) DEFAULT NULL,
  `lootfarmSteamPrice` DECIMAL(7, 2) DEFAULT NULL COMMENT 'calculated by taking the price column and dividing it with the rate column',
  `uniqueHelper` INT(255) GENERATED ALWAYS AS (ifnull(`phaseitemid`,0)) VIRTUAL,
  `csgotraderAppJSON` LONGTEXT BINARY CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (id, itemid)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'For storing third party item pricing data to be used for analysis and local price calculations';

ALTER TABLE `Items_ExternalPriceData` 
  ADD UNIQUE INDEX `unique`(itemid, time, uniqueHelper);

ALTER TABLE `Items_ExternalPriceData` 
  ADD INDEX uniq(itemid, phaseitemid, time);

ALTER TABLE `Items_ExternalPriceData` 
  ADD CONSTRAINT `Items_ExternalPriceData_itemid` FOREIGN KEY (itemid)
    REFERENCES items(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Items_ExternalPriceData` 
  ADD CONSTRAINT `Items_ExternalPriceData_phaseitemid` FOREIGN KEY (phaseitemid)
    REFERENCES items_phases(phaseitemid) ON DELETE CASCADE ON UPDATE CASCADE;