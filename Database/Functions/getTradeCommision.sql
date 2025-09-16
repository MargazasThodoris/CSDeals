DELIMITER $$

CREATE FUNCTION `getTradeCommision`(trade_id_ INT, currency_iso_ CHAR(3))
  RETURNS DECIMAL(8, 2)
BEGIN

    DECLARE iret_transfers DECIMAL(8,2); 
    DECLARE iret_splits DECIMAL(8,2);
    DECLARE btc_eur_to_sellers DECIMAL(8,2);
    DECLARE btc_usd_to_sellers DECIMAL(8,2);
    DECLARE fiat_eur_to_sellers DECIMAL(8,2);
    DECLARE fiat_usd_to_sellers DECIMAL(8,2);
    DECLARE usd_from_buyer DECIMAL(8,2);
    DECLARE eur_from_buyer DECIMAL(8,2);
    DECLARE iret DECIMAL(8,2);

  
    SELECT  IFNULL(SUM(value)/100, 0) AS value INTO iret_transfers					 
		FROM    onSiteTrades_Adyen_Orders_Transfers tr
            INNER JOIN onSiteTrades_Trades t ON tr.onSiteTradeid = t.id
    WHERE   tr.type IN(1,2) 
            AND t.isAccepted
            AND tr.targetCurrencyISO=currency_iso_
            AND t.id = trade_id_;


    SELECT  IFNULL(SUM(value), 0) AS value INTO iret_splits			
    FROM 	  onSiteTrades_Adyen_Orders_PaymentSplits spl 
            INNER JOIN onSiteTrades_Trades t ON t.id = spl.onSiteTradeid
		WHERE 	spl.type IN(1,2) 				
				    AND t.isAccepted
            AND CASE spl.currency
                  WHEN 1 THEN 'USD'
                  WHEN 3 THEN 'EUR'
                  ELSE ''
                END = currency_iso_
             AND t.id = trade_id_;


                
    SELECT 	IFNULL(ROUND(SUM(btc.amount*ao.rateBitcoinEur),2), 0) INTO btc_eur_to_sellers
    FROM 	  onSiteTrades_Items_balanceBTC btc 
            INNER JOIN onSiteTrades_Adyen_Orders ao ON ao.onSiteTradeId = btc.onSiteTradeId
            INNER JOIN onSiteTrades_Adyen_Orders_Items o ON o.onSiteTradeItemId = btc.onSiteTradeItemId
    WHERE   o.onSiteTradeId = trade_id_
            AND ao.isPayWithBitcoin=1
            AND o.originalPriceInCurrency=3;
            

    SELECT 	IFNULL(ROUND(SUM(btc.amount*ao.rateBitcoinEur/ao.rateUsdEur),2), 0) INTO btc_usd_to_sellers
    FROM 	  onSiteTrades_Items_balanceBTC btc 
            INNER JOIN onSiteTrades_Adyen_Orders ao ON ao.onSiteTradeId = btc.onSiteTradeId
            INNER JOIN onSiteTrades_Adyen_Orders_Items o ON o.onSiteTradeItemId = btc.onSiteTradeItemId
    WHERE   o.onSiteTradeId = trade_id_
            AND ao.isPayWithBitcoin=1
            AND o.originalPriceInCurrency=1;            
          
            
    SELECT 	IFNULL(SUM(value)/100, 0) INTO fiat_eur_to_sellers
    FROM 	  onSiteTrades_Adyen_Orders_Transfers tr             
            INNER JOIN onSiteTrades_Adyen_Orders o ON o.onSiteTradeId = tr.onSiteTradeid
    WHERE 	tr.targetCurrencyISO='EUR'            
						AND 	tr.onSiteTradeid=trade_id_
            AND o.isPayWithBitcoin=1;
            

    SELECT 	IFNULL(SUM(value)/100, 0) INTO fiat_usd_to_sellers
    FROM 	  onSiteTrades_Adyen_Orders_Transfers tr                        
            INNER JOIN onSiteTrades_Adyen_Orders o ON o.onSiteTradeId = tr.onSiteTradeid
    WHERE 	tr.targetCurrencyISO='USD'            
						AND 	tr.onSiteTradeid=trade_id_
            AND o.isPayWithBitcoin=1;            


     SELECT IFNULL(SUM(o.orderDirectTotal), 0) INTO usd_from_buyer
     FROM   onSiteTrades_Adyen_Orders o          
     WHERE  o.onSiteTradeId = trade_id_
            AND o.isPayWithBitcoin=1
            AND o.paymentCurrency=1;

              
     SELECT IFNULL(SUM(o.orderDirectTotal), 0) INTO eur_from_buyer
     FROM   onSiteTrades_Adyen_Orders o            
     WHERE  o.onSiteTradeId = trade_id_
            AND o.isPayWithBitcoin=1
            AND o.paymentCurrency=3;
            
    SELECT 
      CASE currency_iso_
        WHEN 'USD' THEN iret_transfers + iret_splits + (usd_from_buyer - fiat_usd_to_sellers - btc_usd_to_sellers)
        WHEN 'EUR' THEN iret_transfers + iret_splits + (eur_from_buyer - fiat_eur_to_sellers - btc_eur_to_sellers)
        ELSE 0
      END INTO iret;
    
    RETURN(iret);
 
END
$$

DELIMITER ;