DELIMITER $$

CREATE FUNCTION `getCashoutFee`(id_ INT, type_ VARCHAR(4), currency_iso_ CHAR(3))
  RETURNS DECIMAL(8, 2)
BEGIN

    DECLARE fee_usd_ DECIMAL(8,2) DEFAULT 0; 
    DECLARE fee_euro_ DECIMAL(8,2) DEFAULT 0; 
    DECLARE fee_btc_ DECIMAL(8,2) DEFAULT 0; 
    DECLARE iret_ DECIMAL(8,2) DEFAULT 0; 
    

    IF (type_ = 'BTC') THEN

      
      SELECT t.amount, t.amount*t.currencyRate, t.amount*t.currencyRateEUR INTO fee_btc_, fee_usd_, fee_euro_
      FROM  Crypto_BTC_Sends_New s 
            INNER JOIN Accounting_History_New t ON s.id = t.commonId
      WHERE  t.type = 120 
             AND t.commonId=id_;            
 
    END IF;

    IF (type_ = 'FIAT') THEN
  
      SELECT  0 AS v_btc, (p.payoutFeeAmount * IF(c.id=1, 1, r.rate)) AS v_usd,  
              (p.payoutFeeAmount * IF(c.id=1, 1, r.rate) / t.euro_usd_rate) AS v_euro INTO fee_btc_, fee_usd_, fee_euro_
      FROM    AdyenPayouts p
              INNER JOIN Currencies_Currencies c ON c.ISO = p.sourceCurrencyISO
              LEFT OUTER JOIN Currencies_RateHistory r ON c.id = r.currencyId               
              INNER JOIN (
                ( SELECT  r_euro.rate AS euro_usd_rate, FROM_UNIXTIME(r_euro.time, '%Y-%m-%d') AS date_ 
                  FROM    Currencies_RateHistory r_euro WHERE r_euro.currencyId = 32)
              ) t ON t.date_ = FROM_UNIXTIME(p.time, '%Y-%m-%d')
      WHERE   status=1 
              AND p.id=id_
              AND  IF(c.id=1, 1,  FROM_UNIXTIME(p.time, '%Y-%m-%d') = FROM_UNIXTIME(r.time, '%Y-%m-%d'));
  
      
    END IF;

  
    SELECT 
      CASE currency_iso_
        WHEN 'USD' THEN fee_usd_
        WHEN 'EUR' THEN fee_euro_
        WHEN 'BTC' THEN fee_btc_
        ELSE 0
      END AS fee INTO iret_;
  
      RETURN (iret_);

END
$$

DELIMITER ;