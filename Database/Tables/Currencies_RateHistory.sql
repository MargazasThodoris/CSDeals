CREATE TABLE `Currencies_RateHistory` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `currencyId` INT(3) UNSIGNED NOT NULL COMMENT '->Currencies_Currencies.id',
  `rate` DECIMAL(11, 5) NOT NULL DEFAULT 1.00000 COMMENT 'USD/ISO exchange rate',
  `time` INT(255) UNSIGNED NOT NULL COMMENT 'UNIX timestamp',
  `isMostRecent` TINYINT(255) NOT NULL DEFAULT 1 COMMENT 'Whether this is the most recent entry for this currency',
  `useForDisplay` TINYINT(255) DEFAULT 0 COMMENT 'This currency rate should be used for display values of user balance and prices. Different from others to prevent balance from updating every hour',
  PRIMARY KEY (id, currencyId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `Currencies_RateHistory` 
  ADD INDEX active(currencyId, isMostRecent);

ALTER TABLE `Currencies_RateHistory` 
  ADD INDEX time(currencyId, time);

ALTER TABLE `Currencies_RateHistory` 
  ADD INDEX useForDisplay(currencyId, useForDisplay);

ALTER TABLE `Currencies_RateHistory` 
  ADD CONSTRAINT `Currencies_RateHistory_currencyId` FOREIGN KEY (currencyId)
    REFERENCES Currencies_Currencies(id) ON DELETE CASCADE ON UPDATE CASCADE;