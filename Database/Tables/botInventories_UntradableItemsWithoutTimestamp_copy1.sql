CREATE TABLE `botInventories_UntradableItemsWithoutTimestamp_copy1` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `historyId` BIGINT(20) UNSIGNED NOT NULL COMMENT '->botInventories_ItemHistory.id',
  `time` INT(11) DEFAULT 0 COMMENT 'UNIX timestamp of this entry',
  PRIMARY KEY (id, historyId)
)
ENGINE = MYISAM,
CHARACTER SET latin1,
CHECKSUM = 0,
COLLATE latin1_swedish_ci,
COMMENT = 'For new items in the Steam inventory the tradable after tag isn''t set immidiately upon receiving the items. This table keeps track of those items so they won''t be shown on the trade bot and trick people that the items are tradable.';

ALTER TABLE `botInventories_UntradableItemsWithoutTimestamp_copy1` 
  ADD INDEX historyId(historyId);