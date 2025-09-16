CREATE TABLE `reftracking` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ref` ENUM('indiepromo','marzu','steamwizard','csgozone','csgozone2','go4tk','freestyle','5eplay') NOT NULL,
  `time` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `IP` BIGINT(20) UNSIGNED NOT NULL,
  `IPstr` VARCHAR(46) NOT NULL DEFAULT '',
  `referer` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `reftracking` 
  ADD INDEX fastsearch(IPstr);