CREATE TABLE `Adyen_LegalEntities` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `adyenLegalEntityId` VARCHAR(25) NOT NULL,
  `json` LONGTEXT NOT NULL COMMENT 'Cached JSON data of the entity, updated via API requests(DC2Type:json)',
  `legalEntityType` INT(11) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci;

ALTER TABLE `Adyen_LegalEntities` 
  ADD UNIQUE INDEX UNIQ_2663F18C5BAA64F5(adyenLegalEntityId);