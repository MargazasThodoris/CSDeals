CREATE TABLE `Users_Affiliate` (
  `user_uuid` CHAR(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `code` CHAR(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `date_time` TIMESTAMP NULL DEFAULT current_timestamp(),
  PRIMARY KEY (user_uuid)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `Users_Affiliate` 
  ADD INDEX code(code);

ALTER TABLE `Users_Affiliate` 
  ADD CONSTRAINT `FK_Users_Affiliate_user_uuid` FOREIGN KEY (user_uuid)
    REFERENCES users(UUID);