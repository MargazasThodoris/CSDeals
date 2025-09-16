CREATE TABLE `Adyen_NotificationRequestItem` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `onSiteTradeid` INT(11) DEFAULT NULL,
  `eventCode` VARCHAR(255) NOT NULL,
  `isFailed` TINYINT(1) NOT NULL DEFAULT 0,
  `failReason` VARCHAR(255) DEFAULT NULL,
  `json` LONGTEXT NOT NULL COMMENT '(DC2Type:json)',
  `parentNotificationId` INT(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci;