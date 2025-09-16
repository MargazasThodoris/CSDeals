CREATE TABLE `snapshot_Images` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `requestId` INT(11) UNSIGNED NOT NULL,
  `time` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `fileSizeBytes` INT(10) UNSIGNED NOT NULL,
  `fileDeleted` TINYINT(255) NOT NULL DEFAULT 0,
  `imageType` SMALLINT(255) NOT NULL DEFAULT 0 COMMENT '1 for full 2 sided shots and others, 2 for playside png',
  `imageFormat` SMALLINT(255) NOT NULL DEFAULT 1 COMMENT '1=jpg, 2=png, 3=gif, 4=webm',
  `totalAccessCount` INT(20) UNSIGNED NOT NULL DEFAULT 0,
  `thumbnailFileSizeBytes` INT(11) NOT NULL DEFAULT 0,
  `thumbnailLastAccessed` INT(255) DEFAULT NULL COMMENT 'Use this so we can keep thumbnails up for longer than full pictures (for screenshot page)',
  `doNotDelete` TINYINT(255) DEFAULT 0,
  `lastAccessed` INT(255) UNSIGNED DEFAULT NULL COMMENT 'We use this to delete the file when we don''t need it',
  PRIMARY KEY (id, requestId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `snapshot_Images` 
  ADD INDEX requestId(requestId, imageType);