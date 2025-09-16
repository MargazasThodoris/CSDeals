CREATE TABLE `referralLinks` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `hash` CHAR(6) BINARY CHARACTER SET latin1 COLLATE latin1_bin NOT NULL COMMENT 'this is our main method of identifying this without exposing the ID publicly',
  `name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT 'Internal name',
  `description` VARCHAR(512) NOT NULL DEFAULT '' COMMENT 'Internal description',
  `time` INT(11) NOT NULL COMMENT 'UNIX timestamp when this was created',
  `disableRefCheck` TINYINT(4) NOT NULL DEFAULT 1 COMMENT 'If the regex check for the referral for the source is disabled for this. Used to improve performance.',
  `refCheckRegex` VARCHAR(256) DEFAULT NULL COMMENT 'If set, we check the referrer to our website and link it to this referral link if the referrer matches this regex pattern',
  `utm_source` VARCHAR(255) DEFAULT NULL COMMENT 'If a combination of utm_source, utm_medium and utm_campaign are used, they are linked to this referral link',
  `utm_medium` VARCHAR(255) DEFAULT NULL COMMENT 'If a combination of utm_source, utm_medium and utm_campaign are used, they are linked to this referral link',
  `utm_campaign` VARCHAR(255) DEFAULT NULL COMMENT 'If a combination of utm_source, utm_medium and utm_campaign are used, they are linked to this referral link',
  PRIMARY KEY (id, hash),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Referral links for tracking conversions and actions for incoming traffic';

ALTER TABLE `referralLinks` 
  ADD UNIQUE INDEX uniq(hash);

ALTER TABLE `referralLinks` 
  ADD UNIQUE INDEX utm(utm_source, utm_medium, utm_campaign);