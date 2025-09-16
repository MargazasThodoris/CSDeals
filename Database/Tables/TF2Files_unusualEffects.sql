CREATE TABLE `TF2Files_unusualEffects` (
  `defindex` INT(255) UNSIGNED NOT NULL,
  `nameEnglish` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (defindex)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `TF2Files_unusualEffects` 
  ADD UNIQUE INDEX defindex(defindex);

ALTER TABLE `TF2Files_unusualEffects` 
  ADD INDEX name(nameEnglish);