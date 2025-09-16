CREATE TABLE `snapshot_RevalidateImageCaches` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `imageId` INT(11) UNSIGNED NOT NULL COMMENT '->snapshot_Images.id',
  PRIMARY KEY (id, imageId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Entries for snapshot images that should be retaken, instead of reading from storage, whenever they are requested again';