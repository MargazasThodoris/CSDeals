CREATE TABLE `Adyen_TransferInstruments` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(36) NOT NULL,
  `adyenTransferInstrumentId` VARCHAR(25) NOT NULL,
  `accountNumber` VARCHAR(255) NOT NULL,
  `currencyISO` VARCHAR(3) NOT NULL,
  `json` LONGTEXT NOT NULL COMMENT '(DC2Type:json)',
  `isDeleted` TINYINT(1) NOT NULL DEFAULT 0,
  `adyenLegalEntity_id` INT(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci;

ALTER TABLE `Adyen_TransferInstruments` 
  ADD UNIQUE INDEX UNIQ_E9AD6CB0D17F50A6(uuid);

ALTER TABLE `Adyen_TransferInstruments` 
  ADD UNIQUE INDEX UNIQ_E9AD6CB0728EE1FE(adyenTransferInstrumentId);

ALTER TABLE `Adyen_TransferInstruments` 
  ADD INDEX IDX_E9AD6CB0F85447B4(adyenLegalEntity_id);