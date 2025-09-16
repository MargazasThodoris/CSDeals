CREATE TABLE `MoneyPayments_Orders` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `UUID` CHAR(36) NOT NULL,
  `providerId` INT(11) NOT NULL COMMENT 'const PROVIDER_G2APAY = 1;
    const PROVIDER_DAOPAY = 2;
    const PROVIDER_PAYSSION = 3;
    const PROVIDER_PAYPAL= 4;
    const PROVIDER_BANKTRANSFER= 5;
    const PROVIDER_PAYOP = 6;
    const PROVIDER_KINGUIN = 7; // used for webhook callbacks
    const PROVIDER_BINANCE = 8;',
  `status` TINYINT(255) NOT NULL DEFAULT 0 COMMENT '    const STATUS_UNPAID = 0;
    const STATUS_PAID = 1;
    const STATUS_INITIALIZED = 2;
    const STATUS_PROCESSING = 3;
    const STATUS_REJECTED = 4;
    const STATUS_CANCELED = 5;
    const STATUS_REFUNDED = 7;
    const STATUS_PARTIALLY_REFUNDED = 8;
    const STATUS_CHARGED_BACK = 9;
    const STATUS_CREATION_FAILED = 10;
    const STATUS_VOIDED = 11; // used for paypal when we void the order because we can''t sell to the buyer based on the paypal details
    const STATUS_ADMIN_PAID = 12; // marked as paid by admin
    const STATUS_ADMIN_REVIEW = 13; // when we receive a payment but can''t credit it for any reason
    const STATUS_PARTIALLY_PAID = 14; // when we receive a payment for less (added for bank transfers)
    const STATUS_OVERPAID = 15; // when we receive a payment for more (added for bank transfers)
    const STATUS_FAILED = 16; // for Payop, because we don''t want to use rejected or canceled',
  `userId` INT(11) NOT NULL,
  `IPaddress` VARCHAR(68) DEFAULT NULL,
  `IPcountry` CHAR(2) DEFAULT NULL,
  `invoiceCurrency` TINYINT(255) NOT NULL COMMENT 'which currency the customer is charged',
  `invoiceAmount` DECIMAL(16, 8) NOT NULL COMMENT 'How much we charge from the user',
  `invoiceCurrencyFee` DECIMAL(16, 8) NOT NULL COMMENT 'This is calculated from creditCurrencyFee',
  `creditCurrency` TINYINT(255) NOT NULL COMMENT 'which currency the user will be paid. Can be 0 which means tradetokens',
  `creditAmount` DECIMAL(12, 4) NOT NULL COMMENT 'how much the user will be paid to his cs.deals account',
  `creditCurrencyFee` DECIMAL(12, 4) DEFAULT NULL COMMENT 'This is added to the order',
  `ourPaidFeeAmount` DECIMAL(12, 4) DEFAULT NULL COMMENT 'When the order is paid, we will populate this with the fee we paid',
  `ourPaidFeeCurrency` TINYINT(255) DEFAULT NULL,
  `time` INT(11) NOT NULL COMMENT 'When the order was created',
  `statusUpdateTime` INT(255) UNSIGNED DEFAULT NULL COMMENT 'When the status was last updated',
  `isTestOrder` TINYINT(255) DEFAULT 0,
  `userPaidBalanceTxId` INT(10) UNSIGNED DEFAULT NULL COMMENT 'userbalancetransactions.id',
  `overpaidUserBalanceTxId` INT(255) DEFAULT NULL COMMENT 'userbalancetransactions.id, if the order was overpaid',
  `chargebackBalanceTxId` INT(255) UNSIGNED DEFAULT NULL COMMENT 'userbalancetransactions.id, if the order was charged back and we retrieved funds back from the user account',
  `refundBalanceTxId` INT(255) UNSIGNED DEFAULT NULL COMMENT 'userbalancetransactions.id',
  `voidReason` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'reason if the order was void',
  `failDetails` VARCHAR(5000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (id, UUID),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'OBSOLETE. For old balance system
Data for orders made by users. These are deposits to the website.';

ALTER TABLE `MoneyPayments_Orders` 
  ADD INDEX UUID(UUID);

ALTER TABLE `MoneyPayments_Orders` 
  ADD INDEX userId(userId, status, time);

ALTER TABLE `MoneyPayments_Orders` 
  ADD INDEX fraudcheck(userId, time);

ALTER TABLE `MoneyPayments_Orders` 
  ADD CONSTRAINT `userPaidBalanceTxId` FOREIGN KEY (userPaidBalanceTxId)
    REFERENCES userbalancetransactions(id);