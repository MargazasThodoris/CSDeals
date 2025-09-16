DELIMITER $$

CREATE FUNCTION `getItemPrice`(item_id_ int, phase_item_price_final_ decimal(8, 2), phase_item_price_modifier_ float, phase_item_price_modified_only_ tinyint)
  RETURNS DECIMAL(8, 2)
BEGIN

  DECLARE iret decimal(8, 2);


  SELECT
    IF(phase_item_price_final_ > 0,
    phase_item_price_final_,
    IF(phase_item_price_modified_only_,
    i.finalPrice * (1 + phase_item_price_final_),
    IF(i.finalPrice > 0,
    i.finalPrice,
    IFNULL(i.lastSuccessfulPrice, 0)
    )
    )
    ) INTO iret

  FROM items i
  WHERE i.id = item_id_;

  RETURN iret;


END
$$

DELIMITER ;