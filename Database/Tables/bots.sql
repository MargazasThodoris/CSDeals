CREATE TABLE `bots` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `steamid` BIGINT(20) UNSIGNED NOT NULL COMMENT 'SteamID64',
  `username` VARCHAR(255) NOT NULL COMMENT 'Steam username',
  `password` VARCHAR(255) NOT NULL COMMENT 'Steam password. Encrypted',
  `passwordsalt` CHAR(16) DEFAULT '' COMMENT 'Steam password salt.',
  `role` ENUM('trader','buyer','cardbot') NOT NULL DEFAULT 'trader' COMMENT 'obsolete. "trader" trades skins and "buyer" instant buys with Bitcoin',
  `APIkey` VARCHAR(255) DEFAULT NULL COMMENT 'Steam Web API key. Encrypted',
  `BitskinsAPIKey` VARCHAR(255) DEFAULT NULL COMMENT 'Bitskins API key. Encrypted',
  `Bitskins2FACode` VARCHAR(255) DEFAULT NULL COMMENT 'Bitskins 2FA totp generation seed',
  `MachineAuth` VARCHAR(255) DEFAULT NULL COMMENT 'MachineAuth Steam web cookie. Encrypted',
  `shared_secret` VARCHAR(255) DEFAULT NULL COMMENT 'Steam Guard shared_secret. Encrypted',
  `identity_secret` VARCHAR(255) DEFAULT NULL COMMENT 'Steam Guard identity_secret. Encrypted',
  `deviceID` VARCHAR(255) DEFAULT NULL COMMENT 'Required for some Steam client connections',
  `tradeoffertoken` CHAR(8) DEFAULT NULL COMMENT 'Token part of the Steam tradeoffer URL',
  `useIP` VARCHAR(20) NOT NULL DEFAULT '' COMMENT 'Bind web requests made by this bot to this local interface',
  `useWebProxyId` INT(255) UNSIGNED DEFAULT NULL COMMENT '->webProxies.id; Overrides useIP.',
  `accountCreationTime` INT(10) UNSIGNED DEFAULT NULL COMMENT 'When the Steam account was created. May be unset if it can''t be retrieved from Steam.',
  `disabled` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'When a bot is disabled, it''s the same as it was never added to the list. This is done so the botid columns don''t get messed up when removing a bot',
  `disableDeposits` TINYINT(255) DEFAULT 0 COMMENT 'Disable trading items in to this bot',
  PRIMARY KEY (id, steamid),
  UNIQUE INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_general_ci,
COMMENT = 'Steam bots configuration';

ALTER TABLE `bots` 
  ADD INDEX disabled(disabled, disableDeposits);

ALTER TABLE `bots` 
  ADD CONSTRAINT `bots_useWebProxyId` FOREIGN KEY (useWebProxyId)
    REFERENCES webProxies(id) ON DELETE SET NULL ON UPDATE SET NULL;