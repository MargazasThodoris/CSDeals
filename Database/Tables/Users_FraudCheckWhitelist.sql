CREATE TABLE `Users_FraudCheckWhitelist` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) UNSIGNED NOT NULL COMMENT '->users.id',
  `deductScore` INT(255) DEFAULT NULL COMMENT 'How many points to deduct from the calculated fraudScore. Positive to make the payments more likely to go through.',
  `time` INT(10) UNSIGNED DEFAULT NULL COMMENT 'UNIX timestamp of this entry',
  PRIMARY KEY (id, userId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Settings for deducting/adding to the shopper''s calculated fraud score during an Adyen payment';

ALTER TABLE `Users_FraudCheckWhitelist` 
  ADD UNIQUE INDEX uniq(userId);