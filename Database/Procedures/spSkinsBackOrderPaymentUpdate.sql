DELIMITER $$

CREATE PROCEDURE `spSkinsBackOrderPaymentUpdate`(OUT rc int, IN transaction_id_ bigint, IN status_id_ int, IN request_ longtext, IN contents_ LONGTEXT)
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
    INSERT INTO tblSkinsBackOrderPayment  (transaction_id, status_id, request, response) VALUES (transaction_id_, status_id_, request_, contents_);
    
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