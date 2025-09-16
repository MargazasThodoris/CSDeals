CREATE TABLE `buff_ItemParseHistory` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'UNIX timestamp of the entry',
  `itemid` INT(10) UNSIGNED NOT NULL COMMENT '->items.id',
  `phaseitemid` INT(255) UNSIGNED DEFAULT NULL COMMENT '->items_phases.phaseitemid',
  `type` SMALLINT(255) NOT NULL DEFAULT 0 COMMENT '0=price history, 1=searching for goods_id, 2=given to external worker',
  `success` INT(11) NOT NULL DEFAULT 1 COMMENT 'Whether the parsing was successful',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs attempts for parsing/scraping a specific item price history from buff163';

ALTER TABLE `buff_ItemParseHistory` 
  ADD INDEX quickLookup(itemid, phaseitemid, success, type, time);

ALTER TABLE `buff_ItemParseHistory` 
  ADD CONSTRAINT `buffItemParseHistoryItemId` FOREIGN KEY (itemid)
    REFERENCES items(id);

ALTER TABLE `buff_ItemParseHistory` 
  ADD CONSTRAINT `buffItemParseHistoryPhaseitemid` FOREIGN KEY (phaseitemid)
    REFERENCES items_phases(phaseitemid);