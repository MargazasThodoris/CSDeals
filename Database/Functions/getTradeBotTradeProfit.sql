DELIMITER $$

CREATE FUNCTION `getTradeBotTradeProfit`(trade_id_ INT)
  RETURNS DECIMAL(8, 2)
BEGIN

    DECLARE ourItemsOutPrice_ DECIMAL(8,2);
    DECLARE userItemsInPrice_ DECIMAL(8,2);
    DECLARE userBalanceChange_ DECIMAL(8,2);
    DECLARE lostProfitFromPriceChanges_ DECIMAL(8,2);
    DECLARE iret DECIMAL(8,2);

 
  
    SELECT  SUM(tbt.botItemsPrice-tbt.userSaleBotItemsPrice) , 
            SUM(tbt.userItemsPrice), 
            SUM(tbt.userTradeBotBalanceChange + tbt.userSaleItemsSellPrice) INTO ourItemsOutPrice_, userItemsInPrice_, userBalanceChange_
    FROM    tradeBotTrades tbt
            JOIN users u ON tbt.userid=u.id
            LEFT JOIN steamTrades_Trades st ON st.id=tbt.steamTradeId
            LEFT JOIN onSiteTrades_Trades ot ON ot.id=tbt.onSiteTradeId
    WHERE   tbt.isAccepted
            AND tbt.id = trade_id_;

    SELECT  SUM(iph1.price-iph2.price) INTO lostProfitFromPriceChanges_ 
    FROM    onSiteInventories_ItemTransactionHistory t
            JOIN onSiteInventories_ItemTransactionHistory t2 ON t2.targetOnSiteHistoryId=t.sourceOnSiteHistoryId
            LEFT JOIN steamTrades_Items sti1 ON sti1.id=t2.steamTradeItemId
            LEFT JOIN onSiteTrades_Items oti1 ON oti1.id=t2.onSiteTradeItemId
            JOIN itemPriceHistory iph1 ON iph1.id=IFNULL(oti1.priceHistoryId, sti1.priceHistoryId)
            LEFT JOIN steamTrades_Items sti2 ON sti2.id=t.steamTradeItemId
            LEFT JOIN onSiteTrades_Items oti2 ON oti2.id=t.onSiteTradeItemId
            LEFT JOIN itemPriceHistory iph2 ON iph2.id=IFNULL(oti2.priceHistoryId, sti2.priceHistoryId)
    WHERE   t.fromInventoryId=2 -- THIS IS THE TRADE BOT INVENTORY
            AND iph2.price >0 
            AND iph1.price >0 
            AND ( t.onSiteTradeItemId IN (
                                            SELECT  sti.id 
                                            FROM    tradeBotTrades tbt 
                                                    INNER JOIN onSiteTrades_Items sti ON sti.onSiteTradeId = tbt.onSiteTradeId  
                                            WHERE tbt.id = trade_id_
                                          )
                  OR 
                  t.steamTradeItemId IN (
                                            SELECT  ti.id 
                                            FROM    tradeBotTrades tbt 
                                                    INNER JOIN steamTrades_Items ti ON ti.steamTradeId= tbt.steamTradeId  
                                            WHERE tbt.id = trade_id_
                                          )
                );  


    SET iret =  userItemsInPrice_- ourItemsOutPrice_- lostProfitFromPriceChanges_- userBalanceChange_;
    
    RETURN(iret);
 
END
$$

DELIMITER ;