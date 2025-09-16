CREATE TABLE `steamItems_languageFiles` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `BCP47` VARCHAR(255) NOT NULL,
  `csgoFilename` VARCHAR(255) DEFAULT NULL,
  `dota2Filename` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci,
COMMENT = 'List of languages supported by CSGO and Dota2 so we can fetch the game files';