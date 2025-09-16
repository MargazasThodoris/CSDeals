CREATE TABLE `TSF_referralLinks` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'this is our main method of identifying this without exposing the ID',
  `hash` CHAR(6) BINARY CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `name` VARCHAR(32) NOT NULL DEFAULT '',
  `description` VARCHAR(512) NOT NULL DEFAULT '',
  `time` INT(11) NOT NULL,
  `disableRefCheck` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'If the regex check for the referral for the source is disabled for this. Used to improve performance.',
  `refCheckRegex` VARCHAR(256) DEFAULT NULL,
  `utm_source` VARCHAR(255) DEFAULT NULL,
  `utm_medium` VARCHAR(255) DEFAULT NULL,
  `utm_campaign` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id, hash)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `TSF_referralLinks` 
  ADD UNIQUE INDEX utm(utm_source, utm_medium, utm_campaign);

ALTER TABLE `TSF_referralLinks` 
  ADD UNIQUE INDEX uniq(hash);