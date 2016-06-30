-- specifies a percentage mix of water profiles that are combined to create a final profile
CREATE TABLE IF NOT EXISTS water_mix (
	water_mix_uuid varchar(36) not null,
	water_source_uuid varchar(36) not null,
	water_profile_uuid varchar(36) not null,
	PRIMARY KEY (water_mix_uuid),
	FOREIGN KEY (water_source_uuid) REFERENCES water_source (water_source_uuid),
	FOREIGN KEY (water_profile_uuid) REFERENCES water_profile (water_profile_uuid)
);
