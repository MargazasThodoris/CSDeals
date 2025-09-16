CREATE TABLE `onSiteInventories_Inventories` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `inventoryNumber` SMALLINT(6) NOT NULL DEFAULT 0 COMMENT 'Incrementing number per user to identify the inventory for this user/system',
  `userId` INT(11) UNSIGNED DEFAULT NULL COMMENT '->users.id; Who owns this inventory. If null, it is a system inventory',
  `time` INT(11) NOT NULL COMMENT 'UNIX timestamp when the inventory was created',
  `name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT 'Name of the inventory. Currently not used as of 4.1.2023. For the future if we allow users to have multiple inventories for different purposes.',
  `isSystemInventory` TINYINT(255) GENERATED ALWAYS AS (if(`userId` is null,1,0)) STORED COMMENT '1 if userId=NULL',
  PRIMARY KEY (id, inventoryNumber),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Stores on-site inventories'' IDs and links them to the owner userId';

ALTER TABLE `onSiteInventories_Inventories` 
  ADD INDEX searchByUser(userId);

ALTER TABLE `onSiteInventories_Inventories` 
  ADD INDEX isSystemInventory(isSystemInventory);

ALTER TABLE `onSiteInventories_Inventories` 
  ADD CONSTRAINT `onSiteInventoryUserId` FOREIGN KEY (userId)
    REFERENCES users(id);