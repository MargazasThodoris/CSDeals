CREATE TABLE `steamItems_Descriptions` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `classid` BIGINT(10) UNSIGNED NOT NULL,
  `instanceid` BIGINT(10) UNSIGNED NOT NULL,
  `marketname` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `appid` INT(11) NOT NULL DEFAULT 0 COMMENT 'used for determining contextid and appid for tables that refer to this table',
  `contextid` INT(11) NOT NULL DEFAULT 0 COMMENT 'used for determining contextid and appid for tables that refer to this table',
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'UNIX timestamp of this entry',
  `description` TEXT DEFAULT NULL COMMENT 'The JSON description from Steam',
  PRIMARY KEY (id, classid, instanceid)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs descriptions from items as returned by the Steam inventory endpoints. Any references to Steam items in our system refer to this table for the description.
We should never trust the tradable and Tradable After in the description, because they don''t affect the instanceid.';

ALTER TABLE `steamItems_Descriptions` 
  ADD UNIQUE INDEX uniq(classid, instanceid, marketname);