CREATE TABLE `steamItems_SavedImages_OLD_20250117` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `imagepath` VARCHAR(1000) NOT NULL DEFAULT '' COMMENT 'Path to the image on Steam',
  `pathMD5` BINARY(32) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0' COMMENT 'MD5 of the path. Used to index it',
  `isNoLongerAvailable` TINYINT(255) DEFAULT 0 COMMENT 'Set to 1 if CDN reports 404 error when trying to fetch the image and we don''t have the image stored.',
  PRIMARY KEY (id),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Index of locally stored Steam item images';

ALTER TABLE `steamItems_SavedImages_OLD_20250117` 
  ADD UNIQUE INDEX pathMD5(pathMD5) COMMENT 'use this to find the image instead of imagepath';

ALTER TABLE `steamItems_SavedImages_OLD_20250117` 
  ADD UNIQUE INDEX imagepath(imagepath);