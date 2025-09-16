DELIMITER $$

CREATE FUNCTION `getCompanyBitcoins`()
  RETURNS DECIMAL(13, 8)
  DETERMINISTIC
  READS SQL DATA
BEGIN

  DECLARE iret decimal(13,8);

  SELECT totalWalletBitcoinBalance INTO iret FROM preferences;
  
  RETURN iret;
END
$$

DELIMITER ;