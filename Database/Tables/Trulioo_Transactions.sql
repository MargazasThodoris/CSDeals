CREATE TABLE `Trulioo_Transactions` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `userId` INT(11) NOT NULL,
  `transactionId` VARCHAR(255) NOT NULL,
  `status` VARCHAR(255) GENERATED ALWAYS AS (json_unquote(json_extract(`json`,'$.status'))) STORED,
  `manualActionTaken` INT(255) NOT NULL DEFAULT 0,
  `manualApprovedByUserId` INT(11) DEFAULT NULL,
  `manualApprovedTime` INT(11) DEFAULT NULL,
  `json` LONGTEXT NOT NULL COMMENT '(DC2Type:json)',
  `truliooSession` INT(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci;

ALTER TABLE `Trulioo_Transactions` 
  ADD UNIQUE INDEX transactionId(transactionId);

ALTER TABLE `Trulioo_Transactions` 
  ADD INDEX IDX_DC60CDB73B819EA3(truliooSession);

ALTER TABLE `Trulioo_Transactions` 
  ADD INDEX user(userId);

ALTER TABLE `Trulioo_Transactions` 
  ADD INDEX toReview(status, manualActionTaken);