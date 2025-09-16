CREATE TABLE `botInventories_CurrentItemCounts` (
  `botid` INT(11) UNSIGNED NOT NULL,
  `appid` INT(11) NOT NULL,
  `totalItemSlotsUsed` INT(255) NOT NULL DEFAULT 0,
  PRIMARY KEY (botid, appid)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Keeps track of how many items (item stacks) for each app are on each bot';

ALTER TABLE `botInventories_CurrentItemCounts` 
  ADD UNIQUE INDEX uniq(botid, appid);

ALTER TABLE `botInventories_CurrentItemCounts` 
  ADD CONSTRAINT `currentItemCountsBotId` FOREIGN KEY (botid)
    REFERENCES bots(id);