CREATE TABLE `Accounting_ManualReviewedIncludeInAccounting_Virtutrade` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `accountingHistoryId` INT(10) UNSIGNED NOT NULL,
  `time` INT(10) UNSIGNED DEFAULT NULL COMMENT 'When it was marked as include in accounting',
  `accountingCategory` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'Should be one of the same as in Accounting_Types accountingCategory fields',
  PRIMARY KEY (id, accountingHistoryId)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

ALTER TABLE `Accounting_ManualReviewedIncludeInAccounting_Virtutrade` 
  ADD UNIQUE INDEX uniq(accountingHistoryId);