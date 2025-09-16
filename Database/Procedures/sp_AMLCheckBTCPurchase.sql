DELIMITER $$

CREATE PROCEDURE `sp_AMLCheckBTCPurchase`(IN user_id bigint)
BEGIN

    DECLARE iret int DEFAULT 0;

    SET iret = existCryptoBalanceAnomaly(user_id);

    IF iret =1 THEN 

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

GRANT EXECUTE ON PROCEDURE sp_AMLCheckBTCPurchase TO 'csdeals_readonly'@'%';