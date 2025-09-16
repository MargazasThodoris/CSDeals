CREATE TABLE `tblUserHierarchy` (
  `master_user_id` INT(11) UNSIGNED NOT NULL,
  `user_id` INT(11) UNSIGNED NOT NULL,
  `organization_id` INT(11) DEFAULT NULL,
  PRIMARY KEY (master_user_id, user_id)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

ALTER TABLE `tblUserHierarchy` 
  ADD CONSTRAINT `FK_tblUserHierarchy_master_user_id` FOREIGN KEY (master_user_id)
    REFERENCES users(id) ON DELETE NO ACTION;

ALTER TABLE `tblUserHierarchy` 
  ADD CONSTRAINT `FK_tblUserHierarchy_organization_id2` FOREIGN KEY (organization_id)
    REFERENCES tblOrganization(id) ON DELETE NO ACTION;

ALTER TABLE `tblUserHierarchy` 
  ADD CONSTRAINT `FK_tblUserHierarchy_user_id` FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE NO ACTION;