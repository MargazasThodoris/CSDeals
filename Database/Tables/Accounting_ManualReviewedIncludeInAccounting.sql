CREATE TABLE `Accounting_ManualReviewedIncludeInAccounting` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `accountingHistoryId` INT(10) UNSIGNED NOT NULL COMMENT 'Accounting_History_New.id',
  `time` INT(10) UNSIGNED DEFAULT NULL COMMENT 'When it was marked as include in accounting',
  `accountingCategory` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'Should be one of the same as in Accounting_Types accountingCategory fields',
  PRIMARY KEY (id, accountingHistoryId)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci,
COMMENT = 'Includes references to Accounting History entries that should be included in exports, that would otherwise not be included (Accounting_Types.includeInRevenueCalculations=0). For entries like paid bills and manual entries.';

ALTER TABLE `Accounting_ManualReviewedIncludeInAccounting` 
  ADD UNIQUE INDEX uniq(accountingHistoryId);

ALTER TABLE `Accounting_ManualReviewedIncludeInAccounting` 
  ADD CONSTRAINT `accountingHistoryIdManualReview` FOREIGN KEY (accountingHistoryId)
    REFERENCES Accounting_History_New(id) ON DELETE CASCADE ON UPDATE CASCADE;