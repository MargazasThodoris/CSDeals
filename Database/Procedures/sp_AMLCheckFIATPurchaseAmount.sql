DELIMITER $$

CREATE PROCEDURE `sp_AMLCheckFIATPurchaseAmount`(IN user_id BIGINT, IN total_amount VARCHAR(16))
BEGIN

    DECLARE iret int DEFAULT 1;
    DECLARE time_diff int;
    DECLARE time_added int;



    SELECT IFNULL(timeadded, 0) INTO time_added FROM users WHERE id = user_id	;

    SET time_diff = UNIX_TIMESTAMP() - time_added;


  IF (user_id IN  (0)) THEN
    
    SET iret = 0;

  END IF;
    
  IF ( (CAST(total_amount AS DECIMAL(10,2)) > 0.5) AND (time_diff < 300)) THEN   /* Five minutes */

    SET iret = 0;
    
  END IF;  
    

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

   
/*   
    SELECT 0 AS Status FROM users WHERE id = user_id;
*/

  SELECT iret AS Status;
  
END
$$

DELIMITER ;