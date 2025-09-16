DELIMITER $$

CREATE PROCEDURE `spUpDateReconciliationOverview`(IN days_before int)
BEGIN

  DECLARE cashout_bitcoin_fee_percentage DECIMAL(10,4);
  DECLARE cashout_bitcoin_fee_static DECIMAL(9,8);
  DECLARE cashout_fiat_fee_percentage DECIMAL(10,4);
  DECLARE cashout_fiat_fee_static DECIMAL(10,4);
  
  DECLARE deposit_bitcoin_fee_percentage DECIMAL(10,4) DEFAULT 0;
  DECLARE deposit_bitcoin_fee_static DECIMAL(10,4) DEFAULT 0;
  DECLARE deposit_fiat_fee_percentage DECIMAL(10,4) DEFAULT 0;
  DECLARE deposit_fiat_fee_static DECIMAL(10,4) DEFAULT 0;




  SELECT  p.withdrawalBitcoinFeePercent,
          p.withdrawalBitcoinFeeBTC,
          p.withdrawalAdyenBanktransferFeePercent,
          p.withdrawalAdyenBanktransferFeeStaticEUR
          INTO 
          cashout_bitcoin_fee_percentage,
          cashout_bitcoin_fee_static,
          cashout_fiat_fee_percentage,
          cashout_fiat_fee_static
  FROM    preferences p
  WHERE   p.id=1;



SET @date_time = DATE_FORMAT(DATE_SUB(CURRENT_TIMESTAMP(), INTERVAL days_before DAY), '%Y-%m-%d') ;

INSERT INTO tblOverview 
(
  date_time
 ,balance_users_account_virtutrade
 ,balance_users_account_crypto_usd
 ,balance_users_account_crypto_opening_usd
 ,balance_users_account_crypto_closing_usd
 ,balance_users_account_eur
 ,balance_users_account_usd
 ,balance_users_account_tokens
 ,company_btc_wallet
 ,company_btc_wallet_usd 
 ,users_transactions_usd
 ,btc_deposits_usd
 ,btc_cashouts_usd
 ,fiat_deposits_usd
 ,fiat_cashouts_usd
 ,sales_usd
 ,sales_instant_usd
 ,sales_p2p_usd
 ,inventory_value_usd
 ,profit_sales_usd
 ,profit_sales_instant_usd
 ,profit_sales_p2p_usd
 ,profit_deposit_btc_usd
 ,profit_deposit_fiat_usd
 ,profit_cashout_btc_usd
 ,profit_cashout_fiat_usd 
) 
SELECT 
      UB.DateTime AS date_time,
      CAST(UB.balance_users_account_virtual_trip AS DECIMAL(14,4)) AS balance_users_account_virtutrade,     
      UB.balance_users_account_crypto_usd AS balance_users_account_crypto_usd,
      UB.balance_users_account_crypto_opening_usd AS balance_users_account_crypto_opening_usd,          
      UB.balance_users_account_crypto_closing_usd AS balance_users_account_crypto_closing_usd,          
      UB.balance_users_account_eur AS balance_users_account_eur,
      UB.balance_users_account_usd AS balance_users_account_usd,
      UB.balance_users_account_tokens AS balance_users_account_tokens,
      UB.company_btc_wallet AS company_btc_wallet,
      CAST(UB.company_btc_wallet * getCurrentBitcoinPrice() AS DECIMAL(14,4)) AS company_btc_wallet_usd,
      CAST(CryptoUSD.V AS DECIMAL(14,4)) AS users_transactions_usd,
      CAST(BTCDeposits.V AS DECIMAL(14,4)) AS btc_deposits_usd,      
      CAST(BTCCashouts.V AS DECIMAL(14,4)) AS btc_cashouts_usd, 
      CAST(FiatDeposits.V AS DECIMAL(14,4)) AS fiat_deposits_usd,
      CAST(FiatCashouts.V AS DECIMAL(14,4)) AS fiat_cashouts_usd, 
      S.V sales_usd,
      INS.V AS sales_instant_usd,
      P2PSales.V AS sales_p2p_usd,
      UB.inventory_value_usd AS inventory_value_usd,
      S.P AS profit_sales_usd,
      INS.P AS profit_sales_instant_usd,
      P2PSales.P AS profit_sales_p2p_usd,
      CAST(BTCDeposits.P AS DECIMAL(14,4)) AS profit_deposit_btc_usd,
      CAST(FiatDeposits.P AS DECIMAL(14,4)) AS profit_deposit_fiat_usd,
      CAST(BTCCashouts.P AS DECIMAL(14,4)) AS profit_cashout_btc_usd,
      CAST(FiatCashouts.P AS DECIMAL(14,4)) AS profit_cashout_fiat_usd            
FROM   
        (SELECT   @date_time AS DateTime,
            getCurrentBitcoinPrice() AS BitCoinPrice,  
            SUM(USDBalance) AS balance_users_account_virtual_trip, 
            SUM(balanceBTC) AS user_btc_Balance, 
            SUM(balanceStableCryptoUSD) AS balance_users_account_crypto_usd , 
            SUM(balanceAdyenIndividualAvailableEur) AS balance_users_account_eur, 
            SUM(balanceAdyenIndividualAvailableUsd) AS balance_users_account_usd, 
            CAST(SUM(balance) AS decimal(14,4)) AS balance_users_account_tokens,
            CAST(getCompanyBitcoins() AS decimal(14,8)) AS company_btc_wallet,
            getUserInventoryValue(NULL) AS inventory_value_usd,
            CAST(SUM(getUserClosingBalanceCryptoUSD(id, DATE_FORMAT(DATE_SUB(CURRENT_TIMESTAMP(), INTERVAL days_before+1 DAY), '%Y-%m-%d'))) AS DECIMAL(14,4)) AS balance_users_account_crypto_opening_usd,            
            IF(days_before = 0, 0, CAST(SUM(getUserClosingBalanceCryptoUSD(id, DATE_FORMAT(DATE_SUB(CURRENT_TIMESTAMP(), INTERVAL days_before DAY), '%Y-%m-%d'))) AS DECIMAL(14,4)))  AS balance_users_account_crypto_closing_usd            
      FROM users) AS UB
      LEFT JOIN
        (
          SELECT FROM_UNIXTIME(t.time, '%Y-%m-%d') AS D, SUM(t.amountUSD) AS V 
          FROM Users_BalanceTransactions_StableCrypto t
          WHERE FROM_UNIXTIME(t.time, '%Y-%m-%d') = @date_time          
        ) AS CryptoUSD ON CryptoUSD.D = UB.Datetime
   LEFT JOIN (
    SELECT  FROM_UNIXTIME(time, '%Y-%m-%d') AS D, 
            SUM(t.bitcoinAmount*t.bitcoinPrice) AS V, 
            SUM((cashout_bitcoin_fee_static * t.bitcoinPrice)) + SUM((cashout_bitcoin_fee_percentage * (t.bitcoinAmount*t.bitcoinPrice))) AS P
    FROM Crypto_BTC_Sends_New t
    WHERE FROM_UNIXTIME(t.time, '%Y-%m-%d') = @date_time          
    ) AS BTCCashouts ON BTCCashouts.D = UB.DateTime
  LEFT  JOIN (
    SELECT  FROM_UNIXTIME(time, '%Y-%m-%d') AS D , 
            SUM(t.bitcoinAmount*t.bitcoinPrice) AS V, 
            0 AS P
    FROM Crypto_BTC_IncomingTransactions_New t
    WHERE FROM_UNIXTIME(t.time, '%Y-%m-%d') = @date_time          
    ) AS BTCDeposits ON UB.DateTime = BTCDeposits.D  
  LEFT JOIN (
    SELECT  FROM_UNIXTIME( s.time , '%Y-%m-%d') AS DateTime, 
            ROUND(SUM(IF(isBitcoinSale=1,1,0) * salePrice*amount),2) AS V,
            ROUND(SUM( s.salePrice * s.amount * l.fee ),2) AS P
    FROM    userSales_CompletedSales s
            INNER JOIN userSales_ListedItemsHistory l ON l.id = s.userSaleId
    WHERE   FROM_UNIXTIME( s.time , '%Y-%m-%d') = @date_time                        
  ) AS S ON S.DateTime = UB.DateTime
 LEFT JOIN (
    SELECT  FROM_UNIXTIME(sbo.date, '%Y-%m-%d') AS D,
            SUM(IF(sbo.amount_currency='eur', user_amount/(1/getCurrentCurrencyRate('EUR')), user_amount)) AS V,
            SUM(IF(sbo.amount_currency='eur', (amount-user_amount)/(1/getCurrentCurrencyRate('EUR')), (amount-user_amount))) AS P
    FROM    tblSkinsBackOrder sbo
    WHERE sbo.status_id=1      
          AND FROM_UNIXTIME(sbo.date, '%Y-%m-%d') = @date_time              
  ) AS INS ON INS.D = UB.DateTime
  LEFT JOIN (
    SELECT  DATE_FORMAT(pt.time_added, '%Y-%m-%d') AS DateTime, 
            CAST(SUM(pt.amount_usd) AS DECIMAL(14,4)) AS V, 
            CAST(SUM(pt.fee_amount_usd) AS decimal (14,4)) AS P        
    FROM    p2p_trades pt    
    WHERE   pt.p2p_status_id=2
    GROUP BY DATE_FORMAT(pt.time_added, '%Y-%m-%d')
  ) AS P2PSales ON P2PSales.DateTime = UB.DateTime
  LEFT JOIN (
      SELECT  DATE_FORMAT(et.time, '%Y-%m-%d') AS D, 
              SUM(et.usd_amount) AS V,
              SUM(et.usd_amount_plus_fees - et.usd_amount) AS P
      FROM    external_transaction et
              INNER JOIN external_status es ON et.status_id = es.id
              INNER JOIN external_transaction_type ett ON et.type_id = ett.id
      WHERE   et.status_id = 4
              AND ett.id = 1         
              AND DATE_FORMAT(et.time, '%Y-%m-%d') = @date_time                    
   ) AS FiatDeposits ON UB.DateTime = FiatDeposits.D
    LEFT JOIN (
      SELECT  DATE_FORMAT(et.time, '%Y-%m-%d') AS D, 
              SUM(et.usd_amount) AS V,
              0 AS P
      FROM    external_transaction et
              INNER JOIN external_status es ON et.status_id = es.id
              INNER JOIN external_transaction_type ett ON et.type_id = ett.id
      WHERE   et.status_id = 4
              AND ett.id = 2         
              AND DATE_FORMAT(et.time, '%Y-%m-%d') = @date_time                    
    ) AS FiatCashouts ON UB.DateTime = FiatCashouts.D

  ON DUPLICATE KEY UPDATE 
      balance_users_account_virtutrade = VALUES(balance_users_account_virtutrade),
      balance_users_account_crypto_usd = VALUES(balance_users_account_crypto_usd),
      balance_users_account_crypto_opening_usd = VALUES (balance_users_account_crypto_opening_usd),
      balance_users_account_crypto_closing_usd = VALUES (balance_users_account_crypto_closing_usd),
      balance_users_account_eur = VALUES(balance_users_account_eur),
      balance_users_account_usd = VALUES (balance_users_account_usd),
      balance_users_account_tokens = VALUES (balance_users_account_tokens),
      company_btc_wallet = VALUES(company_btc_wallet),
      users_transactions_usd = VALUES(users_transactions_usd),
      btc_deposits_usd = VALUES(btc_deposits_usd),
      btc_cashouts_usd = VALUES(btc_cashouts_usd),
      fiat_deposits_usd = VALUES(fiat_deposits_usd),
      fiat_cashouts_usd = VALUES(fiat_cashouts_usd),
      sales_usd = VALUES(sales_usd),
      sales_instant_usd = VALUES(sales_instant_usd),
      sales_p2p_usd = VALUES(sales_p2p_usd),
      inventory_value_usd = VALUES (inventory_value_usd),
      profit_sales_usd = VALUES (profit_sales_usd),
      profit_sales_instant_usd = VALUES (profit_sales_instant_usd),
      profit_sales_p2p_usd = VALUES (profit_sales_p2p_usd),
      profit_deposit_btc_usd = VALUES (profit_deposit_btc_usd),
      profit_deposit_fiat_usd = VALUES (profit_deposit_fiat_usd),
      profit_cashout_btc_usd = VALUES (profit_cashout_btc_usd),
      profit_cashout_fiat_usd = VALUES (profit_cashout_fiat_usd)
      ;


IF (days_before = 0) THEN

  INSERT INTO tblOverview 
  (
    date_time
   ,balance_users_account_crypto_closing_usd
  ) 
  SELECT  DATE_FORMAT(DATE_SUB(CURRENT_TIMESTAMP(), INTERVAL days_before+1 DAY), '%Y-%m-%d'), 
          CAST(SUM(getUserClosingBalanceCryptoUSD(u.id, DATE_FORMAT(DATE_SUB(CURRENT_TIMESTAMP(), INTERVAL days_before+1 DAY), '%Y-%m-%d'))) AS DECIMAL(14,4))
  FROM  users u 
         
    ON DUPLICATE KEY UPDATE 
        balance_users_account_crypto_closing_usd = VALUES (balance_users_account_crypto_closing_usd);
END IF;
            
END
$$

DELIMITER ;