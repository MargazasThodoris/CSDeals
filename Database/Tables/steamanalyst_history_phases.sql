CREATE TABLE `steamanalyst_history_phases` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parentHistoryId` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
  `paintindex` SMALLINT(6) NOT NULL DEFAULT 0,
  `min` DECIMAL(7, 2) NOT NULL DEFAULT 0.00,
  `max` DECIMAL(7, 2) NOT NULL DEFAULT 0.00,
  `avg` DECIMAL(7, 2) NOT NULL,
  PRIMARY KEY (id, parentHistoryId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Obsolete. Preserved in case we incorporate Steam Analyst again';