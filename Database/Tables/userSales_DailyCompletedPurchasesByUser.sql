CREATE TABLE `userSales_DailyCompletedPurchasesByUser` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) UNSIGNED NOT NULL COMMENT '->users.id',
  `date` DATE NOT NULL,
  `isCryptoPurchase` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'Unique entries per user and whether they''re crypto purchases',
  `valueEUR` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (id, userId, date)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'This table is used to quickly calculate how much the user has sold in a specific timeframe';

ALTER TABLE `userSales_DailyCompletedPurchasesByUser` 
  ADD UNIQUE INDEX uniq(userId, date, isCryptoPurchase);