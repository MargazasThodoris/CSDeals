DELIMITER $$

CREATE TRIGGER `insertCurrentSteamInventories2`
	AFTER INSERT
	ON steamInventories_ItemHistories
	FOR EACH ROW
INSERT INTO steamInventories_CurrentInventories SET steamID64_id=NEW.steamID64_id, appid=NEW.appid, contextid=NEW.contextid, historyId=NEW.id
$$

DELIMITER ;