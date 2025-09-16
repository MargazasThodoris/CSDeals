CREATE TABLE `Skinport_API_ItemSaleHistoryGrouped` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` INT(10) UNSIGNED DEFAULT NULL,
  `itemid` INT(11) DEFAULT NULL,
  `last7daysMin` DECIMAL(8, 2) DEFAULT NULL,
  `last7daysMax` DECIMAL(8, 2) DEFAULT NULL,
  `last7daysAvg` DECIMAL(8, 2) DEFAULT NULL,
  `last7daysVol` INT(9) DEFAULT NULL,
  `last30daysMin` DECIMAL(8, 2) DEFAULT NULL,
  `last30daysMax` DECIMAL(8, 2) DEFAULT NULL,
  `last30daysAvg` DECIMAL(8, 2) DEFAULT NULL,
  `last30daysVol` INT(9) DEFAULT NULL,
  `last90daysMin` DECIMAL(8, 2) DEFAULT NULL,
  `last90daysMax` DECIMAL(8, 2) DEFAULT NULL,
  `last90daysAvg` DECIMAL(8, 2) DEFAULT NULL,
  `last90daysVol` INT(9) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `Skinport_API_ItemSaleHistoryGrouped` 
  ADD UNIQUE INDEX itemid_time(itemid, time);