CREATE TABLE `pricingSourceRatios` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appid` INT(11) NOT NULL DEFAULT 0,
  `pricingSource` SMALLINT(6) NOT NULL DEFAULT 0 COMMENT '0=SCM',
  `volumeRatio` FLOAT NOT NULL DEFAULT 1 COMMENT 'Ratio of sales volume',
  `priceRatio` FLOAT NOT NULL DEFAULT 1 COMMENT 'Ratio of price',
  `comment` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id, appid, pricingSource)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Stores calculated item price ratios between different item pricing sources. Used for price analysis and can be used for our own price calculations.';

ALTER TABLE `pricingSourceRatios` 
  ADD UNIQUE INDEX uniq(pricingSource, appid);