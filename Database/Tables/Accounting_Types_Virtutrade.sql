CREATE TABLE `Accounting_Types_Virtutrade` (
  `id` TINYINT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `const` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) DEFAULT NULL,
  `includeInRevenueCalculations` TINYINT(255) DEFAULT 1,
  `accountingCategory` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'Under which category to put this in accounting',
  PRIMARY KEY (id, const),
  INDEX id(id),
  INDEX id_2(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `Accounting_Types_Virtutrade` 
  ADD UNIQUE INDEX code(const);