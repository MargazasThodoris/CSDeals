CREATE VIEW `vwSkinsBackOrder`
AS
	SELECT
	  `tblSkinsBackOrder`.`steam_id` AS `steam_id`,
	  FROM_UNIXTIME(`tblSkinsBackOrder`.`submission_time`) AS `submission_time`,
	  `tblSkinsBackOrder`.`transaction_id` AS `transaction_id`,
	  `tblSkinsBackOrder`.`amount` AS `amount`,
	  `tblSkinsBackOrder`.`amount_currency` AS `amount_currency`,
	  `tblSkinsBackOrder`.`user_amount` AS `user_amount`,
	  FROM_UNIXTIME(`tblSkinsBackOrder`.`offer_date`) AS `offer_date`,
	  FROM_UNIXTIME(`tblSkinsBackOrder`.`skins_send_date`) AS `skins_send_date`,
	  `tblSkinsBackOrder`.`user_currency` AS `user_currency`,
	  `tblSkinsBackOrder`.`btc_value` AS `btc_value`,
	  `tblSkinsBackStatus`.`name` AS `name`,
	  `tblSkinsBackOrder`.`amount` - `tblSkinsBackOrder`.`user_amount` AS `profit`
	FROM (`tblSkinsBackOrder`
	  JOIN `tblSkinsBackStatus`
	    ON (`tblSkinsBackOrder`.`status_id` = `tblSkinsBackStatus`.`id`));