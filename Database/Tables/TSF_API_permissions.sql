CREATE TABLE `TSF_API_permissions` (
  `keyId` INT(11) UNSIGNED DEFAULT NULL COMMENT 'Either keyId or userId must be set',
  `userId` INT(10) UNSIGNED DEFAULT NULL,
  `endpointId` INT(255) NOT NULL,
  `timeGranted` INT(11) DEFAULT NULL,
  `timeRevoked` DATETIME DEFAULT NULL,
  `adminDescription` VARCHAR(255) DEFAULT NULL,
  `isActive` TINYINT(255) GENERATED ALWAYS AS (if(`timeRevoked` is null,1,0)) VIRTUAL
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `TSF_API_permissions` 
  ADD INDEX byKey(keyId, endpointId, isActive);

ALTER TABLE `TSF_API_permissions` 
  ADD INDEX byUser(userId, endpointId, isActive);