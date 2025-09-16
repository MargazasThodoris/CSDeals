CREATE TABLE `preferences_btcPrice` (
  `id` INT(11) NOT NULL DEFAULT 1,
  `BTCvalue` DECIMAL(8, 2) DEFAULT NULL COMMENT 'Current BTC/USD',
  `BTCvalueLastUpdateTime` INT(10) UNSIGNED DEFAULT NULL COMMENT 'Unix timestamp when the rate was last updated',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Table separated from preferences to hold the current Bitcoin value';