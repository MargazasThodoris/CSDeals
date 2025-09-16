DELIMITER $$

CREATE PROCEDURE `spReportGetProtectedTrades`(IN steamId BIGINT, IN startDate VARCHAR(10), IN endDate VARCHAR(10), IN page INT, IN num INT)
BEGIN

  DECLARE offset_ int DEFAULT (page-1) * num;
  
  
  IF (endDate IS NULL
    OR CHAR_LENGTH(TRIM(endDate)) < 10
    OR endDate NOT REGEXP '^\\d{4}-\\d{2}-\\d{2}$') THEN

    SET endDate = STR_TO_DATE(CURDATE(), '%Y-%m-%d');


  END IF;

  IF (startDate IS NULL
    OR CHAR_LENGTH(TRIM(startDate)) < 10
    OR startDate NOT REGEXP '^\\d{4}-\\d{2}-\\d{2}$') THEN

    SET startDate = STR_TO_DATE(DATE_SUB(CURRENT_DATE(), INTERVAL 5 YEAR), '%Y-%m-%d');

  END IF;


 SELECT i.market_hash_name AS 'Item Name', 
        FROM_UNIXTIME(t.timeQueued) AS TimeQueue, 
        DATE_ADD(FROM_UNIXTIME(t.timeQueued, '%Y-%m-%d 07:00:00'), INTERVAL 8 DAY ) AS 'Trade-Protected and cannot be consumed, modified, or transferred until' ,  
        t.botid AS BotID, 
        t.tradeid AS TradeID
 FROM   steamTrades_Trades t 
      INNER JOIN steamTrades_Items ti ON ti.steamTradeId = t.id
      INNER JOIN items i ON i.id = ti.itemid
      INNER JOIN users u ON u.id = t.userid
 WHERE  i.appid=730
        AND t.isAccepted = 1  
        AND t.tradeType=5       
        AND FROM_UNIXTIME(t.timeQueued, '%Y-%m-%d') >= STR_TO_DATE(startDate, '%Y-%m-%d')
        AND FROM_UNIXTIME(t.timeQueued, '%Y-%m-%d') <= STR_TO_DATE(endDate, '%Y-%m-%d')
        AND u.steamid= steamId 
        AND isTradeProtected(t.id) = 1
  LIMIT num OFFSET offset_;

END
$$

DELIMITER ;