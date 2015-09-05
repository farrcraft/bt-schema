
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
