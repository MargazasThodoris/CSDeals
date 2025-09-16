CREATE TABLE `tblExternalNotification` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `transaction_id` INT(11) NOT NULL,
  `time` DATETIME DEFAULT current_timestamp(),
  `response` TEXT DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `tblExternalNotification` 
  ADD CONSTRAINT `FK_tblExternalNotification_transaction_id` FOREIGN KEY (transaction_id)
    REFERENCES tblExternalTransaction(id) ON DELETE NO ACTION;