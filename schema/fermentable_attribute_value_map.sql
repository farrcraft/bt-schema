-- fermentable attribute value kinds:
-- color (lovibond or srm), yield (percent dry yield or raw yield by weight), moisture (%),
-- diastatic power (lintner), coarse/fine yield delta (grains & adjuncts), protein (%),
-- post-boil (bool), recommend mash (bool), max in batch (% by weight)
CREATE TABLE IF NOT EXISTS fermentable_attribute_value_map (
	fermentable_attribute_value_map_uuid varchar(36) not null,
	fermentable_profile_uuid varchar(36) not null,
	attribute_value_uuid varchar(36) not null,
	PRIMARY KEY (fermentable_attribute_value_map_uuid),
	UNIQUE KEY (fermentable_profile_uuid, attribute_value_uuid),
	FOREIGN KEY (fermentable_profile_uuid) REFERENCES fermentable_profile (fermentable_profile_uuid),
	FOREIGN KEY (attribute_value_uuid) REFERENCES attribute_value (attribute_value_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
