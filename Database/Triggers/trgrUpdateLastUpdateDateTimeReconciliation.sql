DELIMITER $$

CREATE TRIGGER `trgrUpdateLastUpdateDateTimeReconciliation`
	BEFORE UPDATE
	ON tblReconciliation
	FOR EACH ROW
BEGIN
  SET NEW.update_time = CURRENT_TIMESTAMP;
END
$$

DELIMITER ;