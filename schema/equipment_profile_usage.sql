-- defines how different pieces of equipment can be used
-- single pieces of equipment might have multiple potential usages
-- e.g. kegs can be used for both fermentation and serving
CREATE TABLE IF NOT EXISTS equipment_profile_usage (
	equipment_profile_usage_uuid varchar(36) not null,
	equipment_profile_uuid varchar(36) not null,
	equipment_usage_uuid varchar(36) not null,
	PRIMARY KEY (equipment_profile_usage_uuid),
	UNIQUE KEY (equipment_profile_uuid, equipment_usage_uuid),
	FOREIGN KEY (equipment_profile_uuid) REFERENCES equipment_profile (equipment_profile_uuid),
	FOREIGN KEY (equipment_usage_uuid) REFERENCES equipment_usage (equipment_usage_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
