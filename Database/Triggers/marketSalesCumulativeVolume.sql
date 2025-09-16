DELIMITER $$

CREATE TRIGGER `marketSalesCumulativeVolume`
	BEFORE INSERT
	ON steamMarket_ItemSaleHistory
	FOR EACH ROW
SET NEW.cumulativeVolume=(SELECT IFNULL((SELECT MAX(cumulativeVolume) FROM steamMarket_ItemSaleHistory WHERE itemid=NEW.itemid)+NEW.volume,NEW.volume))
$$

DELIMITER ;