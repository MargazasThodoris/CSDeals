DELIMITER $$

CREATE TRIGGER `userSaleIndexBotDisabled`
	BEFORE UPDATE
	ON bots
	FOR EACH ROW
UPDATE userSales_IndexedSales SET botDisabled=new.disabled WHERE botId=old.id
$$

DELIMITER ;