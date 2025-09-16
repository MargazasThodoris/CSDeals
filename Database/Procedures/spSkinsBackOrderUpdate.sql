DELIMITER $$

CREATE PROCEDURE `spSkinsBackOrderUpdate`(OUT rc int, IN sign_ VARCHAR(255), IN transaction_id_ BIGINT, IN date_ INT, IN amount_ DECIMAL(8, 2), IN amount_currency_ VARCHAR(255), IN amount_in_currencies_ JSON, IN user_amount_ DECIMAL(8, 2), IN user_amount_in_currencies_ JSON, IN offer_date_ INT, IN skins_sent_date_ INT, IN status_ VARCHAR(255), IN contents_  LONGTEXT)
  DETERMINISTIC
  MODIFIES SQL DATA
BEGIN
    -- Declare a variable to handle errors
    DECLARE continue_handler BOOLEAN DEFAULT TRUE;
    DECLARE user_id_ int;
    DECLARE btc_value_ decimal(8,2);

    

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        SET continue_handler = FALSE;

  SELECT  users.id INTO user_id_
  FROM    users 
          INNER JOIN tblSkinsBackOrder ON tblSkinsBackOrder.steam_id =  users.steamid
  WHERE   tblSkinsBackOrder.transaction_id = transaction_id_;

  SELECT BTCValue INTO btc_value_ FROM preferences_btcPrice;
   
    -- Start a transaction
    START TRANSACTION;

    -- Attempt to insert data into the table
    UPDATE tblSkinsBackOrder 
    SET
      -- sign = sign_ -- sign - VARCHAR(255) NOT NULL     
     date = date_ -- date - INT(11)
     ,amount = amount_ -- amount - DECIMAL(8, 2)
     ,amount_currency = amount_currency_ -- amount_currency - VARCHAR(255)
     ,amount_in_currencies = amount_in_currencies_ -- amount_in_currencies - LONGTEXT
     ,user_amount = user_amount_ -- user_amount - DECIMAL(8, 2)
     ,user_amount_in_currencies = user_amount_in_currencies_ -- user_amount_in_currencies - LONGTEXT
     ,offer_date = offer_date_ -- offer_date - INT(11)
     ,skins_send_date = skins_sent_date_ -- skins_send_date - INT(11)
     ,status_id = getSkinsBackStatus(status_) -- my_status_id - INT(11)
     ,contents_callback = contents_
     ,btc_value = btc_value_
    WHERE
      transaction_id = transaction_id_
      AND status_id <> 1;  -- NOT SUCCESS 
      -- AND sign = sign_;


    -- Check if an error occurred during the insert
    IF NOT continue_handler THEN
        -- Roll back the transaction
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error during transaction; changes rolled back';
            SET rc = 0;
            
    ELSE
        -- Commit the transaction if no error occurred       
        SET rc = ROW_COUNT();   
        COMMIT;
             
    END IF;
END
$$

DELIMITER ;