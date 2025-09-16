CREATE TABLE `lang_textIDs` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `stringID` INT(11) NOT NULL,
  `textID` VARCHAR(255) NOT NULL COMMENT 'This is the ID of the string in text format, for easier readibility',
  `removed` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'If this shouldn''t be included in listings and exports and whatnot',
  `location` VARCHAR(255) DEFAULT NULL COMMENT 'This should be a source code location, not used for cs.deals',
  `contextText` VARCHAR(255) DEFAULT NULL,
  `developerComments` VARCHAR(255) DEFAULT NULL,
  `translatorComments` TEXT DEFAULT NULL,
  PRIMARY KEY (id, stringID, textID)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Simply a lookup table to have a string for each unique translation ID';

ALTER TABLE `lang_textIDs` 
  ADD UNIQUE INDEX uniq(stringID, textID);

ALTER TABLE `lang_textIDs` 
  ADD INDEX stringID(stringID);