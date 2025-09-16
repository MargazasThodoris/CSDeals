CREATE TABLE `steamInventories_SteamIDs` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `steamID64` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (id, steamID64)
)
ENGINE = MYISAM,
CHARACTER SET latin1,
CHECKSUM = 0,
COLLATE latin1_swedish_ci,
COMMENT = 'This table simply stores steamIDs so we can use a smaller key in the steamInventories_ItemHistories table';

ALTER TABLE `steamInventories_SteamIDs` 
  ADD UNIQUE INDEX uniq(steamID64);