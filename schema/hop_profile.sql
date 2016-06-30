-- a basic hop profile
CREATE TABLE IF NOT EXISTS hop_profile (
	hop_profile_uuid varchar(36) not null,
	name varchar(200) not null,
	description varchar(2000) default null,
	origin varchar(200) default null,
	PRIMARY KEY (hop_profile_uuid)
);
