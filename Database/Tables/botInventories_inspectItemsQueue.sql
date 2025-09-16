CREATE TABLE `botInventories_inspectItemsQueue` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `historyId` BIGINT(20) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Queue of CS2 item botInventoryHistoryIds that should be inspected to store their inspect data';

ALTER TABLE `botInventories_inspectItemsQueue` 
  ADD CONSTRAINT `inspectHistoryId` FOREIGN KEY (historyId)
    REFERENCES botInventories_ItemHistory(id);