CREATE TABLE `snapshot_Requests` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` INT(11) UNSIGNED DEFAULT NULL COMMENT '->users.id',
  `IPstr` VARCHAR(46) DEFAULT NULL COMMENT 'IP from which the request was made',
  `time` INT(10) UNSIGNED DEFAULT 0 COMMENT 'UNIX timestamp when this entry was created',
  `steamid` BIGINT(20) UNSIGNED NOT NULL COMMENT 'steamid of the item to screenshot',
  `assetid` BIGINT(20) UNSIGNED NOT NULL COMMENT 'assetid of the item to screenshot',
  `inspectcode` BIGINT(20) UNSIGNED NOT NULL COMMENT 'inspectcode of the item to screenshot',
  `status` SMALLINT(255) NOT NULL DEFAULT 0 COMMENT 'REQUEST_STATUS_INQUEUE = 0;
        const REQUEST_STATUS_IN_PROGRESS = 1;
        const REQUEST_STATUS_DONE = 2;
        const REQUEST_STATUS_TIMEDOUT = 3;
        const REQUEST_STATUS_ERROR = 4;',
  `type` SMALLINT(255) NOT NULL DEFAULT 1,
  `flags` SMALLINT(255) NOT NULL DEFAULT 0,
  `order` SMALLINT(255) NOT NULL DEFAULT 0 COMMENT 'used so that if a large batch is queued at one time, the requests will have different order values. This way newer requests will be handled soon even when there''s backlog. This value is set manually by the scripts',
  `errorStr` VARCHAR(128) DEFAULT NULL COMMENT 'Set if the screenshot request failed',
  `itemType` VARCHAR(64) DEFAULT NULL COMMENT 'CSGO item type',
  `jobStarted` DECIMAL(14, 4) DEFAULT NULL COMMENT 'UNIX timestamp when the job was started',
  `jobEnded` DECIMAL(14, 4) DEFAULT NULL COMMENT 'UNIX timestamp when the job was ended/finished',
  `numberOfXImagesInSequence` SMALLINT(6) DEFAULT NULL COMMENT 'If this is an image sequence (for 3D)',
  `numberOfYImagesInSequence` SMALLINT(6) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci,
COMMENT = 'Table for handled and queued jobs sent/to be sent to the snapshot clients.';

ALTER TABLE `snapshot_Requests` 
  ADD INDEX search(steamid, assetid, inspectcode);

ALTER TABLE `snapshot_Requests` 
  ADD INDEX status(status);