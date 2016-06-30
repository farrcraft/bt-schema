-- defines common recommended usages for types of hops (not their recipe specific usages)
CREATE TABLE IF NOT EXISTS hop_profile_usage (
	hop_profile_usage_uuid varchar(36) not null,
	hop_usage_uuid varchar(36) not null,
	hop_profile_uuid varchar(36) not null,
	PRIMARY KEY (hop_profile_usage_uuid),
	FOREIGN KEY (hop_profile_uuid) REFERENCES hop_profile (hop_profile_uuid),
	FOREIGN KEY (hop_usage_uuid) REFERENCES hop_usage (hop_usage_uuid),
	UNIQUE (hop_profile_uuid, hop_usage_uuid)
);
