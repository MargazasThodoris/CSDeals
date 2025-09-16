DELIMITER $$

CREATE FUNCTION `convertMinorUnitsToDecimal`(_mu VARCHAR(255))
  RETURNS DECIMAL(14, 4)
BEGIN

DECLARE iret decimal(14,4);

SET iret = CAST(CONCAT(LEFT(_mu, (LENGTH(_mu)-2)), '.', RIGHT(_mu, 2)) AS decimal(14,2));

RETURN iret;

END
$$

DELIMITER ;