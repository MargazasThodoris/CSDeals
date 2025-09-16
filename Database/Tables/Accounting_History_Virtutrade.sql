CREATE TABLE `Accounting_History_Virtutrade` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` TINYINT(255) UNSIGNED NOT NULL COMMENT '0=Manually marked, 1=User sale fee profit, 2=User sale extra paid by buyer profit, 3=btc withdrawal fee, 4=bitcoin transaction fee',
  `currency` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'config/Currencies.php ; 0=real money, 1=tradebot balance, 2=bitcoin, 3=euro, 10=USDT, 11=BUSD, 12=ETHEREUM, 100=TSF_TRADE_BOT, 1000+id where id is id in table Currencies',
  `time` INT(10) UNSIGNED NOT NULL,
  `amount` DECIMAL(16, 8) NOT NULL,
  `isInformative` TINYINT(255) NOT NULL DEFAULT 0 COMMENT 'if 1, this data is only additional information and shouldn''t be counted in calculations. For example for user sales, we will mark the deduction from the buyer as profit and then the payment to the seller as a deduction and the difference will be the profit. We will also mark the profit from fees and extra paid as informative data, even though they are already included in the previous logs.',
  `bitcoinPrice` DECIMAL(11, 4) DEFAULT NULL,
  `currencyRate` DECIMAL(11, 4) DEFAULT NULL COMMENT 'how much 1 of these is worth in usd (for btc and eur)',
  `userSaleId` INT(10) UNSIGNED DEFAULT NULL COMMENT '->userSales_ListedItemsHistory.id',
  `onSiteTradeId` INT(255) UNSIGNED NOT NULL COMMENT '->onSiteTrades_Trades.id',
  `cashoutId` INT(255) UNSIGNED DEFAULT NULL COMMENT '->Users_CashoutRequests.id',
  `BTCIncomingTxId` INT(10) UNSIGNED DEFAULT NULL,
  `BTCInvoiceId` INT(10) UNSIGNED DEFAULT NULL,
  `BTCSentTxId` INT(255) UNSIGNED DEFAULT NULL,
  `bitmexRealisationId` INT(255) DEFAULT NULL,
  `balanceMarketOrderId` INT(255) DEFAULT NULL COMMENT 'Balance market is obsolete',
  `moneyDepositOrderId` INT(255) UNSIGNED DEFAULT NULL COMMENT '->MoneyPayments_Orders.id',
  `commonId` INT(255) DEFAULT NULL COMMENT 'id used for those that don''t have their own column. Used so we don''t have to add columns each time',
  `description` VARCHAR(1024) BINARY CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'Additional description to the transaction',
  `uniqueIndex` VARCHAR(128) BINARY CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'Used to prevent multiple entries when importing data',
  PRIMARY KEY (id, type, currency)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs of all transactions of the company''s funds, be that any currency or Bitcoin.  Whenever the company receives or loses funds, it is logged here.';

ALTER TABLE `Accounting_History_Virtutrade` 
  ADD UNIQUE INDEX uniqueIndex(uniqueIndex, type);

ALTER TABLE `Accounting_History_Virtutrade` 
  ADD INDEX time(time);

ALTER TABLE `Accounting_History_Virtutrade` 
  ADD INDEX currency(currency);

ALTER TABLE `Accounting_History_Virtutrade` 
  ADD INDEX description(description) COMMENT 'Used so we can prevent duplicate entries for Kraken';

ALTER TABLE `Accounting_History_Virtutrade` 
  ADD INDEX cashoutId(cashoutId);

ALTER TABLE `Accounting_History_Virtutrade` 
  ADD INDEX BTCSentTxId(BTCSentTxId);

ALTER TABLE `Accounting_History_Virtutrade` 
  ADD INDEX type(type, time);

ALTER TABLE `Accounting_History_Virtutrade` 
  ADD CONSTRAINT `accountingHistoryType` FOREIGN KEY (type)
    REFERENCES Accounting_Types_Virtutrade(id) ON DELETE NO ACTION ON UPDATE NO ACTION;