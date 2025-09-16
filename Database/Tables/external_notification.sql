CREATE TABLE `external_notification` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `external_transaction_id` INT(11) UNSIGNED DEFAULT NULL,
  `external_provider_id` INT(11) UNSIGNED DEFAULT NULL,
  `time` DATETIME DEFAULT current_timestamp(),
  `response` TEXT DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

ALTER TABLE `external_notification` 
  ADD CONSTRAINT `FK_external_notification_external_provider_id` FOREIGN KEY (external_provider_id)
    REFERENCES external_provider(id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `external_notification` 
  ADD CONSTRAINT `FK_external_notification_external_transaction_id` FOREIGN KEY (external_transaction_id)
    REFERENCES external_transaction(id) ON DELETE NO ACTION ON UPDATE NO ACTION;