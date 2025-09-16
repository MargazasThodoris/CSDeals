CREATE TABLE `Users_VerificationDocuments` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) NOT NULL,
  `status` TINYINT(255) NOT NULL DEFAULT 0 COMMENT '0=awaiting review, 1=approved, 2=unapproved',
  `time` INT(255) UNSIGNED NOT NULL,
  `documentType` VARCHAR(255) DEFAULT NULL,
  `documentFormat` CHAR(4) DEFAULT NULL,
  `userDescription` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `userProvidedDocumentId` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `originalFileName` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `unapprovalReason` VARCHAR(255) DEFAULT NULL,
  `encryptionKey` CHAR(10) DEFAULT NULL,
  `isLatest` TINYINT(255) DEFAULT 1,
  `isFileDeleted` TINYINT(255) DEFAULT 0,
  PRIMARY KEY (id, userId, status)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'OBSOLETE. Was used for in-house identity verification';

ALTER TABLE `Users_VerificationDocuments` 
  ADD UNIQUE INDEX userId(userId, documentType, isLatest);

ALTER TABLE `Users_VerificationDocuments` 
  ADD INDEX status(status) COMMENT 'Find pending submissions';