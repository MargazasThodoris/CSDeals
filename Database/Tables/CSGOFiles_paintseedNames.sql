CREATE TABLE `CSGOFiles_paintseedNames` (
  `itemtype` VARCHAR(255) NOT NULL,
  `paint` VARCHAR(255) NOT NULL,
  `paintseed` SMALLINT(255) UNSIGNED NOT NULL,
  `text` VARCHAR(20) NOT NULL,
  PRIMARY KEY (itemtype, paint, paintseed)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Index of special names for specific itemtype+paintseed combos. For example special patterns and Fade percentages.
Not CS2 game file related. Naming is incorrect.';

ALTER TABLE `CSGOFiles_paintseedNames` 
  ADD UNIQUE INDEX uniq(itemtype, paint, paintseed);