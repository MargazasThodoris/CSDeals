CREATE TABLE `Crypto_BTC_UserApprovedCashoutAddresses` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) UNSIGNED NOT NULL COMMENT '->users.id',
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'UNIX timestamp when this address was approved',
  `bitcoinAddress` VARCHAR(255) NOT NULL,
  `approvedByEmailAddress` VARCHAR(340) NOT NULL COMMENT 'The email address through which this address was approved',
  `description` VARCHAR(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `timeRemoved` INT(10) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp when this address was removed from approved addresses',
  `isActive` TINYINT(255) GENERATED ALWAYS AS (if(`timeRemoved` is null,1,NULL)) VIRTUAL COMMENT 'NULL, if no longer active. Used to prevent duplicate active addresses',
  PRIMARY KEY (id, userId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Table for user approved cashout addresses that the user can cashout BTC to. For security reasons addresses must be added and approved on the account.';

ALTER TABLE `Crypto_BTC_UserApprovedCashoutAddresses` 
  ADD UNIQUE INDEX uniq(bitcoinAddress, userId, isActive);

ALTER TABLE `Crypto_BTC_UserApprovedCashoutAddresses` 
  ADD CONSTRAINT `cryptoBTCUserCashoutAddresses` FOREIGN KEY (userId)
    REFERENCES users(id);