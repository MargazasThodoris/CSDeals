CREATE TABLE `API_keys` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` CHAR(24) NOT NULL COMMENT 'API key',
  `userId` INT(11) UNSIGNED DEFAULT NULL COMMENT 'users.id',
  `time` INT(11) DEFAULT NULL COMMENT 'UNIX timestamp when the key was created',
  `timeRevoked` INT(255) UNSIGNED DEFAULT NULL COMMENT 'timestamp when the key was revoked by user or admin',
  `isRevoked` TINYINT(255) GENERATED ALWAYS AS (if(`timeRevoked` is null,0,1)) STORED COMMENT 'If 1 this key can''t be used anymore',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'User account API keys to authorize calls to REST API';

ALTER TABLE `API_keys` 
  ADD UNIQUE INDEX uniq(`key`);

ALTER TABLE `API_keys` 
  ADD INDEX userId(userId, isRevoked);

ALTER TABLE `API_keys` 
  ADD CONSTRAINT `APIKeyUser` FOREIGN KEY (userId)
    REFERENCES users(id);