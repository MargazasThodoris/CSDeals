DELIMITER $$

CREATE FUNCTION `getUserClosingBalanceCryptoUSD`(user_id_ int, date_ varchar(10))
  RETURNS DECIMAL(10, 2)
BEGIN


  DECLARE iret_ decimal(8, 2) DEFAULT 0;


  SELECT
    t.balanceafter INTO iret_
  FROM Users_BalanceTransactions_StableCrypto t
  WHERE t.userid = user_id_
  AND FROM_UNIXTIME(t.time, '%Y-%m-%d') <= STR_TO_DATE(date_, '%Y-%m-%d')
  ORDER BY t.time DESC
  LIMIT 1;


  RETURN (iret_);
END
$$

DELIMITER ;