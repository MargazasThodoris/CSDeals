CREATE TABLE `p2p_trades_BalanceTransactions_StableCrypto` (
  `p2p_trade_id` INT(11) UNSIGNED NOT NULL,
  `balance_transaction_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (p2p_trade_id, balance_transaction_id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

ALTER TABLE `p2p_trades_BalanceTransactions_StableCrypto` 
  ADD CONSTRAINT `FK_balance_transaction` FOREIGN KEY (balance_transaction_id)
    REFERENCES Users_BalanceTransactions_StableCrypto(id) ON DELETE CASCADE;

ALTER TABLE `p2p_trades_BalanceTransactions_StableCrypto` 
  ADD CONSTRAINT `FK_p2p_trade` FOREIGN KEY (p2p_trade_id)
    REFERENCES p2p_trades(id) ON DELETE CASCADE;