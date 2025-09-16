CREATE TABLE `p2p_logs` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `identifier` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'uuid',
  `user_id` INT(11) UNSIGNED DEFAULT NULL COMMENT 'csdeals user id',
  `message` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `data` LONGTEXT BINARY CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `time_added` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

ALTER TABLE `p2p_logs` 
  ADD CONSTRAINT `p2p_logs_ibfk_1` FOREIGN KEY (user_id)
    REFERENCES users(id);