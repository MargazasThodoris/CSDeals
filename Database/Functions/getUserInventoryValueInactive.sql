DELIMITER $$

CREATE FUNCTION `getUserInventoryValueInactive`(days int)
  RETURNS DECIMAL(10, 2)
BEGIN

  DECLARE iret decimal(10, 2);


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
  WHERE isUserActive(ci.userid, days) <> 0
  AND bi.isActive = 1;

  RETURN IFNULL(iret, 0);

END
$$

DELIMITER ;