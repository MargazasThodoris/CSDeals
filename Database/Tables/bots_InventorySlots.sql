CREATE TABLE `bots_InventorySlots` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `botid` INT(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '->bots.id',
  `appid` INT(11) NOT NULL DEFAULT 0,
  `slots` INT(11) NOT NULL DEFAULT 0 COMMENT 'How many slots this inventory has',
  PRIMARY KEY (id, botid, appid)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Overrides the configured default Steam inventory sizes per bot and app. Used for TF2 as the inventory size can be increased for it.';

ALTER TABLE `bots_InventorySlots` 
  ADD UNIQUE INDEX uniq(botid, appid);

ALTER TABLE `bots_InventorySlots` 
  ADD CONSTRAINT `inventorySlots` FOREIGN KEY (botid)
    REFERENCES bots(id);