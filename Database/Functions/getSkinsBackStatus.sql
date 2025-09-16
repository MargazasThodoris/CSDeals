DELIMITER $$

CREATE FUNCTION `getSkinsBackStatus`(status_ VARCHAR(255))
  RETURNS INT(11)
  DETERMINISTIC
  READS SQL DATA
BEGIN

  DECLARE iret INT;

  SELECT id INTO iret FROM tblSkinsBackStatus AS T WHERE T.const_value=status_;
  
  RETURN iret;

END
$$

DELIMITER ;