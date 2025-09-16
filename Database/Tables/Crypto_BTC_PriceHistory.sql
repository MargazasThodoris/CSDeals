CREATE TABLE `Crypto_BTC_PriceHistory` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` INT(10) UNSIGNED DEFAULT NULL,
  `bitstampBuyOrder` DECIMAL(8, 2) DEFAULT NULL,
  `bitstampSellOrder` DECIMAL(8, 2) DEFAULT NULL,
  `bitfinexBuyOrder` DECIMAL(8, 2) DEFAULT NULL,
  `bitfinexSellOrder` DECIMAL(8, 2) DEFAULT NULL,
  `binanceUSDTBuyOrder` DECIMAL(8, 2) DEFAULT NULL,
  `binanceUSDTSellOrder` DECIMAL(8, 2) DEFAULT NULL,
  `calculated` DECIMAL(8, 2) GENERATED ALWAYS AS (if(`binanceUSDTBuyOrder` is null or `binanceUSDTSellOrder` is null,if(`bitstampBuyOrder` is null or `bitstampSellOrder` is null,NULL,(`bitstampBuyOrder` + `bitstampSellOrder`) / 2),(`binanceUSDTBuyOrder` + `binanceUSDTSellOrder`) / 2)) STORED,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs Bitcoin price history from different sources in realtime.';

ALTER TABLE `Crypto_BTC_PriceHistory` 
  ADD INDEX time(time);