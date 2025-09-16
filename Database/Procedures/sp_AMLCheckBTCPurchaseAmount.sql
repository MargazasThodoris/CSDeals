DELIMITER $$

CREATE PROCEDURE `sp_AMLCheckBTCPurchaseAmount`(IN user_id BIGINT, IN total_amount VARCHAR(16))
BEGIN

    DECLARE iret int DEFAULT 0;

    DECLARE time_diff int;
    DECLARE time_added int;
    DECLARE counter int;

    -- SELECT 1 AS Status; 

    SELECT COUNT(*) INTO counter  FROM tblUserProfile t WHERE t.user_id= user_id AND t.is_suspicious=0 OR t.is_whitelisted=1;
    
    IF (counter > 0) THEN
        SET iret = 0;
    ELSE
          SELECT COUNT(*) INTO counter  FROM tblUserProfile t WHERE t.user_id= user_id;
          IF counter = 0 THEN 
            SET iret = existCryptoBalanceAnomaly(user_id);
            INSERT INTO    tblUserProfile
            SELECT  u.id AS user_id,
                    iret AS is_suspicious,
                    IF (u.adyenIndividualIsVerifiedForReceivingPayments=1 AND u.adyenIndividualIsBalanceRestricted=0, 1, 0) AS is_kyc,
                    IF(u.thirdPartyVerificationLevel > 0 AND u.thirdPartyVerificationLevel <> 99999, 1, 0) AS is_kyt,
                    IF(u.thirdPartyVerificationLevel = 99999, 1, 0) AS is_tradelocked,0              
            FROM    users u
            WHERE   u.id = user_id;
          ELSE
             SET iret =1;
          END IF;          
    END IF;

    /*IF user_id IN (58178, 636656) THEN
      SET iret = 0;
    ELSE
      SET iret = existCryptoBalanceAnomaly(user_id);
    END IF;*/

 
    IF (iret = 0) THEN 

      SELECT IFNULL(timeadded, 0) INTO time_added FROM users WHERE id = user_id	;

      SET time_diff = UNIX_TIMESTAMP() - time_added;

      IF ( (CAST(total_amount AS DECIMAL(10,2)) > 500.0) AND (time_diff < (3*86400))) THEN     
          
        SET iret=1;
     
      END IF;

    END IF;

  
    IF iret = 1 THEN 

      SELECT 0 AS Status;

    ELSE

      SELECT 1 AS Status;

    END IF;

/*    

    DECLARE kyt_enabled int DEFAULT 0;

    SELECT users.thirdPartyVerificationLevel INTO kyt_enabled FROM users WHERE ID = user_id;

    
    IF (user_id IN  (0)) THEN
    
      SELECT 0 INTO iret;
    
    ELSE 

      SELECT IF(COUNT(*) > 0, 1, 0) INTO iret 
      FROM (SELECT
          u.id AS userID
        FROM tblSkinsBackOrder sbo
          INNER JOIN users u
        WHERE sbo.steam_id = u.steamid
        AND sbo.user_currency = 'BTC'
        AND sbo.status_id = 1
        AND u.id = user_id
        UNION
        SELECT
          t.userId AS userID
        FROM userSales_CompletedSales t
        WHERE t.isBitcoinSale = 1
        AND t.userId = user_id
        UNION
        SELECT
          t2.userId AS userID
        FROM Crypto_BTC_IncomingTransactions_New t1
          INNER JOIN Crypto_BTC_WalletAddresses_New t2
            ON t2.id = t1.addressId
        WHERE t2.userId = user_id) AS T;

  END IF;

  IF kyt_enabled > 0 THEN 
    SELECT 1 AS Status;
  ELSE
    SELECT iret AS Status;
  END IF;
 */ 
   
END
$$

DELIMITER ;