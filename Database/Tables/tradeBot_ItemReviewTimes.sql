CREATE TABLE `tradeBot_ItemReviewTimes` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `onSiteHistoryId` BIGINT(20) UNSIGNED NOT NULL COMMENT '->onSiteInventories_ItemHistory.id',
  `endTime` INT(11) NOT NULL COMMENT 'UNIX timestamp when this entry is removed. Random 15-30 seconds after the item is moved to the trade bot inventory',
  PRIMARY KEY (id, onSiteHistoryId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Trade bot item review times';

ALTER TABLE `tradeBot_ItemReviewTimes` 
  ADD INDEX lookup(onSiteHistoryId, endTime);