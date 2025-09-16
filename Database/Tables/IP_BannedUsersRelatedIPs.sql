CREATE TABLE `IP_BannedUsersRelatedIPs` (
  `IPstr` VARCHAR(255) NOT NULL COMMENT 'IP address',
  `time` INT(10) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp of the ban',
  PRIMARY KEY (IPstr)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs IPs a user has used when they are banned. Used to quickly look up whether an IP address is related to a banned account.';

ALTER TABLE `IP_BannedUsersRelatedIPs` 
  ADD UNIQUE INDEX IPstr(IPstr);