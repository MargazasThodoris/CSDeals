CREATE TABLE `AdyenPayouts` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(36) NOT NULL,
  `time` INT(10) UNSIGNED NOT NULL,
  `userId` INT(11) NOT NULL,
  `amountToDeductBeforeFees` DECIMAL(10, 2) NOT NULL,
  `amountToSendInTargetCurrency` DECIMAL(10, 2) NOT NULL,
  `payoutFeeAmount` DECIMAL(8, 2) NOT NULL,
  `currencyConversionFeeAmount` DECIMAL(8, 2) NOT NULL,
  `sourceCurrencyISO` VARCHAR(3) NOT NULL,
  `targetCurrencyISO` VARCHAR(3) NOT NULL,
  `status` INT(11) NOT NULL,
  `feeTransferRequestData` LONGTEXT DEFAULT NULL COMMENT '(DC2Type:json)',
  `feeTransferRequestResponse` LONGTEXT DEFAULT NULL COMMENT '(DC2Type:json)',
  `conversionRequestData` LONGTEXT DEFAULT NULL COMMENT '(DC2Type:json)',
  `conversionRequestResponse` LONGTEXT DEFAULT NULL COMMENT '(DC2Type:json)',
  `payoutRequestData` LONGTEXT DEFAULT NULL COMMENT '(DC2Type:json)',
  `payoutRequestResponse` LONGTEXT DEFAULT NULL COMMENT '(DC2Type:json)',
  `feeRefundRequestData` LONGTEXT DEFAULT NULL COMMENT '(DC2Type:json)',
  `feeRefundResponse` LONGTEXT DEFAULT NULL COMMENT '(DC2Type:json)',
  `AdyenBalanceAccountLocalId` INT(11) DEFAULT NULL,
  `AdyenPayoutFxBalanceAccountLocalId` INT(11) DEFAULT NULL,
  `AdyenTransferInstrumentLocalId` INT(11) DEFAULT NULL,
  `adyenLegalEntityLocalId` INT(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci;

ALTER TABLE `AdyenPayouts` 
  ADD UNIQUE INDEX UNIQ_CCF4FEB4D17F50A6(uuid);

ALTER TABLE `AdyenPayouts` 
  ADD INDEX IDX_CCF4FEB445C8E441(AdyenBalanceAccountLocalId);

ALTER TABLE `AdyenPayouts` 
  ADD INDEX IDX_CCF4FEB485C7E91B(AdyenPayoutFxBalanceAccountLocalId);

ALTER TABLE `AdyenPayouts` 
  ADD INDEX IDX_CCF4FEB47C14B50(AdyenTransferInstrumentLocalId);

ALTER TABLE `AdyenPayouts` 
  ADD INDEX IDX_CCF4FEB4304C359B(adyenLegalEntityLocalId);

ALTER TABLE `AdyenPayouts` 
  ADD INDEX search_user(userId);