-- link hop type to profile
CREATE TABLE IF NOT EXISTS hop_profile_type (
	hop_profile_type_uuid varchar(36) not null,
	hop_type_uuid varchar(36) not null,
	hop_profile_uuid varchar(36) not null,
	PRIMARY KEY (hop_profile_type_uuid),
	UNIQUE (hop_profile_uuid, hop_type_uuid),
	FOREIGN KEY (hop_profile_uuid) REFERENCES hop_profile (hop_profile_uuid),
	FOREIGN KEY (hop_type_uuid) REFERENCES hop_type (hop_type_uuid)
);
