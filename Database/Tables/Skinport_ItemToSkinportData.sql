CREATE TABLE `Skinport_ItemToSkinportData` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `itemid` INT(10) UNSIGNED NOT NULL COMMENT '->items.id',
  `phaseitemid` INT(10) UNSIGNED DEFAULT NULL COMMENT '->items_phases.id',
  `time` INT(255) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp of the entry',
  `skinport_saleId` INT(10) UNSIGNED DEFAULT NULL,
  `skinport_productId` INT(10) UNSIGNED DEFAULT NULL,
  `skinport_url` VARCHAR(255) DEFAULT NULL,
  `skinport_otherSales_count` INT(255) DEFAULT NULL COMMENT 'Save this in case we happen to need it',
  `uniqHelper` INT(255) GENERATED ALWAYS AS (ifnull(`phaseitemid`,0)) VIRTUAL,
  PRIMARY KEY (id, itemid)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Converts our local item IDs to IDs used by Skinport. Retrieved by scraping the Skinport website';

ALTER TABLE `Skinport_ItemToSkinportData` 
  ADD UNIQUE INDEX uniq(itemid, uniqHelper);