CREATE TABLE `IPs_BannedScrapers` (
  `IPstr` VARCHAR(64) NOT NULL COMMENT 'IP Address',
  `time` INT(255) UNSIGNED DEFAULT NULL,
  `comment` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (IPstr)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Table of known scraper/proxy IPs that should be banned from accessing API endpoints for gathering data. Entries are automatically added for stormproxies proxy IPs by using a local endpoint that is requested by us using stormproxies proxies';

ALTER TABLE `IPs_BannedScrapers` 
  ADD UNIQUE INDEX IPstr(IPstr);