CREATE TABLE `Accounting_Types` (
  `id` TINYINT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `const` VARCHAR(255) NOT NULL COMMENT 'Human readable string constant for this type',
  `description` VARCHAR(255) DEFAULT NULL COMMENT 'Description of this type',
  `includeInRevenueCalculations` TINYINT(255) DEFAULT 1 COMMENT 'Whether to to include this type in revenue calculations',
  `accountingCategory` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'Under which category to put this in accounting. Used by Excel files for categorization of profits and expenses',
  PRIMARY KEY (id, const),
  INDEX id(id),
  INDEX id_2(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Types for accounting categories';

ALTER TABLE `Accounting_Types` 
  ADD UNIQUE INDEX code(const);