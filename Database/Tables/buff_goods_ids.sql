CREATE TABLE `buff_goods_ids` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `time` INT(11) DEFAULT NULL COMMENT 'UNIX timestamp when this entry was created',
  `goods_id` INT(10) UNSIGNED DEFAULT NULL COMMENT 'buff goods_id as reported by buff',
  `appid` INT(11) DEFAULT NULL,
  `marketname` VARCHAR(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `itemid` INT(10) UNSIGNED DEFAULT NULL COMMENT 'local itemid',
  `fullResponseJSON` TEXT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'Raw response from the buff164 web API',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Links buff163''s goods_id to local itemid';

ALTER TABLE `buff_goods_ids` 
  ADD UNIQUE INDEX itemid(itemid);

ALTER TABLE `buff_goods_ids` 
  ADD UNIQUE INDEX appidMarketname(appid, marketname);

ALTER TABLE `buff_goods_ids` 
  ADD CONSTRAINT `buffgoodsidsitemid` FOREIGN KEY (itemid)
    REFERENCES items(id);