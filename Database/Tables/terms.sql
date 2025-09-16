CREATE TABLE `terms` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` CHAR(36) NOT NULL,
  `title` LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `body` LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `class` VARCHAR(255) NOT NULL DEFAULT 'modal-sm',
  `arcticmodal_option` LONGTEXT BINARY CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`arcticmodal_option`)),
  `time_added` TIMESTAMP NULL DEFAULT current_timestamp(),
  `active` BIT(1) NOT NULL DEFAULT b'0',
  `uuid` CHAR(36) NOT NULL DEFAULT uuid(),
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `terms` 
  ADD UNIQUE INDEX `key`(`key`);