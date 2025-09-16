CREATE TABLE `Adyen_PaymentMethodTokens` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(36) NOT NULL,
  `userId` INT(11) NOT NULL,
  `token` VARCHAR(16) NOT NULL,
  `json` LONGTEXT DEFAULT NULL COMMENT '(DC2Type:json)',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci;

ALTER TABLE `Adyen_PaymentMethodTokens` 
  ADD UNIQUE INDEX UNIQ_19D50241D17F50A6(uuid);

ALTER TABLE `Adyen_PaymentMethodTokens` 
  ADD UNIQUE INDEX unique_token(userId, token);

ALTER TABLE `Adyen_PaymentMethodTokens` 
  ADD INDEX search_user(userId);