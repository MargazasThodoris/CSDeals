DELIMITER $$

CREATE TRIGGER `setOnSiteInventoriesInventoriesAutomaticColumns`
	BEFORE INSERT
	ON onSiteInventories_Inventories
	FOR EACH ROW
SET NEW.time=UNIX_TIMESTAMP(), NEW.inventoryNumber=(SELECT IFNULL(MAX(inventoryNumber),0)+1 FROM onSiteInventories_Inventories WHERE userId=NEW.userId)
$$

DELIMITER ;