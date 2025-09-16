DELIMITER $$

CREATE FUNCTION `isUserBanned`(user_id int)
  RETURNS INT(11)
BEGIN

  DECLARE iret int DEFAULT 0;

  SELECT
    ub.id INTO iret
  FROM Users_Bans ub
  WHERE ub.userId = user_id
  AND ub.isActive = 1
  ORDER BY ub.time DESC
  LIMIT 1;


  RETURN iret;

END
$$

DELIMITER ;