-- boil, mash, fermentation, serving, lauter
CREATE TABLE IF NOT EXISTS equipment_usage (
	equipment_usage_uuid varchar(36) not null,
	name varchar(36) not null,
	PRIMARY KEY (equipment_usage_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- keg, kettle, bucket, plastic bottle, round cooler, carboy, rectangular cooler, keggle, conical
CREATE TABLE IF NOT EXISTS equipment_type (
	equipment_type_uuid varchar(36) not null,
	name varchar(36) not null,
	PRIMARY KEY (equipment_type_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- definition of a piece of equipment
CREATE TABLE IF NOT EXISTS equipment_profile (
	equipment_profile_uuid varchar(36) not null,
	user_uuid varchar(36) not null,
	name varchar(200) not null,
	description varchar(255) default null,
	equipment_type_uuid varchar(36) not null,
	PRIMARY KEY (equipment_profile_uuid),
	FOREIGN KEY (equipment_type_uuid) REFERENCES equipment_type (equipment_type_uuid),
	FOREIGN KEY (user_uuid) REFERENCES user (user_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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


-- equipment attribute value kinds:
-- equipment capacity (kettle volume / mash tun volume / etc)
-- mash tun weight, mash tun specific heat, top up water volume, 
-- equipment material (stainless/glass/plastic/etc)
-- trub / chiller loss (volume lost from boiler after transfer to fermentation vessel)
-- boil evaporation rate, boil time, lauter deadspace, kettle top up volume, hop utilization
CREATE TABLE IF NOT EXISTS equipment_profile_attribute_value_map (
	equipment_profile_attribute_value_map_uuid varchar(36) not null,
	equipment_profile_uuid varchar(36) not null,
	attribute_value_uuid varchar(36) not null,
	PRIMARY KEY (equipment_profile_attribute_value_map_uuid),
	UNIQUE KEY (equipment_profile_uuid, attribute_value_uuid),
	FOREIGN KEY (equipment_profile_uuid) REFERENCES equipment_profile (equipment_profile_uuid),
	FOREIGN KEY (attribute_value_uuid) REFERENCES attribute_value (attribute_value_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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
