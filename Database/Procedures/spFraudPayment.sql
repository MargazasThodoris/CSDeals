DELIMITER $$

CREATE PROCEDURE `spFraudPayment`(OUT status_ INT, IN user_id_ INT, IN item_id_ BIGINT)
  DETERMINISTIC
  MODIFIES SQL DATA
BEGIN
    -- Declare a variable to handle errors
    DECLARE continue_handler BOOLEAN DEFAULT TRUE;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        SET continue_handler = FALSE;

    -- Start a transaction
    START TRANSACTION;

    -- Attempt to insert data into the table
    
    SELECT  S.time - t.time AS TimeDelta,
        FROM_UNIXTIME(t.time) AS BuyTime,
        t.itemId AS ItemID,
        u.id AS BuyerID,
        u.personaname AS PersonaName,
        u.steamlevel AS SteamLevel,
        FROM_UNIXTIME(u.timeadded) AS UserTimeAdded,
        FROM_UNIXTIME(u.steamAccountTimeCreated) AS SteamAccountCreationTime,
        S.SaleTime, S.SellerID        
FROM    userSales_CompletedSales t        
        INNER JOIN users u ON u.id = t.buyerUserId
        INNER JOIN (
          SELECT  FROM_UNIXTIME(t.time) AS SaleTime,
                  t.time AS time,
                  t.itemId AS ItemID,
                   t.userId AS SellerID
          FROM    userSales_CompletedSales t
          WHERE   t.isBitcoinSale=0
                  AND t.userId = user_id_
                  AND t.itemId = item_id_

        ) AS S ON S.ItemID = t.itemId AND S.SellerID = u.id           
WHERE   t.currency IN (1,3)
        AND t.buyerUserId = user_id_
        AND t.itemId = item_id_
        AND S.time - t.time < 120;

    -- Check if an error occurred during the insert
    IF NOT continue_handler THEN
        -- Roll back the transaction
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error during transaction; changes rolled back';
    ELSE
        -- Commit the transaction if no error occurred
        
        SET status_ = 0;

        COMMIT;
    END IF;
END
$$

DELIMITER ;