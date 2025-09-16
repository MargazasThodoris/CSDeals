CREATE TABLE `messenger_messages` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `body` LONGTEXT NOT NULL,
  `headers` LONGTEXT NOT NULL,
  `queue_name` VARCHAR(190) NOT NULL,
  `created_at` DATETIME NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` DATETIME NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` DATETIME DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_unicode_ci;

ALTER TABLE `messenger_messages` 
  ADD INDEX IDX_75EA56E0FB7336F0(queue_name);

ALTER TABLE `messenger_messages` 
  ADD INDEX IDX_75EA56E0E3BD61CE(available_at);

ALTER TABLE `messenger_messages` 
  ADD INDEX IDX_75EA56E016BA31DB(delivered_at);