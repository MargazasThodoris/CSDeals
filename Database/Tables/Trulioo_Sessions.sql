CREATE TABLE `Trulioo_Sessions` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `userId` INT(11) NOT NULL,
  `xHfSession` VARCHAR(255) NOT NULL COMMENT 'In webhook callbacks, this is the key ''id''',
  `timestamp` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb3_unicode_ci;

ALTER TABLE `Trulioo_Sessions` 
  ADD UNIQUE INDEX xHfSession(xHfSession);