-- ale, lager, wheat, wine, champagne
CREATE TABLE IF NOT EXISTS yeast_type (
	yeast_type_uuid varchar(36) not null,
	name varchar(50) not null,
	PRIMARY KEY (yeast_type_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB default CHARSET=utf8;


CREATE TABLE IF NOT EXISTS yeast_lab (
	yeast_lab_uuid varchar(36) not null,
	name varchar(200) not null,
	PRIMARY KEY (yeast_lab_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB default CHARSET=utf8;


-- liquid, dry, slant, culture
CREATE TABLE IF NOT EXISTS yeast_form (
	yeast_form_uuid varchar(36) not null,
	name varchar(50) not null,
	PRIMARY KEY (yeast_form_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB default CHARSET=utf8;


-- low, medium, high, very high
CREATE TABLE IF NOT EXISTS yeast_flocculation (
	yeast_flocculation_uuid varchar(36) not null,
	name varchar(50) not null,
	PRIMARY KEY (yeast_flocculation_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB default CHARSET=utf8;


CREATE TABLE IF NOT EXISTS yeast_profile (
	yeast_profile_uuid varchar(36) not null,
	name varchar(200) not null,
	strain varchar(200) not null,
	yeast_lab_uuid varchar(36) default null,
	description varchar(2000) default null,
	yeast_type_uuid varchar(36) not null,
	yeast_form_uuid varchar(36) not null,
	yeast_flocculation_uuid varchar(36) not null,
	PRIMARY KEY (yeast_profile_uuid),
	UNIQUE KEY (strain, yeast_lab_uuid),
	FOREIGN KEY (yeast_type_uuid) REFERENCES yeast_type (yeast_type_uuid),
	FOREIGN KEY (yeast_form_uuid) REFERENCES yeast_form (yeast_form_uuid),
	FOREIGN KEY (yeast_flocculation_uuid) REFERENCES yeast_flocculation (yeast_flocculation_uuid),
	FOREIGN KEY (yeast_lab_uuid) REFERENCES yeast_lab (yeast_lab_uuid)
) ENGINE=InnoDB default CHARSET=utf8;


-- map of yeast to recommended bjcp styles
CREATE TABLE IF NOT EXISTS yeast_style (
	yeast_style_uuid varchar(36) not null,
	yeast_profile_uuid varchar(36) not null,
	bjcp_style_uuid varchar(36) not null,
	PRIMARY KEY (yeast_style_uuid),
	UNIQUE KEY (yeast_profile_uuid, bjcp_style_uuid),
	FOREIGN KEY (yeast_profile_uuid) REFERENCES yeast_profile (yeast_profile_uuid),
	FOREIGN KEY (bjcp_style_uuid) REFERENCES bjcp_style (bjcp_style_uuid)
) ENGINE=InnoDB default CHARSET=utf8;


-- yeast attribute value kinds:
-- temperature (min/max), attenuation (avg %)
CREATE TABLE IF NOT EXISTS yeast_profile_attribute_value_map (
	yeast_profile_attribute_value_map_uuid varchar(36) not null,
	yeast_profile_uuid varchar(36) not null,
	attribute_value_uuid varchar(36) not null,
	PRIMARY KEY (yeast_profile_attribute_value_map_uuid),
	UNIQUE KEY (yeast_profile_uuid, attribute_value_uuid),
	FOREIGN KEY (yeast_profile_uuid) REFERENCES yeast_profile (yeast_profile_uuid),
	FOREIGN KEY (attribute_value_uuid) REFERENCES attribute_value (attribute_value_uuid)
) ENGINE=InnoDB default CHARSET=utf8;


CREATE TABLE IF NOT EXISTS yeast (
	yeast_uuid varchar(36) not null,
	user_uuid varchar(36) not null,
	yeast_profile_uuid varchar(36) not null,
	lot_number varchar(100) default null,
	best_use_by_timestamp int(11) unsigned default null,
	culture_count int(10) default 0,
	PRIMARY KEY (yeast_uuid),
	FOREIGN KEY (yeast_profile_uuid) REFERENCES yeast_profile (yeast_profile_uuid),
	FOREIGN KEY (user_uuid) REFERENCES user (user_uuid)
) ENGINE=InnoDB default CHARSET=utf8;

