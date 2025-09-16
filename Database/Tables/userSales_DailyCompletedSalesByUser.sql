CREATE TABLE `userSales_DailyCompletedSalesByUser` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) UNSIGNED NOT NULL COMMENT '->users.id',
  `date` DATE NOT NULL,
  `isCryptoSale` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'Unique entries per user and whether they''re crypto sales',
  `valueEUR` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (id, userId, date)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'This table is used to quickly calculate how much the user has sold in a specific timeframe';

ALTER TABLE `userSales_DailyCompletedSalesByUser` 
  ADD UNIQUE INDEX uniq(userId, date, isCryptoSale);