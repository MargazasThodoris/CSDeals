DELIMITER $$

CREATE FUNCTION `isItemOnBot`(bot_inventory_id int, amount int)
  RETURNS INT(11)
BEGIN

  DECLARE iret int DEFAULT 1;
  DECLARE count_ int DEFAULT 0;


  SELECT
    COUNT(*) INTO count_
  FROM botInventories_ItemHistory t
  WHERE t.isActive
  AND t.id = bot_inventory_id
  AND IFNULL(t.amount, 0) >= amount;

  IF (count_ > 0) THEN

    RETURN (1);

  END IF;

  RETURN (0);

END
$$

DELIMITER ;