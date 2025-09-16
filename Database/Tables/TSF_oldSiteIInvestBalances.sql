CREATE TABLE `TSF_oldSiteIInvestBalances` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `steamid` BIGINT(20) UNSIGNED NOT NULL,
  `TSFbalance` DECIMAL(11, 4) NOT NULL,
  `balanceCreditedId` INT(10) UNSIGNED DEFAULT NULL,
  `creditAtTime` INT(255) NOT NULL DEFAULT 0,
  `isBalanceCredited` TINYINT(255) GENERATED ALWAYS AS (if(`balanceCreditedId` is null,0,1)) VIRTUAL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `TSF_oldSiteIInvestBalances` 
  ADD INDEX steamid(creditAtTime, steamid);