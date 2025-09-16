DELIMITER $$

CREATE FUNCTION `calculateCashoutFee`(amount_ DECIMAL(11, 5), currency_ CHAR(3))
  RETURNS DECIMAL(11, 5)
  DETERMINISTIC
  READS SQL DATA
BEGIN

  DECLARE iret DECIMAL(11,6);
  DECLARE fee DECIMAL(11,5);
  DECLARE fee_static DECIMAL(11,5);
  DECLARE multiplier DECIMAL(11,5) DEFAULT 1;



  IF currency_ <>  'USD' THEN

    SELECT CAST((1/rate) AS DECIMAL(11,5)) INTO multiplier FROM Currencies_Currencies c, Currencies_RateHistory r WHERE c.ISO=currency_ AND r.currencyId=c.id AND r.isMostRecent LIMIT 1;
  
  END IF;

  
  SELECT  p.withdrawalAdyenBanktransferFeeStaticEUR, p.withdrawalAdyenBanktransferFeePercent INTO  fee_static, fee 
  FROM    preferences p
  WHERE   p.id=1;
  
  SET iret = (amount_ * fee * multiplier) + fee_static;

  RETURN(iret); 
       
END
$$

DELIMITER ;