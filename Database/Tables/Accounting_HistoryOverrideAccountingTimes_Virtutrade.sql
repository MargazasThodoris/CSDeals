CREATE TABLE `Accounting_HistoryOverrideAccountingTimes_Virtutrade` (
  `accountingHistoryId` INT(11) NOT NULL,
  `overrideTime` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (accountingHistoryId)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

ALTER TABLE `Accounting_HistoryOverrideAccountingTimes_Virtutrade` 
  ADD UNIQUE INDEX uniq(accountingHistoryId);