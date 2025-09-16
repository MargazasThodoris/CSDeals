DELIMITER $$

CREATE TRIGGER `triggerCalculateFee`
	BEFORE INSERT
	ON external_transaction_cashout
	FOR EACH ROW
BEGIN

  SET NEW.usd_amount_fee = calculateCashoutFee(NEW.usd_amount, NEW.currency);

END
$$

DELIMITER ;