CREATE TABLE `integration_endpoint` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `integration_id` INT(11) NOT NULL,
  `endpoint` VARCHAR(255) NOT NULL,
  `endpoint_name` VARCHAR(30) NOT NULL,
  `access_token` VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_unicode_ci;

ALTER TABLE `integration_endpoint` 
  ADD INDEX IDX_D698CA919E82DDEA(integration_id);

ALTER TABLE `integration_endpoint` 
  ADD CONSTRAINT `FK_D698CA919E82DDEA` FOREIGN KEY (integration_id)
    REFERENCES integration(id);