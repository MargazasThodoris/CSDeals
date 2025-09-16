CREATE TABLE `Users_Terms` (
  `user_id` INT(11) UNSIGNED NOT NULL,
  `term_id` INT(11) UNSIGNED NOT NULL,
  `accepted` BIT(1) NOT NULL DEFAULT b'0',
  `acceptance_time` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (user_id, term_id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `Users_Terms` 
  ADD CONSTRAINT `FK_Users_Terms_term_id` FOREIGN KEY (term_id)
    REFERENCES terms(id);

ALTER TABLE `Users_Terms` 
  ADD CONSTRAINT `FK_Users_Terms_user_id` FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE NO ACTION;