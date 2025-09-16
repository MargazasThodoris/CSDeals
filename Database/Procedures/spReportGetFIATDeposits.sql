DELIMITER $$

CREATE PROCEDURE `spReportGetFIATDeposits`(IN steamId bigint, IN startDate varchar(10), IN endDate varchar(10), IN page INT, IN num INT)
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



  SELECT  et.time AS DateTime,
        es.name AS Status,
        ett.name AS Type,
        et.order_id AS OrderID,
        et.crypto_address AS CryptoAddress,
        et.usd_amount AS 'Amount ($)',
        et.euro_amount AS 'Amount(€)'
FROM    external_transaction et
        INNER JOIN external_status es ON es.id = et.status_id
        INNER JOIN external_transaction_type ett ON ett.id = et.type_id
        INNER JOIN users u ON u.id = et.user_id
WHERE   et.provider_id=1
        AND ett.id = 1         
        AND DATE_FORMAT(et.time, '%Y-%m-%d') >= STR_TO_DATE(startDate, '%Y-%m-%d')
        AND DATE_FORMAT(et.time, '%Y-%m-%d') <= STR_TO_DATE(endDate, '%Y-%m-%d')
        AND u.steamid = steamId
LIMIT num OFFSET offset_; 

END
$$

DELIMITER ;