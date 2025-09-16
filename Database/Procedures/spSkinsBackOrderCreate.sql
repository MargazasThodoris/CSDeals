DELIMITER $$

CREATE PROCEDURE `spSkinsBackOrderCreate`(OUT order_id BIGINT, IN csdeasl_order_id_ NVARCHAR(255), IN steam_id_ BIGINT, IN sign_ VARCHAR(255), IN transaction_id_ BIGINT, IN status_ VARCHAR(255), IN contents_ longtext, user_currency_ varchar(255))
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
    INSERT INTO tblSkinsBackOrder
              (
                csdeals_order_id
               ,steam_id
               ,sign
               ,transaction_id
               ,status_id
               ,contents_creation,
               user_currency                
              )
              VALUES
              (               
               csdeasl_order_id_ -- order_id - VARCHAR(255) NOT NULL
               ,steam_id_ -- steam_id - INT(11) NOT NULL               
               ,sign_ -- sign - VARCHAR(255) NOT NULL
               ,transaction_id_ -- transaction_id - BIGINT(20)               
               ,4 -- ORDER CREATED
               , contents_
               ,user_currency_
              );

    -- Check if an error occurred during the insert
    IF NOT continue_handler THEN
        -- Roll back the transaction
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error during transaction; changes rolled back';
    ELSE
        -- Commit the transaction if no error occurred
        SET order_id = LAST_INSERT_ID();

        COMMIT;
    END IF;
END
$$

DELIMITER ;