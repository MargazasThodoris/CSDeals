CREATE TABLE `ItemStateChecks` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` INT(11) UNSIGNED NOT NULL DEFAULT 0,
  `itemid` INT(11) UNSIGNED NOT NULL,
  `time` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (id, userid, itemid, time)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Log of users'' item state checks. Used to impose rate limiting on the system, to prevent scraping.';

ALTER TABLE `ItemStateChecks` 
  ADD INDEX useri(userid, time);

ALTER TABLE `ItemStateChecks` 
  ADD CONSTRAINT `ItemStateChecks_itemid` FOREIGN KEY (itemid)
    REFERENCES items(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `ItemStateChecks` 
  ADD CONSTRAINT `ItemStateChecks_userid` FOREIGN KEY (userid)
    REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE;