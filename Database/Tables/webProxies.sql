CREATE TABLE `webProxies` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `host` VARCHAR(255) DEFAULT NULL,
  `port` SMALLINT(255) DEFAULT NULL,
  `username` VARCHAR(255) DEFAULT NULL,
  `password` VARCHAR(255) DEFAULT NULL,
  `outgoingIP` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Only required for generating the config for squid',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Configuration of proxy servers managed by us, to be used for outgoing web requests to Steam and connections to game servers using our bots';

ALTER TABLE `webProxies` 
  ADD UNIQUE INDEX uniq(host, username);