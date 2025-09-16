DELIMITER $$

CREATE FUNCTION `getTradeBotTradeItemInfo`(id_ INT)
  RETURNS LONGTEXT CHARSET utf8mb4 COLLATE utf8mb4_bin
BEGIN

    DECLARE valueIn_ DECIMAL(8,2);
    DECLARE valueOut_ DECIMAL(8,2);
    DECLARE iret_json JSON;
    DECLARE item_name_  VARCHAR(255);

 
  
SELECT Item, SUM(valueIn) /* AS Buy */ , SUM(valueOut) /* AS Sell */ INTO item_name_, valueIn_, valueOut_
FROM (
        (
            SELECT  i.market_hash_name AS Item, 
                    SUM(IF(ti.isbotitem=0, iph.buyValue, 0)) AS valueIn,   
                    SUM(IF(ti.isbotitem=1, iph.sellValue, 0)) AS valueOut
            FROM    tradeBotTrades t 
                    LEFT JOIN onSiteTrades_Trades ot ON ot.id=t.onSiteTradeId
                    LEFT JOIN steamTrades_Trades st ON st.id=t.steamTradeId
                    LEFT JOIN steamTrades_Items ti on t.steamTradeId = ti.steamTradeId AND ISNULL(ti.userSaleHistoryId)
                    LEFT JOIN tradeBot_ItemPriceHistory iph ON iph.id=ti.tradeBotPriceHistoryId
                    LEFT JOIN items i ON i.id=iph.itemid
            WHERE   (ot.isAccepted OR st.isAccepted)
                    AND i.id = id_                     
            GROUP BY  i.market_hash_name
        )
        UNION
        (
            SELECT  i.market_hash_name AS Item, 
                    SUM(IF(ti.isSendersItem=0, iph.buyValue, 0)) AS valueIn, 
                    SUM(IF(ti.isSendersItem=1, iph.sellValue, 0)) AS valueOut 
            FROM    tradeBotTrades t 
                    LEFT JOIN onSiteTrades_Trades ot ON ot.id=t.onSiteTradeId
                    LEFT JOIN steamTrades_Trades st ON st.id=t.steamTradeId
                    LEFT JOIN onSiteTrades_Items ti on t.onSiteTradeId = ti.onSiteTradeId AND ISNULL(ti.userSaleHistoryId)
                    LEFT JOIN tradeBot_ItemPriceHistory iph ON iph.id=ti.tradeBotPriceHistoryId
                    LEFT JOIN items i ON i.id=iph.itemid
            WHERE   (ot.isAccepted OR st.isAccepted)                    
                    AND i.id = id_
            GROUP BY  i.market_hash_name
          ) ) t
GROUP BY t.Item;




    SET iret_json =  JSON_OBJECT(
      'Item', item_name_,
      'Buy', valueIn_,
      'Sell', valueOut_
    );

    
    RETURN(iret_json);
 
END
$$

DELIMITER ;