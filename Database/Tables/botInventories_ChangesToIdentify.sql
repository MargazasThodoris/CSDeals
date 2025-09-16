CREATE TABLE `botInventories_ChangesToIdentify` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `botInventoryHistoryId` BIGINT(20) UNSIGNED NOT NULL COMMENT '->botInventories_ItemHistory.id',
  `botid` INT(255) UNSIGNED NOT NULL DEFAULT 0 COMMENT '->bots.id',
  `amountChanged` INT(255) NOT NULL COMMENT 'negative if items were given, positive if new items were acquired',
  `time` INT(10) UNSIGNED NOT NULL COMMENT 'UNIX timestamp of this entry',
  `unknownSourceCounter` SMALLINT(255) NOT NULL DEFAULT 0 COMMENT 'each time we check the trade history and can''t find this item in a trade, increase this by 1. When this reaches 5, do not try to match it to a trade anymore and handle it manually',
  `timeIdentified` INT(10) UNSIGNED DEFAULT NULL,
  `tradeid` BIGINT(20) UNSIGNED DEFAULT NULL COMMENT 'the Steam tradeid where we received or gave these items. This will be null if not determined.

The API doesn''t give a tradeofferid',
  `steamid` BIGINT(20) UNSIGNED DEFAULT NULL,
  `newOrOldAssetId` BIGINT(20) DEFAULT NULL COMMENT 'if we receive the item, this will be old assetid, otherwise new assetid in the user''s inventory. In other words it will not be the same assetid as the botInventoryHistoryId has',
  `steamTradeId` BIGINT(20) UNSIGNED DEFAULT NULL COMMENT 'id in steamTrades_Trades if the trade is listed there',
  `onSiteHistoryId` BIGINT(20) UNSIGNED DEFAULT NULL COMMENT 'for new items, this is the new ID, for gone items, this will be null.
This field is for transfering the item from INVENTORY_ID_TRADE_TO_UNSET_INVENTORY_ID to the correct inventory if the change was identified before we had the local steam trade ID of the trade.',
  `unknownSourceIsHandled` TINYINT(255) DEFAULT NULL COMMENT 'set to 1 when the new unidentified item is moved to an onsite inventory',
  `isHandled` TINYINT(255) GENERATED ALWAYS AS (if(`timeIdentified` is not null or `unknownSourceIsHandled` <> 0,1,0)) STORED COMMENT 'Whether this removed or newly appeared item has been processed',
  PRIMARY KEY (id, botInventoryHistoryId, botid)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'When changes to an inventory are detected, every change is logged to this table. Changes are also applied to botInventories_ItemHistory immidiately.

We then load the completed trades through the API and match the missing and new items to the according Steam trades and write the corresponding tradeid in this table.

Then move the items to the correct inventory according to the logged Steam trade. The item is already removed from the correct onSiteInventory when the trade is accepted.

If the item was acquired or went missing but we can''t find a linking tradeoffer through the API, the unknownSource flag will be set and this will require manual review.'
PARTITION BY HASH (botid)
(
  PARTITION p0 ENGINE = INNODB,
  PARTITION p1 ENGINE = INNODB,
  PARTITION p10 ENGINE = INNODB,
  PARTITION p11 ENGINE = INNODB,
  PARTITION p12 ENGINE = INNODB,
  PARTITION p13 ENGINE = INNODB,
  PARTITION p14 ENGINE = INNODB,
  PARTITION p15 ENGINE = INNODB,
  PARTITION p16 ENGINE = INNODB,
  PARTITION p17 ENGINE = INNODB,
  PARTITION p18 ENGINE = INNODB,
  PARTITION p19 ENGINE = INNODB,
  PARTITION p2 ENGINE = INNODB,
  PARTITION p20 ENGINE = INNODB,
  PARTITION p21 ENGINE = INNODB,
  PARTITION p22 ENGINE = INNODB,
  PARTITION p23 ENGINE = INNODB,
  PARTITION p24 ENGINE = INNODB,
  PARTITION p25 ENGINE = INNODB,
  PARTITION p26 ENGINE = INNODB,
  PARTITION p27 ENGINE = INNODB,
  PARTITION p28 ENGINE = INNODB,
  PARTITION p29 ENGINE = INNODB,
  PARTITION p3 ENGINE = INNODB,
  PARTITION p30 ENGINE = INNODB,
  PARTITION p31 ENGINE = INNODB,
  PARTITION p32 ENGINE = INNODB,
  PARTITION p33 ENGINE = INNODB,
  PARTITION p34 ENGINE = INNODB,
  PARTITION p35 ENGINE = INNODB,
  PARTITION p36 ENGINE = INNODB,
  PARTITION p37 ENGINE = INNODB,
  PARTITION p38 ENGINE = INNODB,
  PARTITION p39 ENGINE = INNODB,
  PARTITION p4 ENGINE = INNODB,
  PARTITION p40 ENGINE = INNODB,
  PARTITION p41 ENGINE = INNODB,
  PARTITION p42 ENGINE = INNODB,
  PARTITION p43 ENGINE = INNODB,
  PARTITION p44 ENGINE = INNODB,
  PARTITION p45 ENGINE = INNODB,
  PARTITION p46 ENGINE = INNODB,
  PARTITION p47 ENGINE = INNODB,
  PARTITION p48 ENGINE = INNODB,
  PARTITION p49 ENGINE = INNODB,
  PARTITION p5 ENGINE = INNODB,
  PARTITION p50 ENGINE = INNODB,
  PARTITION p51 ENGINE = INNODB,
  PARTITION p52 ENGINE = INNODB,
  PARTITION p53 ENGINE = INNODB,
  PARTITION p54 ENGINE = INNODB,
  PARTITION p55 ENGINE = INNODB,
  PARTITION p56 ENGINE = INNODB,
  PARTITION p57 ENGINE = INNODB,
  PARTITION p58 ENGINE = INNODB,
  PARTITION p59 ENGINE = INNODB,
  PARTITION p6 ENGINE = INNODB,
  PARTITION p60 ENGINE = INNODB,
  PARTITION p61 ENGINE = INNODB,
  PARTITION p62 ENGINE = INNODB,
  PARTITION p63 ENGINE = INNODB,
  PARTITION p64 ENGINE = INNODB,
  PARTITION p65 ENGINE = INNODB,
  PARTITION p66 ENGINE = INNODB,
  PARTITION p67 ENGINE = INNODB,
  PARTITION p68 ENGINE = INNODB,
  PARTITION p69 ENGINE = INNODB,
  PARTITION p7 ENGINE = INNODB,
  PARTITION p70 ENGINE = INNODB,
  PARTITION p71 ENGINE = INNODB,
  PARTITION p72 ENGINE = INNODB,
  PARTITION p73 ENGINE = INNODB,
  PARTITION p74 ENGINE = INNODB,
  PARTITION p75 ENGINE = INNODB,
  PARTITION p76 ENGINE = INNODB,
  PARTITION p77 ENGINE = INNODB,
  PARTITION p78 ENGINE = INNODB,
  PARTITION p79 ENGINE = INNODB,
  PARTITION p8 ENGINE = INNODB,
  PARTITION p80 ENGINE = INNODB,
  PARTITION p81 ENGINE = INNODB,
  PARTITION p82 ENGINE = INNODB,
  PARTITION p83 ENGINE = INNODB,
  PARTITION p84 ENGINE = INNODB,
  PARTITION p85 ENGINE = INNODB,
  PARTITION p86 ENGINE = INNODB,
  PARTITION p87 ENGINE = INNODB,
  PARTITION p88 ENGINE = INNODB,
  PARTITION p89 ENGINE = INNODB,
  PARTITION p9 ENGINE = INNODB,
  PARTITION p90 ENGINE = INNODB,
  PARTITION p91 ENGINE = INNODB,
  PARTITION p92 ENGINE = INNODB,
  PARTITION p93 ENGINE = INNODB,
  PARTITION p94 ENGINE = INNODB,
  PARTITION p95 ENGINE = INNODB,
  PARTITION p96 ENGINE = INNODB,
  PARTITION p97 ENGINE = INNODB,
  PARTITION p98 ENGINE = INNODB,
  PARTITION p99 ENGINE = INNODB
);

ALTER TABLE `botInventories_ChangesToIdentify` 
  ADD UNIQUE INDEX UK_botInventories_ChangesToIdentify(botid, botInventoryHistoryId, tradeid);

ALTER TABLE `botInventories_ChangesToIdentify` 
  ADD INDEX steamTradeId(steamTradeId) COMMENT 'We need this in botInventoryMgr';

ALTER TABLE `botInventories_ChangesToIdentify` 
  ADD INDEX tradeid(tradeid) COMMENT 'We need this in identifyInventoryChangesByTradeData';

ALTER TABLE `botInventories_ChangesToIdentify` 
  ADD INDEX onSiteHistoryId_changes(onSiteHistoryId);

ALTER TABLE `botInventories_ChangesToIdentify` 
  ADD INDEX isHandled(isHandled, time);

ALTER TABLE `botInventories_ChangesToIdentify` 
  ADD INDEX botId(botid);