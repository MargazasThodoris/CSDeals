DELIMITER $$

CREATE FUNCTION `getUserInventoryCount`(user_id_ int)
  RETURNS DECIMAL(8, 2)
BEGIN

  DECLARE iret decimal(8, 2);

  SELECT
    COUNT(*) INTO iret
  FROM onSiteInventories_CurrentInventories ci
    JOIN botInventories_ItemHistory bi
      ON bi.id = ci.historyId
    JOIN items i
      ON bi.itemid = i.id
    LEFT JOIN items_phases ip
      ON ip.id = i.id
      AND ip.paintindex = bi.paintindex
  WHERE ci.userid = user_id_
  AND bi.isActive = 1;


  RETURN iret;

END
$$

DELIMITER ;