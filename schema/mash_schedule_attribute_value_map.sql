-- mash profile attribute value kinds:
-- grain temperature (prior to mash), tun temperature (e.g. if tun is preheated), sparge temperature,
-- sparge ph, tun weight, tun specific heat (calories per gram-degree C)
CREATE TABLE IF NOT EXISTS mash_schedule_attribute_value_map (
	mash_schedule_attribute_value_map_uuid varchar(36) not null,
	mash_schedule_uuid varchar(36) not null,
	attribute_value_uuid varchar(36) not null,
	PRIMARY KEY (mash_schedule_attribute_value_map_uuid),
	UNIQUE (mash_schedule_uuid, attribute_value_uuid),
	FOREIGN KEY (mash_schedule_uuid) REFERENCES mash_schedule (mash_schedule_uuid),
	FOREIGN KEY (attribute_value_uuid) REFERENCES attribute_value (attribute_value_uuid)
);
