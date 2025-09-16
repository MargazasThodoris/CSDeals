DELIMITER $$

CREATE TRIGGER `TR_userSales_ListedItemsHistory_check_removeTime`
	BEFORE UPDATE
	ON userSales_ListedItemsHistory
	FOR EACH ROW
BEGIN
    IF NEW.removedTime IS NOT NULL THEN
        IF (CAST(NEW.removedTime AS SIGNED) - CAST(OLD.time AS SIGNED)) <= 5 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: removedTime must be greater than time by more than 5 seconds.';
        END IF;
    END IF;
END
$$

DELIMITER ;