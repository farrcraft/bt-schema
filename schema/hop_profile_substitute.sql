-- defines potential substututes for hop profiles
CREATE TABLE IF NOT EXISTS hop_profile_substitute (
	hop_substitute_uuid varchar(36) not null,
	hop_profile_uuid varchar(36) not null,
	hop_profile_substitute_uuid varchar(36) not null,
	PRIMARY KEY (hop_substitute_uuid),
	UNIQUE KEY (hop_profile_uuid, hop_substitute_uuid),
	FOREIGN KEY (hop_profile_uuid) REFERENCES hop_profile (hop_profile_uuid),
	FOREIGN KEY (hop_profile_substitute_uuid) REFERENCES hop_profile (hop_profile_uuid)
) ENGINE=InnoDB default CHARSET=utf8;
