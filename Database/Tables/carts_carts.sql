CREATE TABLE `carts_carts` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `UUID` CHAR(36) NOT NULL,
  `createdByIP` VARCHAR(46) NOT NULL COMMENT 'IP address on which the cart was created. Used to prevent abuse',
  `createdByUserId` INT(11) UNSIGNED DEFAULT NULL COMMENT '->users.id',
  `time` INT(10) UNSIGNED DEFAULT NULL COMMENT 'timestamp when cart was created',
  `lastAccessed` VARCHAR(255) DEFAULT NULL COMMENT 'timestamp when cart was last accessed/used',
  PRIMARY KEY (id, UUID, createdByIP),
  UNIQUE INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Marketplace item carts';

ALTER TABLE `carts_carts` 
  ADD UNIQUE INDEX UUID(UUID);

ALTER TABLE `carts_carts` 
  ADD CONSTRAINT `cart_userid` FOREIGN KEY (createdByUserId)
    REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE;