CREATE TABLE `TSF_oldUserInventories` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `steamid` BIGINT(20) UNSIGNED NOT NULL,
  `appid` INT(11) NOT NULL,
  `botid` INT(11) DEFAULT NULL,
  `botUsername` VARCHAR(255) DEFAULT NULL,
  `assetid` BIGINT(20) UNSIGNED NOT NULL,
  `amount` TINYINT(255) NOT NULL DEFAULT 0,
  `temporaryOnSiteHistoryId` INT(10) UNSIGNED DEFAULT NULL COMMENT 'when the item is waiting to get transfered to the user in inventory id 11',
  `userOnSiteHistoryId` INT(255) UNSIGNED DEFAULT NULL COMMENT 'when it''s moved into the users inventory',
  PRIMARY KEY (id),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `TSF_oldUserInventories` 
  ADD UNIQUE INDEX assetid(assetid, appid);

ALTER TABLE `TSF_oldUserInventories` 
  ADD INDEX steamid(steamid);