CREATE TABLE `steamMarket_OldHashNames` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemid` INT(11) NOT NULL DEFAULT 0,
  `oldNameId` INT(11) NOT NULL DEFAULT 0,
  `newNameId` INT(11) NOT NULL DEFAULT 0,
  `oldMarketHashName` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `newMarketHashName` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `time` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id, itemid, oldNameId, newNameId, oldMarketHashName, newMarketHashName)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `steamMarket_OldHashNames` 
  ADD INDEX uniq(oldMarketHashName);

ALTER TABLE `steamMarket_OldHashNames` 
  ADD INDEX uniq2(newMarketHashName);