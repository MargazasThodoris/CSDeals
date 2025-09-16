CREATE TABLE `userSales_Marketplace_AppItemQuantities` (
  `appid` INT(11) NOT NULL,
  `quantity` INT(255) NOT NULL,
  PRIMARY KEY (appid)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci,
COMMENT = 'Table that stores the number of items listed on the marketplace per app. Used for displaying the numbers on the website.';

ALTER TABLE `userSales_Marketplace_AppItemQuantities` 
  ADD UNIQUE INDEX appid(appid);