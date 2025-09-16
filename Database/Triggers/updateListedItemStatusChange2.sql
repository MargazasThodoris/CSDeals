DELIMITER $$

CREATE TRIGGER `updateListedItemStatusChange2`
	BEFORE UPDATE
	ON userSales_ListedItemsHistory
	FOR EACH ROW
IF NEW.status <> OLD.status THEN
     SET NEW.statusChangeTime = UNIX_TIMESTAMP();     
END IF
$$

DELIMITER ;