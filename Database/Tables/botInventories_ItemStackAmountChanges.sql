CREATE TABLE `botInventories_ItemStackAmountChanges` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `historyId` BIGINT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '->botInventories_ItemHistory.id',
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'Time of this entry',
  `oldAmount` INT(11) NOT NULL DEFAULT 0,
  `newAmount` INT(11) NOT NULL DEFAULT 0,
  `delta` INT(11) NOT NULL DEFAULT 0 COMMENT 'Difference in old and new stack amount',
  PRIMARY KEY (id, historyId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'This table keeps track of changing stack amounts. Used to calculate the item stack amount for a specific historyId at any given time.';

ALTER TABLE `botInventories_ItemStackAmountChanges` 
  ADD CONSTRAINT `stackAmountChangesHistoryId` FOREIGN KEY (historyId)
    REFERENCES botInventories_ItemHistory(id);