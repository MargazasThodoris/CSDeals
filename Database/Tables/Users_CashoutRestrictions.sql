CREATE TABLE `Users_CashoutRestrictions` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(10) UNSIGNED NOT NULL,
  `currency` SMALLINT(255) NOT NULL,
  `sourceDepositBalanceTxId` INT(255) UNSIGNED DEFAULT NULL,
  `time` INT(10) UNSIGNED NOT NULL,
  `endTime` INT(11) NOT NULL COMMENT 'the totaAmount will be unwithdrawable via Crypto till this time (2 weeks)',
  `forgetAfterTime` INT(255) NOT NULL,
  `spentAmount` DECIMAL(12, 4) NOT NULL DEFAULT 0.0000 COMMENT 'How much the user has spent and can withdraw',
  `totalAmount` DECIMAL(12, 4) NOT NULL COMMENT 'How much the user needs to spend to withdraw the full amount',
  `applyToBTC` TINYINT(255) NOT NULL DEFAULT 0,
  `applyToPaypalEUR` TINYINT(255) NOT NULL DEFAULT 0,
  `applyToPaypalUSD` VARCHAR(255) DEFAULT NULL,
  `applyToSEPA` TINYINT(255) NOT NULL DEFAULT 0,
  `isActive` TINYINT(255) GENERATED ALWAYS AS (if(`forgetAfterTime` > unix_timestamp() and (`endTime` > unix_timestamp() or `spentAmount` < `totalAmount`),1,0)) VIRTUAL,
  PRIMARY KEY (id, userId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'OBSOLETE: old balance system
The user cannot withdraw the restricted amount at all if they haven''t spent the deposited amount yet, regardless if the time limit has passed.
The restriction type applies to the time limit.';

ALTER TABLE `Users_CashoutRestrictions` 
  ADD INDEX user(userId, endTime, forgetAfterTime, currency);