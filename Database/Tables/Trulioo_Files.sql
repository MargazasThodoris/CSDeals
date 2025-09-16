CREATE TABLE `Trulioo_Files` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `userId` INT(11) NOT NULL,
  `truliooImageId` VARCHAR(255) DEFAULT NULL,
  `fileType` VARCHAR(255) NOT NULL,
  `type` INT(11) NOT NULL,
  `wasApproved` TINYINT(1) NOT NULL,
  `encryptionKey` VARCHAR(10) NOT NULL COMMENT 'The images are saved on disk and encrypted with this key to improve security',
  `timestamp` INT(10) UNSIGNED NOT NULL,
  `truliooTransaction` INT(255) DEFAULT NULL,
  `copyFromId` INT(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci;

ALTER TABLE `Trulioo_Files` 
  ADD UNIQUE INDEX truliooImageId(truliooImageId);

ALTER TABLE `Trulioo_Files` 
  ADD INDEX userId(userId);

ALTER TABLE `Trulioo_Files` 
  ADD INDEX IDX_326385C724D80D60(copyFromId);

ALTER TABLE `Trulioo_Files` 
  ADD INDEX IDX_326385C77945E72E(truliooTransaction);