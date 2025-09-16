DELIMITER $$

CREATE FUNCTION `getItemIDByOnSiteHistoryID`(on_site_history_id INT)
  RETURNS INT(11)
BEGIN

    DECLARE iret int;

  SELECT  bh.itemid INTO iret
  FROM    onSiteInventories_ItemHistory h 
          INNER JOIN botInventories_ItemHistory bh ON bh.id = h.historyId
  WHERE   h.id = on_site_history_id;

    
  RETURN(iret);
 
END
$$

DELIMITER ;