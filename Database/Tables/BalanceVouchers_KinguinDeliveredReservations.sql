CREATE TABLE `BalanceVouchers_KinguinDeliveredReservations` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `codeValue` DECIMAL(6, 2) NOT NULL,
  `createDate` INT(255) UNSIGNED NOT NULL,
  `reservationId` CHAR(36) NOT NULL,
  `orderIncrementId` VARCHAR(255) NOT NULL,
  `rawRowJSON` TEXT DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci,
COMMENT = 'OBSOLETE. Uses old balance system, which was replaced by Adyen and BTC/Stable crypto balance.

This table is populated from the Reservations export from Kinguin. It is used to determine how many purchased Kinguin codes were unused at any given time by knowing how many codes have been sold.
We need to log rows with status REVERSED and DELIVERED';

ALTER TABLE `BalanceVouchers_KinguinDeliveredReservations` 
  ADD UNIQUE INDEX uniq(reservationId);