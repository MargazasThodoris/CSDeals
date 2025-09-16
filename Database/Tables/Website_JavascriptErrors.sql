CREATE TABLE `Website_JavascriptErrors` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` INT(255) UNSIGNED NOT NULL,
  `error` TEXT NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs unhandled javascript errors submitted by website clients, from an error handler in javascript through an ajax endpoint.
Used to detect bugs in website javascript.';