CREATE TABLE `tblSkinsBackOrderPayment` (
  `transaction_id` BIGINT(20) NOT NULL,
  `time` DATETIME NOT NULL DEFAULT current_timestamp(),
  `request` TEXT DEFAULT NULL,
  `response` TEXT DEFAULT NULL,
  `status_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (transaction_id, time)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `tblSkinsBackOrderPayment` 
  ADD CONSTRAINT `FK_tblSkinsBackOrderPayment_status_id` FOREIGN KEY (status_id)
    REFERENCES tblSkinsBackStatus(id) ON DELETE NO ACTION;

ALTER TABLE `tblSkinsBackOrderPayment` 
  ADD CONSTRAINT `FK_tblSkinsBackOrderPayment_transaction_id` FOREIGN KEY (transaction_id)
    REFERENCES tblSkinsBackOrder(transaction_id) ON DELETE NO ACTION;