CREATE TABLE `TSF_API_keys` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` CHAR(24) NOT NULL,
  `userId` INT(11) DEFAULT NULL,
  `isRevoked` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'If 1 this key can''t be used anymore',
  `time` INT(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `TSF_API_keys` 
  ADD UNIQUE INDEX uniq(`key`);