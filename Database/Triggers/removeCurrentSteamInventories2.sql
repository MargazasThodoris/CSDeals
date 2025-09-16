DELIMITER $$

CREATE TRIGGER `removeCurrentSteamInventories2`
	BEFORE UPDATE
	ON steamInventories_ItemHistories
	FOR EACH ROW
IF(NEW.timegone!=0) THEN
    DELETE FROM steamInventories_CurrentInventories WHERE historyId=OLD.id AND steamID64_id=OLD.steamID64_id;
END IF
$$

DELIMITER ;