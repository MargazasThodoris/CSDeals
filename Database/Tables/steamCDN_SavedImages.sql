CREATE TABLE `steamCDN_SavedImages` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cdnPath` VARCHAR(1024) NOT NULL DEFAULT '' COMMENT 'The path in Steam CDN',
  `pathMD5` BINARY(32) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0' COMMENT 'MD5 of the path. Used to index it',
  PRIMARY KEY (id),
  INDEX id(id)
)
ENGINE = MYISAM,
CHARACTER SET latin1,
CHECKSUM = 0,
COLLATE latin1_swedish_ci,
COMMENT = 'Index of Steam CDN paths that we have saved locally';

ALTER TABLE `steamCDN_SavedImages` 
  ADD UNIQUE INDEX pathMD5(pathMD5) COMMENT 'use this to find the image instead of imagepath';