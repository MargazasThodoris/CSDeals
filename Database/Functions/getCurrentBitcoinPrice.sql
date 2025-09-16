DELIMITER $$

CREATE FUNCTION `getCurrentBitcoinPrice`()
  RETURNS DECIMAL(8, 2)
  DETERMINISTIC
BEGIN

  DECLARE iret decimal(8, 2);

  SELECT
    BTCvalue INTO iret
  FROM preferences_btcPrice;

  RETURN iret;

END
$$

DELIMITER ;