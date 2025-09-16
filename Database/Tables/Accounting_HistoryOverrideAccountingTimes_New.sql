CREATE TABLE `Accounting_HistoryOverrideAccountingTimes_New` (
  `accountingHistoryId` INT(11) UNSIGNED NOT NULL COMMENT 'Accounting_History_New.id',
  `overrideTime` INT(10) UNSIGNED NOT NULL COMMENT 'new UNIX timestamp',
  PRIMARY KEY (accountingHistoryId)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci,
COMMENT = 'If an accounting entry should be included in accounting exports at a different time than the Account_History_New.time, it is inserted in this table to override the time.';

ALTER TABLE `Accounting_HistoryOverrideAccountingTimes_New` 
  ADD UNIQUE INDEX uniq(accountingHistoryId);

ALTER TABLE `Accounting_HistoryOverrideAccountingTimes_New` 
  ADD CONSTRAINT `accountHistoryId` FOREIGN KEY (accountingHistoryId)
    REFERENCES Accounting_History_New(id) ON DELETE CASCADE ON UPDATE CASCADE;