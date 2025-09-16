CREATE TABLE `API_permissions` (
  `keyId` INT(11) UNSIGNED DEFAULT NULL COMMENT 'Either keyId or userId must be set',
  `userId` INT(10) UNSIGNED DEFAULT NULL COMMENT 'users.id',
  `endpointId` INT(255) UNSIGNED NOT NULL COMMENT 'API_Endpoints.id',
  `timeGranted` INT(11) DEFAULT NULL COMMENT 'UNIX timestamp when this entry was created',
  `timeRevoked` DATETIME DEFAULT NULL COMMENT 'UNIX timestamp when this permission was revoked',
  `adminDescription` VARCHAR(255) DEFAULT NULL,
  `isActive` TINYINT(255) GENERATED ALWAYS AS (if(`timeRevoked` is null,1,0)) VIRTUAL COMMENT 'Whether the permission is not revoked'
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Manages permissions to REST API endpoints that require additional permissions to use';

ALTER TABLE `API_permissions` 
  ADD INDEX byKey(keyId, endpointId, isActive);

ALTER TABLE `API_permissions` 
  ADD INDEX byUser(userId, endpointId, isActive);

ALTER TABLE `API_permissions` 
  ADD CONSTRAINT `APIPermissionEndpoint` FOREIGN KEY (endpointId)
    REFERENCES API_endpoints(id);

ALTER TABLE `API_permissions` 
  ADD CONSTRAINT `APIpermissionUserId` FOREIGN KEY (userId)
    REFERENCES users(id);