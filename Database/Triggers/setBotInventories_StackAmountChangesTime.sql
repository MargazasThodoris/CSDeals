DELIMITER $$

CREATE TRIGGER `setBotInventories_StackAmountChangesTime`
	BEFORE INSERT
	ON botInventories_ItemStackAmountChanges
	FOR EACH ROW
SET NEW.time=UNIX_TIMESTAMP()
$$

DELIMITER ;