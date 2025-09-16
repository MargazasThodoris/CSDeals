CREATE TABLE `buff_phases_tag_ids` (
  `phaseitemid` INT(10) UNSIGNED NOT NULL COMMENT '->items_phases.phaseitemid',
  `tag_id` INT(10) UNSIGNED DEFAULT NULL COMMENT 'tag_id as used by buff',
  PRIMARY KEY (phaseitemid)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Converts the tag ID used by buff to our local phaseitemid';

ALTER TABLE `buff_phases_tag_ids` 
  ADD UNIQUE INDEX `unique`(phaseitemid, tag_id);

ALTER TABLE `buff_phases_tag_ids` 
  ADD CONSTRAINT `buffTagsPhaseitemid` FOREIGN KEY (phaseitemid)
    REFERENCES items_phases(phaseitemid);