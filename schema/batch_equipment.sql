-- defines which equipment is actually used through the lifecycle of a brew (batch)
-- and how it is used
-- usage is bound here as well as the profile since equipment can potentially be used in different ways
-- here we specify it is used within the context of the recipe
CREATE TABLE IF NOT EXISTS batch_equipment (
	batch_equipment_uuid varchar(36) not null,
	batch_uuid varchar(36) not null,
	equipment_profile_uuid varchar(36)  not null,
	equipment_usage_uuid varchar(36) not null,
	PRIMARY KEY (batch_equipment_uuid),
	FOREIGN KEY (batch_uuid) REFERENCES batch (batch_uuid),
	FOREIGN KEY (equipment_profile_uuid) REFERENCES equipment_profile (equipment_profile_uuid),
	FOREIGN KEY (equipment_usage_uuid) REFERENCES equipment_usage (equipment_usage_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
