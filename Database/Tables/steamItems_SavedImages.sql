CREATE TABLE `steamItems_SavedImages` (
  `id` INT(11) NOT NULL,
  `imagepath` VARCHAR(1000) DEFAULT NULL,
  `pathMD5` BINARY(32) DEFAULT NULL,
  `isNoLongerAvailable` TINYINT(255) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `steamItems_SavedImages` 
  ADD INDEX IDX_steamItems_SavedImages_pathMD5(pathMD5);

ALTER TABLE `steamItems_SavedImages` 
  ADD INDEX IDX_steamItems_SavedImages_imagepath(imagepath);