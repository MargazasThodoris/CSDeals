CREATE TABLE `tradeBot_ItemReviewTimeTriggered` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `reviewTimeId` BIGINT(20) UNSIGNED NOT NULL COMMENT '->tradeBot_ItemReviewTimes.id',
  `userId` INT(11) NOT NULL COMMENT '->users.id; User who triggered it',
  `time` INT(11) NOT NULL DEFAULT 0 COMMENT 'UNIX timestamp of when this entry',
  PRIMARY KEY (id, reviewTimeId, userId)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Logs all triggers by unique users to items that were still in review period. It is triggered if a user attempts to trade an item that is still in the review period.';

ALTER TABLE `tradeBot_ItemReviewTimeTriggered` 
  ADD UNIQUE INDEX `unique`(reviewTimeId, userId);