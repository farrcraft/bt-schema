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
