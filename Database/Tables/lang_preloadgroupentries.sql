CREATE TABLE `lang_preloadgroupentries` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `groupID` INT(11) UNSIGNED NOT NULL COMMENT '->lang_preloadgroups.id',
  `stringID` INT(11) NOT NULL,
  PRIMARY KEY (id, groupID, stringID)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Contains the translation strings that should be preloaded for this group.';

ALTER TABLE `lang_preloadgroupentries` 
  ADD UNIQUE INDEX uniq(groupID, stringID);

ALTER TABLE `lang_preloadgroupentries` 
  ADD CONSTRAINT `preloadGroupEntries_groupId` FOREIGN KEY (groupID)
    REFERENCES lang_preloadgroups(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `lang_preloadgroupentries` 
  ADD CONSTRAINT `preloadGroupEntries_stringID` FOREIGN KEY (stringID)
    REFERENCES lang_textIDs(stringID) ON DELETE CASCADE ON UPDATE CASCADE;