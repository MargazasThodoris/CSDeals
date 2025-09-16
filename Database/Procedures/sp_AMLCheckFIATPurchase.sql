DELIMITER $$

CREATE PROCEDURE `sp_AMLCheckFIATPurchase`(IN user_id BIGINT)
BEGIN

  
  IF (user_id IN  (0)) THEN
    
    SELECT 0 AS Status;
    

  ELSE 

    
    SELECT    IF((UNIX_TIMESTAMP() - u.timeadded) < 300, 0, 1) AS Status     /* if use was created in last 5 minutes (300 seconds), and then a direct purchase is attempted consider user suspicious and trade lock */     
    FROM      users u
    WHERE     u.id = user_id;

/*    
    SELECT    IF(COUNT(*) > 0, 0, 1) AS Status          
    FROM      onSiteTrades_Adyen_Orders ao
              INNER JOIN onSiteTrades_Trades t ON t.id = ao.onSiteTradeId          
              INNER JOIN users u ON u.id = t.toUserId          
    WHERE     FROM_UNIXTIME(t.time, '%Y-%m-%d') = DATE_SUB(CURRENT_DATE(), INTERVAL 0 DAY)          
              AND ao.isPayWithBitcoin=0
              AND ao.paymentType =  0                   
              AND ao.paymentStatus=1
              AND u.thirdPartyVerificationLevel = 0
              -- AND isUserBanned(u.id) = 0          
              AND FROM_UNIXTIME(u.timeadded, '%Y-%m-%d') = FROM_UNIXTIME(t.time, '%Y-%m-%d')
              AND t.toUserId=user_id;
*/
END IF;
   
/*   
    SELECT 0 AS Status FROM users WHERE id = user_id;
*/

  
END
$$

DELIMITER ;