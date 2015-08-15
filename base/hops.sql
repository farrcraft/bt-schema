-- a basic hop profile
CREATE TABLE IF NOT EXISTS hop_profile (
	hop_profile_uuid varchar(36) not null,
	name varchar(200) not null,
	description varchar(2000) default null,
	origin varchar(200) default null,
	PRIMARY KEY (hop_profile_uuid)
) ENGINE=InnoDB default CHARSET=utf8;


-- maps attribute values to a hop profile
-- attribute kinds for hop profiles are:
-- beta_acid, alpha_acid, hsi (hop stability index), humulene, caryophyllene, cohumulone, myrcene
CREATE TABLE IF NOT EXISTS hop_profile_attribute_value_map (
	hop_profile_attribute_value_map_uuid varchar(36) not null,
	hop_profile_uuid varchar(36) not null,
	attribute_value_uuid varchar(36) not null,
	PRIMARY KEY(hop_profile_attribute_value_map_uuid),
	FOREIGN KEY (hop_profile_uuid) REFERENCES hop_profile (hop_profile_uuid),
	FOREIGN KEY (attribute_value_uuid) REFERENCES attribute_value (attribute_value_uuid)
) ENGINE=InnoDB default CHARSET=utf8;


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


-- bittering, aroma, flavor
CREATE TABLE IF NOT EXISTS hop_type (
	hop_type_uuid varchar(36) not null,
	name varchar(50),
	PRIMARY KEY (hop_type_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB default CHARSET=utf8;


-- boil, dry hop, mash, first wort, flameout, whirlpool, stand
CREATE TABLE IF NOT EXISTS hop_usage (
	hop_usage_uuid varchar(36) not null,
	name varchar(200) not null,
	PRIMARY KEY (hop_usage_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB default CHARSET=utf8;


-- link hop type to profile
CREATE TABLE IF NOT EXISTS hop_profile_type (
	hop_profile_type_uuid varchar(36) not null,
	hop_type_uuid varchar(36) not null,
	hop_profile_uuid varchar(36) not null,
	PRIMARY KEY (hop_profile_type_uuid),
	UNIQUE KEY (hop_profile_uuid, hop_type_uuid),
	FOREIGN KEY (hop_profile_uuid) REFERENCES hop_profile (hop_profile_uuid),
	FOREIGN KEY (hop_type_uuid) REFERENCES hop_type (hop_type_uuid)
) ENGINE=InnoDB default CHARSET=utf8;


-- defines common recommended usages for types of hops (not their recipe specific usages)
CREATE TABLE IF NOT EXISTS hop_profile_usage (
	hop_profile_usage_uuid varchar(36) not null,
	hop_usage_uuid varchar(36) not null,
	hop_profile_uuid varchar(36) not null,
	PRIMARY KEY (hop_profile_usage_uuid),
	FOREIGN KEY (hop_profile_uuid) REFERENCES hop_profile (hop_profile_uuid),
	FOREIGN KEY (hop_usage_uuid) REFERENCES hop_usage (hop_usage_uuid),
	UNIQUE KEY (hop_profile_uuid, hop_usage_uuid)
) ENGINE=InnoDB default CHARSET=utf8;


-- pellet, plug, leaf, wet
CREATE TABLE IF NOT EXISTS hop_form (
	hop_form_uuid varchar(36) not null,
	name varchar(50) not null,
	PRIMARY KEY (hop_form_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB default CHARSET=utf8;


-- an actual hop instance as bought from a distributor and used in a recipe
CREATE TABLE IF NOT EXISTS hop (
	hop_uuid varchar(36) not null,
	hop_profile_uuid varchar(36) not null,
	user_uuid varchar(36) not null,
	season int(11) unsigned default null,
	distributor_uuid varchar(36) default null,
	hop_form_uuid varchar(36) not null,
	PRIMARY KEY (hop_uuid),
	FOREIGN KEY (hop_form_uuid) REFERENCES hop_form (hop_form_uuid),
	FOREIGN KEY (distributor_uuid) REFERENCES distributor (distributor_uuid),
	FOREIGN KEY (hop_profile_uuid) REFERENCES hop_profile (hop_profile_uuid),
	FOREIGN KEY (user_uuid) REFERENCES user (user_uuid)
) ENGINE=InnoDB default CHARSET=utf8;


-- maps actual hop parameters to a hop instance
-- same attribute kinds as used by hop_profile
CREATE TABLE IF NOT EXISTS hop_attribute_value_map (
	hop_attribute_value_map_uuid varchar(36) not null,
	hop_uuid varchar(36) not null,
	attribute_value_uuid varchar(36) not null,
	PRIMARY KEY(hop_attribute_value_map_uuid),
	FOREIGN KEY (hop_uuid) REFERENCES hop (hop_uuid),
	FOREIGN KEY (attribute_value_uuid) REFERENCES attribute_value (attribute_value_uuid)
) ENGINE=InnoDB default CHARSET=utf8;


