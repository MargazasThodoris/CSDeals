DELIMITER $$

CREATE FUNCTION `getUserInventoryValue`(user_id_ int)
  RETURNS DECIMAL(10, 2)
BEGIN

  DECLARE iret decimal(10, 2);


  IF (user_id_ IS NOT NULL) THEN
    SELECT
      SUM(IFNULL(IFNULL(getItemPrice(i.id, ip.finalPrice, ip.priceModifierOnly, ip.priceModifier), 0) * ci.amount, 0)) INTO iret
    FROM onSiteInventories_CurrentInventories ci
      JOIN botInventories_ItemHistory bi
        ON bi.id = ci.historyId
      JOIN items i
        ON bi.itemid = i.id
      LEFT JOIN items_phases ip
        ON ip.id = i.id
        AND ip.paintindex = bi.paintindex
      LEFT JOIN (SELECT
          historyId,
          SUM(delta) AS delta
        FROM botInventories_ItemStackAmountChanges
        WHERE `time` >= (UNIX_TIMESTAMP() + 86400)
        GROUP BY historyId) t
        ON t.historyId = bi.id
    WHERE ci.userid = user_id_
    AND bi.isActive = 1;
  ELSE
    SELECT
      SUM(IFNULL(IFNULL(getItemPrice(i.id, ip.finalPrice, ip.priceModifierOnly, ip.priceModifier), 0) * ci.amount, 0)) INTO iret
    FROM onSiteInventories_CurrentInventories ci
      JOIN botInventories_ItemHistory bi
        ON bi.id = ci.historyId
      JOIN items i
        ON bi.itemid = i.id
      LEFT JOIN items_phases ip
        ON ip.id = i.id
        AND ip.paintindex = bi.paintindex
      LEFT JOIN (SELECT
          historyId,
          SUM(delta) AS delta
        FROM botInventories_ItemStackAmountChanges
        WHERE `time` >= (UNIX_TIMESTAMP() + 86400)
        GROUP BY historyId) t
        ON t.historyId = bi.id
    WHERE bi.isActive = 1;


  END IF;


  RETURN iret;

END
$$

DELIMITER ;