CREATE TABLE `API_requests` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `endpointId` INT(11) UNSIGNED NOT NULL COMMENT 'API_Endpoints.id',
  `IPstr` VARCHAR(46) NOT NULL COMMENT 'IP address from which the request was made',
  `userId` INT(255) UNSIGNED DEFAULT NULL COMMENT 'This is set when done through requests with cookie authentication',
  `keyId` INT(11) UNSIGNED DEFAULT NULL COMMENT 'If an API key was used, API_keys.id',
  `time` DECIMAL(15, 4) UNSIGNED DEFAULT NULL COMMENT 'unix_timestamp with decimals being milliseconds',
  `responseCode` SMALLINT(255) DEFAULT NULL COMMENT 'HTTP response code',
  `inputData` TEXT DEFAULT NULL COMMENT 'JSON input data',
  `processingTime` DECIMAL(9, 5) UNSIGNED DEFAULT NULL COMMENT 'time in microseconds',
  PRIMARY KEY (id, endpointId, IPstr)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs requests made to the REST API endpoints by HTTP requests. Depending on configuration, only authenticated requests may be recorded for better performance';

ALTER TABLE `API_requests` 
  ADD INDEX userEndpoint(endpointId, time, userId);

ALTER TABLE `API_requests` 
  ADD CONSTRAINT `APIRequestAPIKey` FOREIGN KEY (keyId)
    REFERENCES API_keys(id);

ALTER TABLE `API_requests` 
  ADD CONSTRAINT `APIRequestEndpointId` FOREIGN KEY (endpointId)
    REFERENCES API_endpoints(id);

ALTER TABLE `API_requests` 
  ADD CONSTRAINT `APIRequestUSerId` FOREIGN KEY (userId)
    REFERENCES users(id);