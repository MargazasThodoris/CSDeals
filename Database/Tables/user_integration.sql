CREATE TABLE `user_integration` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `integration_id` INT(11) NOT NULL,
  `user_id` INT(10) UNSIGNED NOT NULL,
  `integration_user_id` INT(11) NOT NULL,
  `created_at` DATE NOT NULL COMMENT '(DC2Type:date_immutable)',
  `deleted_at` DATE DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_unicode_ci;

ALTER TABLE `user_integration` 
  ADD INDEX IDX_54F2A40E9E82DDEA(integration_id);

ALTER TABLE `user_integration` 
  ADD INDEX IDX_54F2A40EA76ED395(user_id);

ALTER TABLE `user_integration` 
  ADD CONSTRAINT `FK_54F2A40E9E82DDEA` FOREIGN KEY (integration_id)
    REFERENCES integration(id);

ALTER TABLE `user_integration` 
  ADD CONSTRAINT `FK_54F2A40EA76ED395` FOREIGN KEY (user_id)
    REFERENCES users(id);