CREATE TABLE `tblSkinsBackOrder` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `csdeals_order_id` CHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `steam_id` BIGINT(20) NOT NULL,
  `submission_time` INT(11) NOT NULL DEFAULT unix_timestamp(),
  `sign` VARCHAR(255) NOT NULL,
  `transaction_id` BIGINT(20) DEFAULT NULL,
  `date` INT(11) DEFAULT NULL,
  `amount` DECIMAL(8, 2) DEFAULT NULL,
  `amount_currency` VARCHAR(255) DEFAULT NULL,
  `amount_in_currencies` LONGTEXT BINARY CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`amount_in_currencies`)),
  `user_amount` DECIMAL(8, 2) DEFAULT NULL,
  `user_amount_in_currencies` LONGTEXT BINARY CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`user_amount_in_currencies`)),
  `offer_date` INT(11) DEFAULT NULL,
  `skins_send_date` INT(11) DEFAULT NULL,
  `status_id` INT(11) UNSIGNED DEFAULT NULL,
  `contents_creation` LONGTEXT DEFAULT NULL,
  `contents_callback` LONGTEXT DEFAULT NULL,
  `user_currency` VARCHAR(255) DEFAULT NULL,
  `btc_value` DECIMAL(8, 2) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `tblSkinsBackOrder` 
  ADD UNIQUE INDEX transaction_id(transaction_id);

ALTER TABLE `tblSkinsBackOrder` 
  ADD CONSTRAINT `FK_tblSkinsBackOrder_status_id` FOREIGN KEY (status_id)
    REFERENCES tblSkinsBackStatus(id) ON DELETE NO ACTION;