-- common properties of fermentable ingredients (grains, sugars, honeys, fruits, etc)
CREATE TABLE IF NOT EXISTS fermentable_profile (
	fermentable_profile_uuid varchar(36) not null,
	name varchar(200) not null,
	description varchar(1000) default null,
	origin varchar(50) default null,
	fermentable_type_uuid varchar(36) not null,
	vendor_uuid varchar(36) default null,
	PRIMARY KEY (fermentable_profile_uuid),
	FOREIGN KEY (fermentable_type_uuid) REFERENCES fermentable_type (fermentable_type_uuid),
	FOREIGN KEY (vendor_uuid) REFERENCES vendor (vendor_uuid)
);
