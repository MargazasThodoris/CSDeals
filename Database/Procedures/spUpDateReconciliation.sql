DELIMITER $$

CREATE PROCEDURE `spUpDateReconciliation`(IN days_before int)
BEGIN


SET @date_time = DATE_FORMAT(DATE_SUB(CURRENT_TIMESTAMP(), INTERVAL days_before DAY), '%Y-%m-%d') ;

INSERT INTO tblReconciliation
(
    date_time,    
    users_account_virtutrade_usd,
    users_account_usd,
    users_account_banned_usd,
    users_account_inactive_usd,
    users_account_net_usd,
    users_account_tokens,
    company_btc_wallet_usd,  
    company_inventory_usd,
    users_inventory_usd,
    users_inventory_banned_usd,
    users_inventory_inactive_usd
)
SELECT  @date_time,
        SUM(u.USDBalance) AS users_account_virtutrade_usd,
        SUM(u.balanceStableCryptoUSD) + SUM(u.balanceAdyenIndividualAvailableUsd) +  (1/getCurrentCurrencyRate('EUR')) * SUM(u.balanceAdyenIndividualAvailableUsd) AS users_account_usd,        
        SUM(IF(isUserBanned(id) > 0, u.balanceStableCryptoUSD + u.balanceAdyenIndividualAvailableUsd +  (1/getCurrentCurrencyRate('EUR')) * u.balanceAdyenIndividualAvailableEur, 0))  AS users_banned_balance_usd,
        SUM(IF(isUserActive(id, 365) = 0, 0, u.balanceStableCryptoUSD + u.balanceAdyenIndividualAvailableUsd +  (1/getCurrentCurrencyRate('EUR')) * u.balanceAdyenIndividualAvailableEur))  AS users_inactive_balance_usd,
        SUM(u.balanceStableCryptoUSD) + SUM(u.balanceAdyenIndividualAvailableUsd) +  (1/getCurrentCurrencyRate('EUR')) * SUM(u.balanceAdyenIndividualAvailableUsd) - (SUM(IF(isUserActive(id, 365) = 0 OR isUserBanned(id) > 0, 0, u.balanceStableCryptoUSD + u.balanceAdyenIndividualAvailableUsd +  (1/getCurrentCurrencyRate('EUR')) * u.balanceAdyenIndividualAvailableEur))) AS users_account_net_usd,
        SUM(u.balance) AS users_account_tokens,
        CAST(getCompanyBitcoins() * getCurrentBitcoinPrice() AS decimal(14,4)) AS company_btc_wallet_usd,
        getCompanyInventoryValue() AS company_inventory_usd,
        getUserInventoryValue(NULL) AS users_inventory_usd,
        getUserInventoryValueBanned() AS users_inventory_banned_usd,                  
        getUserInventoryValueInactive(180) AS users_inventory_inactive_usd
FROM users u 

ON DUPLICATE KEY UPDATE   
    users_account_virtutrade_usd = VALUES(users_account_virtutrade_usd),    
    users_account_usd = VALUES(users_account_usd),
    users_account_banned_usd = VALUES(users_account_banned_usd),
    users_account_inactive_usd = VALUES(users_account_inactive_usd),
    users_account_net_usd = VALUES(users_account_net_usd),
    users_account_tokens = VALUES(users_account_tokens),
    company_btc_wallet_usd = VALUES(company_btc_wallet_usd),
    company_inventory_usd = VALUES(company_inventory_usd),
    users_inventory_usd = VALUES(users_inventory_usd),
    users_inventory_banned_usd = VALUES(users_inventory_banned_usd),
    users_inventory_inactive_usd = VALUES(users_inventory_inactive_usd);
         
END
$$

DELIMITER ;