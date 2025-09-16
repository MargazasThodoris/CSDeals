CREATE TABLE `Users_OldBalanceToBTCBalanceConversionFails` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) UNSIGNED NOT NULL COMMENT '->users.id',
  `time` INT(11) NOT NULL COMMENT 'UNIX timestamp of this entry',
  `USDBalance` DECIMAL(11, 4) NOT NULL COMMENT 'How much old USD balance to convert',
  `companyBTCAsUSD` DECIMAL(10, 2) NOT NULL COMMENT 'How much BTC the company has in USD ',
  PRIMARY KEY (id, userId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs failures of converting users'' old USD balance to BTC balance.';