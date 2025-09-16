DELIMITER $$

CREATE PROCEDURE `spBalanceReconciliationUpdate`(IN info JSON)
  DETERMINISTIC
BEGIN

  DECLARE btc_deposits decimal(14,4) DEFAULT 0;
  DECLARE btc_withdraws decimal(14,4) DEFAULT 0;
  DECLARE time_ timestamp;

  SELECT CURRENT_TIMESTAMP() INTO time_;

  SELECT  SUM(bitcoinAmount*bitcoinPrice) INTO btc_deposits
  FROM    Crypto_BTC_IncomingTransactions_New  it
          INNER JOIN Crypto_BTC_WalletAddresses_New w
            ON w.id = it.addressId AND w.userId
  WHERE   it.time BETWEEN UNIX_TIMESTAMP()-86400 AND UNIX_TIMESTAMP();

  SELECT  SUM(bitcoinAmount*bitcoinPrice) INTO btc_withdraws
  FROM    Crypto_BTC_Sends_New a
  WHERE   time BETWEEN UNIX_TIMESTAMP()- 86400 AND UNIX_TIMESTAMP();

  INSERT INTO tblBalanceReconciliation (time,
                                        data, 
                                        bitcoin_price, 
                                        usd_amount_old_users, 
                                        bitcoin_amount_users, 
                                        bitcoin_amount_usd_users, 
                                        euro_amount_adyen_company, 
                                        usd_amount_adyen_company, 
                                        token_amount_users, 
                                        bitcoin_amount_company,
                                        bitcoin_amount_usd_company,
                                        bitcoin_deposits_usd_users,
                                        bitcoin_withdraws_usd_users)
 
  SELECT  time_,
          info, 
          getCurrentBitcoinPrice(),
          SUM(USDBalance),
          SUM(balanceBTC), 
          SUM(balanceStableCryptoUSD), 
          SUM(balanceAdyenIndividualAvailableEur), 
          SUM(balanceAdyenIndividualAvailableUsd),
          CAST(SUM(balance) AS decimal(10,2)),
          CAST(getCompanyBitcoins() AS decimal(12,2)),
          CAST(((getCompanyBitcoins() - SUM(balanceBTC)) * getCurrentBitcoinPrice()) AS decimal(14,4)),
          btc_deposits,
          btc_withdraws
FROM users;

END
$$

DELIMITER ;