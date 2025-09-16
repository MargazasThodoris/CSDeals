DELIMITER $$

CREATE FUNCTION `existCryptoBalanceAnomaly`(user_id INT(10))
  RETURNS INT(11)
BEGIN

  DECLARE iret int(11) DEFAULT 1;
  
  DECLARE sum_cryptousd_balance_transactions DECIMAL(14,4) DEFAULT 0.0;
  DECLARE sum_cryptousd_balance_transactions_out DECIMAL(14,4) DEFAULT 0.0;
  DECLARE no_cryptousd_balance_transactions int DEFAULT 0;
  DECLARE sum_btc_balance_transactions DECIMAL(14,4) DEFAULT 0.0;
  DECLARE no_btc_balance_transactions int DEFAULT 0;
  DECLARE kyt_status int DEFAULT 0;
  DECLARE cryptousd_balance decimal (14,4) DEFAULT 0;

  IF user_id IN (-1) THEN
    RETURN (1);
  END IF;

  SELECT IFNULL(u.thirdPartyVerificationLevel, 0), IFNULL(u.balanceStableCryptoUSD, 0) INTO kyt_status, cryptousd_balance  FROM users u WHERE u.id = user_id;  

  /*
    Check if user has beem KYT verified (thirdPartyVerificationLevel > 0) and user is not tradelocked (thirdPartyVerificationLevel = 9999)
  */

    
  /*IF (kyt_status > 0) AND (kyt_status <> 99999) THEN

    SET iret = 0;

    RETURN (iret);
   
  END IF;*/
    
  SELECT COUNT(*) INTO no_cryptousd_balance_transactions FROM Users_BalanceTransactions_StableCrypto t WHERE t.userid=user_id;

  IF no_cryptousd_balance_transactions > 0 THEN

--     SELECT IFNULL(SUM(t.amountUSD), 0) INTO sum_cryptousd_balance_transactions FROM Users_BalanceTransactions_StableCrypto t WHERE t.userid=user_id; 
--     SELECT IFNULL(SUM(t.amountUSD), 0) INTO sum_cryptousd_balance_transactions_out FROM Users_BalanceTransactions_StableCrypto t WHERE t.userid=user_id AND source = 100; /* Instant sell */ 
      
      SELECT IFNULL(SUM(t.amountUSD), 0), IFNULL(SUM(IF(source = 100, t.amountUSD, 0)), 0) INTO sum_cryptousd_balance_transactions, sum_cryptousd_balance_transactions_out FROM Users_BalanceTransactions_StableCrypto t WHERE t.userid=user_id; 


  END IF;

  SELECT COUNT(*) INTO no_btc_balance_transactions FROM Users_BalanceTransactions_BTC t WHERE t.userid=user_id; 

  IF no_btc_balance_transactions > 0 THEN

    SELECT IFNULL(SUM(t.amount), 0) INTO sum_btc_balance_transactions FROM Users_BalanceTransactions_BTC t WHERE t.userid=user_id; 

  END IF;
  

  IF  ( (sum_btc_balance_transactions = 0) AND (no_btc_balance_transactions > 0) ) THEN
    
    SET iret = 0;
  
  END IF;   

  IF  ( (sum_cryptousd_balance_transactions = sum_cryptousd_balance_transactions_out) AND (no_cryptousd_balance_transactions > 0) ) THEN  /* instant sell */
  
    SET iret = 0;
  
  END IF;

  IF  ( ((sum_cryptousd_balance_transactions < 0) OR (sum_cryptousd_balance_transactions <> cryptousd_balance)) AND (no_cryptousd_balance_transactions > 0) ) THEN
    
    SET iret = 1;
  
  END IF;  


  
RETURN iret;

END
$$

DELIMITER ;