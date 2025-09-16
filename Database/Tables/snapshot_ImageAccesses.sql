CREATE TABLE `snapshot_ImageAccesses` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `imageId` INT(11) UNSIGNED NOT NULL COMMENT '->snapshot_Images.id',
  `referer` VARCHAR(512) NOT NULL DEFAULT '',
  `refererMD5` VARCHAR(32) NOT NULL DEFAULT '',
  `accessCount` INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (id, imageId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Log where entries are created each time a snapshot is viewed. Does not work as the images are cached locally and on Cloudflare.';

ALTER TABLE `snapshot_ImageAccesses` 
  ADD UNIQUE INDEX uniq(imageId, refererMD5);