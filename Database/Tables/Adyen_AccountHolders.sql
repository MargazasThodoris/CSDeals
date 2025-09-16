CREATE TABLE `Adyen_AccountHolders` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `adyenAccountHolderId` VARCHAR(25) NOT NULL,
  `json` LONGTEXT NOT NULL COMMENT '(DC2Type:json)',
  `adyenLegalEntity_id` INT(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci;

ALTER TABLE `Adyen_AccountHolders` 
  ADD UNIQUE INDEX UNIQ_B3F490094B0D8DDC(adyenAccountHolderId);

ALTER TABLE `Adyen_AccountHolders` 
  ADD UNIQUE INDEX UNIQ_B3F49009F85447B4(adyenLegalEntity_id);