CREATE TABLE `inspectcache` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `steamid` BIGINT(20) UNSIGNED NOT NULL,
  `assetid` BIGINT(20) UNSIGNED NOT NULL,
  `inspectcode` BIGINT(20) UNSIGNED NOT NULL,
  `paintwear` DOUBLE(15, 14) UNSIGNED NOT NULL,
  `paintseed` MEDIUMINT(9) DEFAULT NULL,
  `paintindex` MEDIUMINT(8) UNSIGNED NOT NULL,
  `firstseen` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  `itemid` INT(10) UNSIGNED DEFAULT NULL COMMENT '->items.id',
  `origin` SMALLINT(255) DEFAULT NULL,
  `defindex` SMALLINT(255) DEFAULT NULL,
  `quality` SMALLINT(255) DEFAULT NULL,
  `marketname` VARCHAR(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT 'set only if we know this but don''t know the itemid. we need this for item screenshots',
  PRIMARY KEY (id, steamid, assetid, inspectcode),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Stores inspect data CS2 item, as received from CS2 GC';

ALTER TABLE `inspectcache` 
  ADD UNIQUE INDEX uniq(steamid, assetid, inspectcode);

ALTER TABLE `inspectcache` 
  ADD CONSTRAINT `inspectcache` FOREIGN KEY (itemid)
    REFERENCES items(id) ON DELETE CASCADE ON UPDATE CASCADE;