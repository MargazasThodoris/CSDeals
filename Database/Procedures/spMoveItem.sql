DELIMITER $$

CREATE PROCEDURE `spMoveItem`(IN on_site_history_id_ INT, IN source_inventory_id_ INT, IN target_inventory_id_ INT)
  DETERMINISTIC
  MODIFIES SQL DATA
sp:BEGIN

    
    DECLARE amount_ int;    
    DECLARE bot_history_id_ int;
    DECLARE on_site_history_target_id_ int;

    DECLARE continue_handler BOOLEAN DEFAULT TRUE;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        SET continue_handler = FALSE;
    
    
    IF on_site_history_id_ IS null THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'On site inventory id must be defined';
        LEAVE sp;
    ELSEIF source_inventory_id_ IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Source on site inventory id must be defined';
        LEAVE sp;
  ELSEIF target_inventory_id_ IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Target on site inventory id must be defined';
        LEAVE sp;
    END IF;



    START TRANSACTION;

    SELECT t.amount, t.historyId INTO amount_, bot_history_id_ FROM onSiteInventories_ItemHistory t WHERE t.id = on_site_history_id_;
    
    
    UPDATE  onSiteInventories_ItemHistory t
    SET     t.timeGone = IF((t.amount-amount_=0), UNIX_TIMESTAMP(), t.timeGone),
            t.uniqueHelper = IF((amount-amount_= 0), t.id, 0),
            t.amount = t.amount-amount_
    WHERE   t.id = on_site_history_id_
            AND t.inventoryId = source_inventory_id_;
            
    SET @tx_c = ROW_COUNT();

    IF (@tx_c = 0) THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not enough items are available for transfer !!';
    END IF;

    INSERT INTO onSiteInventories_ItemHistory
    SET amount = amount_,
        inventoryId = target_inventory_id_,
        historyId = bot_history_id_,
        timeSeen = UNIX_TIMESTAMP(),
        uniqueHelper=0,
        itemStackHelper=NULL ON DUPLICATE KEY UPDATE amount = amount + amount_;

    SET @tx_c = ROW_COUNT();
    
    IF @tx_c = 0 THEN
      ROLLBACK;
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Could not assign bot inventory history id to onSiteInventory';
    END IF;

    SET on_site_history_target_id_ = LAST_INSERT_ID();

    INSERT INTO onSiteInventories_ItemTransactionHistory
    SET sourceOnSiteHistoryId = on_site_history_id_,
        targetOnSiteHistoryId = on_site_history_target_id_,
        fromInventoryId = source_inventory_id_,
        toInventoryId = target_inventory_id_,
        amount = amount_,
        onSiteTradeItemId = NULL,
        steamTradeItemId=null;


    SET @tx_c = ROW_COUNT();
    
    IF @tx_c = 0 THEN
      ROLLBACK;
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Something went wront !!!.';
    END IF;

    IF target_inventory_id_ = 2 THEN -- INVENTORY_ID_TRADE_BOT
    
      INSERT INTO tradeBot_ItemReviewTimes
      SET onSiteHistoryId = on_site_history_target_id_,
          endTime = UNIX_TIMESTAMP() + FLOOR(RAND() * 40) + 10;
      
    END IF;

    IF source_inventory_id_ = 2 OR source_inventory_id_ = 9  THEN -- INVENTORY_ID_TRADE_BOT or INVENTORY_ID_USER_LISTED_SALES

      UPDATE userSales_IndexedSales
      SET   totalAmount = totalAmount-IF(amount_>0, _amount, totalAmount)
      WHERE onSiteHistoryId = on_site_history_id_ ;

      DELETE  
      FROM  userSales_IndexedSales_original 
      WHERE onSiteHistoryId = on_site_history_id_
            AND totalAmount <=0; 
           
    END IF;  
    
    IF NOT continue_handler THEN
        -- Roll back the transaction
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error during transaction; changes rolled back';
    ELSE
                
        COMMIT;

    END IF;          
            
END
$$

DELIMITER ;