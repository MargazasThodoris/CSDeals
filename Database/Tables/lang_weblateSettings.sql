CREATE TABLE `lang_weblateSettings` (
  `id` INT(11) NOT NULL DEFAULT 1,
  `projectId` INT(11) DEFAULT NULL COMMENT 'Project ID within Weblate',
  `componentId` INT(11) DEFAULT NULL COMMENT 'Component ID within Weblate',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci,
COMMENT = 'Stores the weblate settings required for API requests to it';