CREATE TABLE `Emails_LinkTokenData` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` INT(11) UNSIGNED NOT NULL,
  `timeUsed` INT(11) DEFAULT NULL,
  `isUsed` TINYINT(255) GENERATED ALWAYS AS (if(`timeUsed` is null,0,1)) VIRTUAL,
  `dataJSON` TEXT DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Link tokens are used to add authentication to links included in emails. For example to complete an authorized action on an account.';