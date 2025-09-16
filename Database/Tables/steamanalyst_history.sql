CREATE TABLE `steamanalyst_history` (
  `id` INT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `steamanalyst_itemid` INT(10) UNSIGNED NOT NULL,
  `itemid` INT(10) UNSIGNED NOT NULL,
  `time` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'when this was logged',
  `current_price_last_checked` INT(10) UNSIGNED NOT NULL COMMENT 'parsed time from API',
  `avg_price_7_days_raw` DECIMAL(10, 5) NOT NULL DEFAULT 0.00000,
  `avg_price_30_days_raw` DECIMAL(10, 5) NOT NULL DEFAULT 0.00000,
  `avg_price_60_days_raw` DECIMAL(10, 5) NOT NULL DEFAULT 0.00000,
  `avg_price_360_days_raw` DECIMAL(10, 5) NOT NULL DEFAULT 0.00000,
  `sold_last_24h` INT(11) NOT NULL DEFAULT 0,
  `sold_last_7d` INT(11) NOT NULL DEFAULT 0,
  `current_price` DECIMAL(6, 2) NOT NULL DEFAULT 0.00,
  `avg7_1yr` DECIMAL(10, 5) NOT NULL DEFAULT 0.00000,
  `avg30_1yr` DECIMAL(10, 5) NOT NULL DEFAULT 0.00000,
  `avg60_1yr` DECIMAL(10, 5) NOT NULL DEFAULT 0.00000,
  `ongoing_price_manipulation` TINYINT(4) NOT NULL DEFAULT 0,
  `suspicious` TINYINT(4) NOT NULL,
  `suggested_amount_avg_raw` DECIMAL(7, 2) NOT NULL DEFAULT 0.00,
  `suggested_amount_min_raw` DECIMAL(7, 2) NOT NULL DEFAULT 0.00,
  `suggested_amount_max_raw` DECIMAL(7, 2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (id, steamanalyst_itemid, itemid)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Obsolete. Preserved in case we incorporate Steam Analyst again';

ALTER TABLE `steamanalyst_history` 
  ADD UNIQUE INDEX uniq(steamanalyst_itemid, itemid, time);

ALTER TABLE `steamanalyst_history` 
  ADD INDEX quickSearch(itemid, time);