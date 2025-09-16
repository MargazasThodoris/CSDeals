CREATE TABLE `userSaleIndexSearchInnoDBstopwords` (
  `value` VARCHAR(18) NOT NULL DEFAULT ''
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_general_ci,
COMMENT = 'Table to override MariaDB''s default stopwords so users can search the marketplace properly.';