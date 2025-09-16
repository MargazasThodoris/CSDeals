CREATE TABLE `Bitskins_SteamImages` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `image_url` VARCHAR(1024) NOT NULL DEFAULT '',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs Bitskins item image URLs';

ALTER TABLE `Bitskins_SteamImages` 
  ADD UNIQUE INDEX uniq(image_url);