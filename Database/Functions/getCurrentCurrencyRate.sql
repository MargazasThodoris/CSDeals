DELIMITER $$

CREATE FUNCTION `getCurrentCurrencyRate`(iso char(3))
  RETURNS DECIMAL(11, 5)
BEGIN

  DECLARE iret decimal(11, 5);

  SELECT
    rate INTO iret
  FROM Currencies_Currencies c,
       Currencies_RateHistory r
  WHERE c.ISO = iso
  AND r.currencyId = c.id
  AND r.isMostRecent LIMIT 1;
  RETURN iret;
END
$$

DELIMITER ;