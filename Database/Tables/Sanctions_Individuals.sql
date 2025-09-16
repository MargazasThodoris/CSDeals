CREATE TABLE `Sanctions_Individuals` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fieldName` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `value` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Download the PDF from here
https://data.europa.eu/euodp/fi/data/dataset/consolidated-list-of-persons-groups-and-entities-subject-to-eu-financial-sanctions

parse from the PDF using this regex

(Name/Alias|Name): ([^  ].+?)\\s\\s';