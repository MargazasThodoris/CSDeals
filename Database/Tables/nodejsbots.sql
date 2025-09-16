CREATE TABLE `nodejsbots` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `steamid` BIGINT(20) UNSIGNED NOT NULL,
  `username` VARCHAR(255) NOT NULL COMMENT 'Steam username',
  `password` VARCHAR(255) NOT NULL COMMENT 'Steam password (encrypted)',
  `passwordsalt` CHAR(16) DEFAULT '' COMMENT 'Steam password salt for encryption',
  `shared_secret` VARCHAR(255) DEFAULT NULL COMMENT 'Steam Guard shared_secret. Encrypted',
  `identity_secret` VARCHAR(255) DEFAULT NULL COMMENT 'Steam Guard identity_secret. Encrypted',
  `deviceID` VARCHAR(255) DEFAULT NULL COMMENT 'Required for some Steam client connections',
  `useIP` VARCHAR(20) NOT NULL DEFAULT '' COMMENT 'Bind web requests made by this bot to this local interface',
  `useWebProxyId` INT(255) UNSIGNED DEFAULT NULL COMMENT '->webProxies.id; Overrides useIP.',
  `disabled` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'When a bot is disabled, it''s the same as it was never added to the list. This is done so the botid columns don''t get messed up when removing a bot',
  PRIMARY KEY (id, steamid)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_general_ci,
COMMENT = 'Inspect workers bots configuration';

ALTER TABLE `nodejsbots` 
  ADD INDEX uniq(username);

ALTER TABLE `nodejsbots` 
  ADD INDEX uniq2(steamid);

ALTER TABLE `nodejsbots` 
  ADD CONSTRAINT `nodejsbots_useWebProxyId` FOREIGN KEY (useWebProxyId)
    REFERENCES webProxies(id) ON DELETE SET NULL ON UPDATE SET NULL;