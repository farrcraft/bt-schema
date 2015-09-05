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
