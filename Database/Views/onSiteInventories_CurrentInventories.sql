CREATE VIEW `onSiteInventories_CurrentInventories`
AS
	SELECT
	  `onSiteInventories_ItemHistory`.`id` AS `onSiteHistoryId`,
	  `onSiteInventories_ItemHistory`.`inventoryId` AS `inventoryId`,
	  `onSiteInventories_Inventories`.`userId` AS `userid`,
	  `onSiteInventories_ItemHistory`.`historyId` AS `historyId`,
	  `onSiteInventories_ItemHistory`.`amount` AS `amount`,
	  `onSiteInventories_ItemHistory`.`timeSeen` AS `timeSeen`,
	  `botInventories_ItemHistory`.`botid` AS `botid`,
	  `botInventories_ItemHistory`.`itemid` AS `itemid`,
	  `steamItems_Descriptions`.`appid` AS `appid`,
	  `steamItems_Descriptions`.`contextid` AS `contextid`,
	  `botInventories_ItemHistory`.`classid` AS `classid`,
	  `botInventories_ItemHistory`.`instanceid` AS `instanceid`,
	  `steamItems_Descriptions`.`description` AS `description`
	FROM (((`onSiteInventories_ItemHistory`
	  JOIN `botInventories_ItemHistory`
	    ON (`onSiteInventories_ItemHistory`.`historyId` = `botInventories_ItemHistory`.`id`))
	  JOIN `steamItems_Descriptions`
	    ON (`botInventories_ItemHistory`.`descriptionId` = `steamItems_Descriptions`.`id`))
	  JOIN `onSiteInventories_Inventories`
	    ON (`onSiteInventories_Inventories`.`id` = `onSiteInventories_ItemHistory`.`inventoryId`))
	WHERE `onSiteInventories_ItemHistory`.`isActive` = 1;