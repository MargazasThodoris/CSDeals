CREATE TABLE `steamItems_CSGOStickersWithComma` (
  `stickerName` VARCHAR(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'Full item name of the sticker',
  PRIMARY KEY (stickerName)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci,
COMMENT = 'We need to know the name of CSGO sticker names that have a comma in their name so we can properly extract sticker names from the item HTML description.';

ALTER TABLE `steamItems_CSGOStickersWithComma` 
  ADD UNIQUE INDEX uniq(stickerName);