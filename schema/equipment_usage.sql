-- boil, mash, fermentation, serving, lauter
CREATE TABLE IF NOT EXISTS equipment_usage (
	equipment_usage_uuid varchar(36) not null,
	name varchar(36) not null,
	PRIMARY KEY (equipment_usage_uuid),
	UNIQUE (name)
);
