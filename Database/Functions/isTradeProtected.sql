DELIMITER $$

CREATE FUNCTION `isTradeProtected`(tradeId INT)
  RETURNS INT(11)
BEGIN

  DECLARE iret INT DEFAULT 0;


SELECT  COUNT(*) INTO iret
        
FROM    steamTrades_Trades tt
        INNER JOIN steamTrades_Items ti ON ti.steamTradeId = tt.id
        INNER JOIN items i ON i.id = ti.itemid
        INNER JOIN steamInventories_ItemHistories iih ON iih.id = ti.steamInventoryHistoryId
        INNER JOIN steamItems_Descriptions id ON id.id = iih.descriptionid
WHERE   tt.id = tradeId
        AND tt.tradeType = 5 -- TYPE_LIST_FOR_SALE = 5
        AND tt.toInventoryId=9 --  INVENTORY_ID_USER_LISTED_SALES = 9
        AND i.appid=730
        AND ti.botInventoryHistoryId IS NULL
        AND ti.onSiteHistoryId IS NULL
        AND tt.sendFailedTime IS NULL
        AND tt.tradeofferid=0; 

        RETURN (iret > 0);

END
$$

DELIMITER ;