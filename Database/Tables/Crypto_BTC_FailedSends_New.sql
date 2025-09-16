CREATE TABLE `Crypto_BTC_FailedSends_New` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) UNSIGNED DEFAULT NULL COMMENT '->users.id',
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'UNIX timestamp of the send attempt',
  `bitcoinAmount` DECIMAL(11, 8) NOT NULL,
  `bitcoinPrice` DECIMAL(11, 4) NOT NULL,
  `toAddress` VARCHAR(255) NOT NULL,
  `txFee` DECIMAL(9, 8) DEFAULT NULL COMMENT 'Transaction fee in Bitcoins',
  `txHash` CHAR(64) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  `rawTx` TEXT CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  `requiresReview` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'If it is unsure whether the transaction was sent or not, this is set to 1 so we will manually review it. If the transaction requires manual review, it may also not be automatically credited back to the user',
  `isReviewed` TINYINT(255) NOT NULL DEFAULT 0,
  `errorText` TEXT DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs any failed Bitcoin sends';

ALTER TABLE `Crypto_BTC_FailedSends_New` 
  ADD CONSTRAINT `BTCFailedSendsUserId` FOREIGN KEY (userId)
    REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE;