CREATE TABLE `TSF_API_endpoints` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `interface` VARCHAR(64) NOT NULL,
  `endpoint` VARCHAR(64) NOT NULL,
  `version` SMALLINT(255) NOT NULL DEFAULT 1,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `TSF_API_endpoints` 
  ADD UNIQUE INDEX `unique`(interface, endpoint, version);