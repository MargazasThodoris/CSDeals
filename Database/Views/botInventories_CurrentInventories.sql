CREATE VIEW `botInventories_CurrentInventories`
AS
	SELECT
	  `botInventories_ItemHistory`.`id` AS `historyId`,
	  `botInventories_ItemHistory`.`amount` AS `amount`,
	  `botInventories_ItemHistory`.`botid` AS `botid`,
	  `steamItems_Descriptions`.`appid` AS `appid`,
	  `steamItems_Descriptions`.`contextid` AS `contextid`
	FROM (`botInventories_ItemHistory`
	  LEFT JOIN `steamItems_Descriptions`
	    ON (`botInventories_ItemHistory`.`descriptionId` = `steamItems_Descriptions`.`id`))
	WHERE `botInventories_ItemHistory`.`isActive` = 1;