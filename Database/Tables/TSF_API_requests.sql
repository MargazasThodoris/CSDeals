CREATE TABLE `TSF_API_requests` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `endpointId` INT(11) NOT NULL,
  `IPstr` VARCHAR(46) NOT NULL,
  `userId` INT(255) UNSIGNED DEFAULT NULL COMMENT 'This is set when done through requests with cookie authentication',
  `keyId` INT(11) UNSIGNED DEFAULT NULL,
  `time` DECIMAL(15, 4) UNSIGNED DEFAULT NULL COMMENT 'unix_timestamp with decimals being milliseconds',
  `responseCode` SMALLINT(255) DEFAULT NULL,
  `inputData` TEXT DEFAULT NULL,
  `processingTime` DECIMAL(9, 5) UNSIGNED DEFAULT NULL COMMENT 'time in microseconds',
  PRIMARY KEY (id, endpointId, IPstr)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;