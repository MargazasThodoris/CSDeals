CREATE TABLE `TSF_lang_preloadgroupentries` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `groupID` INT(11) NOT NULL,
  `stringID` INT(11) NOT NULL,
  PRIMARY KEY (id, groupID, stringID)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `TSF_lang_preloadgroupentries` 
  ADD UNIQUE INDEX uniq(groupID, stringID);