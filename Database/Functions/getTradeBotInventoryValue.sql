DELIMITER $$

CREATE FUNCTION `getTradeBotInventoryValue`()
  RETURNS DECIMAL(8, 2)
BEGIN

    DECLARE iret DECIMAL(8,2);

    SELECT  IFNULL(SUM(IF(ip.finalPrice>0, ip.finalPrice,IF(ip.priceModifierOnly, i.finalPrice*(1+ip.priceModifier),IF(i.finalPrice>0, i.finalPrice, IFNULL(i.lastSuccessfulPrice, 0))))*ci.amount),0) INTO iret 
    FROM    onSiteInventories_CurrentInventories ci
            JOIN botInventories_ItemHistory bi ON bi.id=ci.historyId
            JOIN items i ON bi.itemid=i.id
            LEFT JOIN items_phases ip ON ip.id=i.id AND ip.paintindex=bi.paintindex
    WHERE ci.inventoryId=2;  -- TRADEBOT INVENTORY ID
    
    RETURN(iret);
 
END
$$

DELIMITER ;