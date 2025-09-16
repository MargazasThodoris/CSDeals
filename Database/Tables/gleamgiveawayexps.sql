CREATE TABLE `gleamgiveawayexps` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `gleamgiveawayid` INT(11) NOT NULL DEFAULT 0,
  `userid` INT(11) UNSIGNED NOT NULL,
  `expbeforegiveaway` INT(11) NOT NULL DEFAULT 0 COMMENT 'how much exp the user had before this giveaway was started',
  `expclaimed` INT(11) NOT NULL DEFAULT 0 COMMENT 'how much exp has been used for the giveaway. The exp available is this minus expbeforegiveaway',
  PRIMARY KEY (id, gleamgiveawayid)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Stores the exp the user had when a Gleam giveaway was started and the exp they have spent on claiming giveaway codes.';

ALTER TABLE `gleamgiveawayexps` 
  ADD UNIQUE INDEX uniq(gleamgiveawayid, userid);

ALTER TABLE `gleamgiveawayexps` 
  ADD CONSTRAINT `gleamgiveawayexps` FOREIGN KEY (userid)
    REFERENCES users(id);