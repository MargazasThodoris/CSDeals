CREATE TABLE `inspect_Stickers` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `inspectCacheId` BIGINT(20) UNSIGNED NOT NULL COMMENT '->inspectcache.id; To which inspected item this is related to',
  `slot` SMALLINT(255) DEFAULT NULL COMMENT 'As reported by CS2 GC',
  `stickerId` MEDIUMINT(9) DEFAULT NULL COMMENT 'As reported by CS2 GC',
  `wear` DOUBLE(18, 17) DEFAULT NULL COMMENT 'As reported by CS2 GC',
  `itemid` INT(10) UNSIGNED DEFAULT NULL COMMENT '->items.id; May not be set if the item by marketname is not recorded in our database',
  `marketname` VARCHAR(64) DEFAULT NULL COMMENT 'set if itemid couldn''t be found',
  PRIMARY KEY (id, inspectCacheId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Stores inspect data for stickers on a CS2 item, as received from CS2 GC';

ALTER TABLE `inspect_Stickers` 
  ADD UNIQUE INDEX uniq(inspectCacheId, slot);

ALTER TABLE `inspect_Stickers` 
  ADD CONSTRAINT `inspect_Stickers_` FOREIGN KEY (itemid)
    REFERENCES items(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `inspect_Stickers` 
  ADD CONSTRAINT `inspect_Stickers_inspectcacheid` FOREIGN KEY (inspectCacheId)
    REFERENCES inspectcache(id) ON DELETE CASCADE ON UPDATE CASCADE;