CREATE TABLE `gleamgiveawaycodes` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `gleamgiveawayid` INT(11) NOT NULL DEFAULT 0 COMMENT 'ID that separates this code from other gleam giveaways. No relationship to other table',
  `givetime` INT(11) NOT NULL DEFAULT 0 COMMENT 'UNIX timestamp when the code was given to a user',
  `userid` INT(11) UNSIGNED DEFAULT NULL COMMENT '->users.id; NULL when not yet distributed to any user',
  `code` CHAR(8) NOT NULL DEFAULT '',
  PRIMARY KEY (id, gleamgiveawayid, givetime)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Codes that can be submitted on the Gleam giveaway widget to get entries. Distributed to users by setting the userid column.
As of 21.12.2023, table is manually populated.';

ALTER TABLE `gleamgiveawaycodes` 
  ADD CONSTRAINT `gleamgiveawaycodes_userid` FOREIGN KEY (userid)
    REFERENCES users(id);