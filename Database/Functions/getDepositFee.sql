DELIMITER $$

CREATE FUNCTION `getDepositFee`(id_ INT, type_ VARCHAR(4), currency_iso_ CHAR(3))
  RETURNS DECIMAL(8, 2)
BEGIN

    DECLARE fee_usd_ DECIMAL(8,2) DEFAULT 0; 
    DECLARE fee_euro_ DECIMAL(8,2) DEFAULT 0; 
    DECLARE fee_btc_ DECIMAL(8,2) DEFAULT 0; 
    DECLARE iret_ DECIMAL(8,2) DEFAULT 0; 
    

    IF (type_ = 'BTC') THEN
      
      SET fee_usd_= 0;
      SET fee_euro_ = 0;
      SET fee_btc_ = 0;
    
    END IF;

  IF (type_ = 'FIAT') THEN 
    
    SELECT  (ad.feeAmount * IF(c.id=1, 1, r.rate)) AS v_usd,  
            (ad.feeAmount * IF(c.id=1, 1, r.rate) / t.euro_usd_rate) AS v_euro, 0 AS v_btc INTO fee_usd_, fee_euro_, fee_usd_
    FROM    AdyenDeposits ad
            INNER JOIN Currencies_Currencies c ON c.ISO = currencyISO
            LEFT OUTER JOIN Currencies_RateHistory r ON c.id = r.currencyId               
            INNER JOIN (
              ( SELECT  r_euro.rate AS euro_usd_rate, FROM_UNIXTIME(r_euro.time, '%Y-%m-%d') AS date_ 
                FROM    Currencies_RateHistory r_euro WHERE r_euro.currencyId = 32)
            ) t ON t.date_ = FROM_UNIXTIME(ad.time, '%Y-%m-%d')
    WHERE   status=1 
            AND ad.id=id_
            AND  IF(c.id=1, 1,  FROM_UNIXTIME(ad.time, '%Y-%m-%d') = FROM_UNIXTIME(r.time, '%Y-%m-%d'));

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