CREATE TABLE `Adyen_Webhook_Notifications` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `endpoint` INT(11) NOT NULL,
  `time` INT(11) NOT NULL,
  `requestHeadersJSON` TEXT DEFAULT NULL,
  `rawContent` TEXT DEFAULT NULL,
  `authenticationFailed` TINYINT(255) DEFAULT 0,
  `failReason` VARCHAR(2048) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `processingLogs` TEXT DEFAULT NULL,
  `isFailed` TINYINT(255) GENERATED ALWAYS AS (if(`failReason` is null,0,1)) STORED,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `Adyen_Webhook_Notifications` 
  ADD INDEX endpoint(time, endpoint);