DELIMITER $$

CREATE FUNCTION `getTradeBotTradeInfo`(trade_id_ INT)
  RETURNS LONGTEXT CHARSET utf8mb4 COLLATE utf8mb4_bin
BEGIN

    DECLARE valueIn_ DECIMAL(8,2);
    DECLARE valueOut_ DECIMAL(8,2);
    DECLARE iret DECIMAL(8,2);
    DECLARE iret_json JSON;

 
  
SELECT SUM(valueIn), SUM(valueOut) INTO valueIn_, valueOut_
FROM (
        (
            SELECT  SUM(IF(ti.isbotitem=0, iph.buyValue, 0)) AS valueIn,   
                    SUM(IF(ti.isbotitem=1, iph.sellValue, 0)) AS valueOut
            FROM    tradeBotTrades t 
                    LEFT JOIN onSiteTrades_Trades ot ON ot.id=t.onSiteTradeId
                    LEFT JOIN steamTrades_Trades st ON st.id=t.steamTradeId
                    LEFT JOIN steamTrades_Items ti on t.steamTradeId = ti.steamTradeId AND ISNULL(ti.userSaleHistoryId)
                    LEFT JOIN tradeBot_ItemPriceHistory iph ON iph.id=ti.tradeBotPriceHistoryId
                    LEFT JOIN items i ON i.id=iph.itemid
            WHERE   t.id=trade_id_
                    AND (ot.isAccepted OR st.isAccepted)                     
        )

        UNION
        (
            SELECT  SUM(IF(ti.isSendersItem=0, iph.buyValue, 0)) AS valueIn, 
                    SUM(IF(ti.isSendersItem=1, iph.sellValue, 0)) AS valueOut 
            FROM    tradeBotTrades t 
                    LEFT JOIN onSiteTrades_Trades ot ON ot.id=t.onSiteTradeId
                    LEFT JOIN steamTrades_Trades st ON st.id=t.steamTradeId
                    LEFT JOIN onSiteTrades_Items ti on t.onSiteTradeId = ti.onSiteTradeId AND ISNULL(ti.userSaleHistoryId)
                    LEFT JOIN tradeBot_ItemPriceHistory iph ON iph.id=ti.tradeBotPriceHistoryId
                    LEFT JOIN items i ON i.id=iph.itemid
            WHERE   t.id=trade_id_
                    AND (ot.isAccepted OR st.isAccepted)                     
          ) ) t;


    SET iret_json =  JSON_OBJECT(
      'Buy', valueIn_,
      'Sell', valueOut_
    );

    
    RETURN(iret_json);
 
END
$$

DELIMITER ;