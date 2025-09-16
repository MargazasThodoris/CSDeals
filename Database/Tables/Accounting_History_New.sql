CREATE TABLE `Accounting_History_New` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` TINYINT(255) UNSIGNED NOT NULL COMMENT '0=Manually marked, 1=User sale fee profit, 2=User sale extra paid by buyer profit, 3=btc withdrawal fee, 4=bitcoin transaction fee',
  `currency` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'config/Currencies.php ; 0=real money, 1=tradebot balance, 2=bitcoin, 3=euro, 10=USDT, 11=BUSD, 12=ETHEREUM, 100=TSF_TRADE_BOT, 1000+id where id is id in table Currencies',
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'UNIX timestamp',
  `amount` DECIMAL(16, 8) NOT NULL COMMENT 'The value of the transaction. Negative or positive.',
  `isInformative` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'if 1, this data is only additional information and shouldn''t be counted in calculations. For example for user sales, we will mark the deduction from the buyer as profit and then the payment to the seller as a deduction and the difference will be the profit. We will also mark the profit from fees and extra paid as informative data, even though they are already included in the previous logs.',
  `bitcoinPrice` DECIMAL(11, 4) DEFAULT NULL COMMENT 'BTC/USD at the time of the transaction',
  `currencyRate` DECIMAL(11, 4) DEFAULT NULL COMMENT 'If currency = 1 or 3 (USD or EUR), this is USD/EUR rate. If currency=2 (BTC), this is BTC/USD',
  `currencyRateEUR` DECIMAL(11, 4) DEFAULT NULL COMMENT 'Used for BTC and USD. This is BTC/EUR or USD/EUR',
  `userSaleId` INT(10) UNSIGNED DEFAULT NULL COMMENT '->userSales_ListedItemsHistory.id',
  `onSiteTradeId` INT(255) UNSIGNED DEFAULT NULL COMMENT '->onSiteTrades_Trades.id',
  `BTCIncomingTxId` INT(10) UNSIGNED DEFAULT NULL COMMENT '->Crypto_BTC_IncomingTransactions_New.id',
  `BTCSentTxId` INT(255) UNSIGNED DEFAULT NULL COMMENT '->Crypto_BTC_Sends_New.id',
  `bitmexRealisationId` INT(255) UNSIGNED DEFAULT NULL COMMENT '->Crypto_BTC_Bitmex_Realisations.id',
  `commonId` INT(255) DEFAULT NULL COMMENT 'id used for those that don''t have their own column. Used so we don''t need to have columns for each different type of accounting entry.
Includes, but not limited to:
->AdyenDeposits.id
->userbalancetransactions.id',
  `description` VARCHAR(1024) BINARY CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'Additional description to the transaction',
  `uniqueIndex` VARCHAR(128) BINARY CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'Used to prevent multiple entries when importing data',
  PRIMARY KEY (id, type, currency),
  INDEX id(id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs of all transactions of the company''s funds, be that any currency or Bitcoin.  For each transaction where the company receives or loses funds, it is logged here.';

ALTER TABLE `Accounting_History_New` 
  ADD UNIQUE INDEX uniqueIndex(uniqueIndex, type);

ALTER TABLE `Accounting_History_New` 
  ADD INDEX time(time);

ALTER TABLE `Accounting_History_New` 
  ADD INDEX currency(currency);

ALTER TABLE `Accounting_History_New` 
  ADD INDEX description(description) COMMENT 'Used so we can prevent duplicate entries for Kraken';

ALTER TABLE `Accounting_History_New` 
  ADD INDEX type(type, time);

ALTER TABLE `Accounting_History_New` 
  ADD CONSTRAINT `Accounting_History_BTCIncomingTxId` FOREIGN KEY (BTCIncomingTxId)
    REFERENCES Crypto_BTC_IncomingTransactions_New(id);

ALTER TABLE `Accounting_History_New` 
  ADD CONSTRAINT `Accounting_History_BTCSentTxId` FOREIGN KEY (BTCSentTxId)
    REFERENCES Crypto_BTC_Sends_New(id);

ALTER TABLE `Accounting_History_New` 
  ADD CONSTRAINT `Accounting_History_New_ibfk_1` FOREIGN KEY (type)
    REFERENCES Accounting_Types(id);

ALTER TABLE `Accounting_History_New` 
  ADD CONSTRAINT `Accounting_History_bitmexRealisationId` FOREIGN KEY (bitmexRealisationId)
    REFERENCES Crypto_BTC_Bitmex_Realisations(id);

ALTER TABLE `Accounting_History_New` 
  ADD CONSTRAINT `Accounting_History_onSiteTradeId` FOREIGN KEY (onSiteTradeId)
    REFERENCES onSiteTrades_Trades(id);

ALTER TABLE `Accounting_History_New` 
  ADD CONSTRAINT `Accounting_History_userSaleId` FOREIGN KEY (userSaleId)
    REFERENCES userSales_ListedItemsHistory(id);