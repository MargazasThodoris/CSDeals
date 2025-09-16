DELIMITER $$

CREATE FUNCTION `isUserActive`(user_id int, days int)
  RETURNS INT(11)
BEGIN

  DECLARE iret int DEFAULT 0;

  DECLARE start_date int;
  DECLARE end_date int;
  DECLARE creation_date int;


  SET end_date = UNIX_TIMESTAMP() - (UNIX_TIMESTAMP() % 86400);
  SET start_date = end_date - (days * 86400);
  SET creation_date = start_date;


  SELECT
    IFNULL(u.id, 0) INTO iret
  FROM users u
    LEFT JOIN Adyen_BalanceAccounts aba_eur
      ON aba_eur.id = u.adyenIndividualBalanceAccountEurLocalId
    LEFT JOIN Adyen_BalanceAccounts aba_usd
      ON aba_usd.id = u.adyenIndividualBalanceAccountUsdLocalId
  WHERE u.id NOT IN (SELECT
      userid AS userID
    FROM userSales_CompletedSales AS t
    WHERE t.time >= start_date
    AND t.time < end_date
    UNION
    SELECT
      t.buyerUserId AS userID
    FROM userSales_CompletedSales AS t
    WHERE t.time >= start_date
    AND t.time < end_date
    UNION
    SELECT
      t.userId AS userID
    FROM AdyenDeposits t
    WHERE t.time >= start_date
    AND t.time < end_date
    UNION
    SELECT
      t.userId AS userID
    FROM AdyenPayouts t
    WHERE t.time >= start_date
    AND t.time < end_date
    UNION
    SELECT
      t.userId AS userID
    FROM Crypto_BTC_Sends_New t
    WHERE t.time >= start_date
    AND t.time < end_date
    UNION
    SELECT
      u.id AS userID
    FROM tblSkinsBackOrder t
      INNER JOIN users u
        ON u.steamid = t.steam_id
    WHERE t.date >= start_date
    AND t.date < end_date
    AND t.status_id = 1)
  AND u.timeadded < creation_date
  AND (u.balanceStableCryptoUSD > 0
  OR u.balanceAdyenIndividualAvailableUsd > 0
  OR u.balanceAdyenIndividualAvailableEur > 0
  OR u.USDBalance > 0)
  AND u.id = user_id;

  RETURN (iret);

END
$$

DELIMITER ;