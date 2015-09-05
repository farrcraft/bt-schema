-- mash step attribute value kinds:
-- infusion amount, step temperature, step time, ramp time, end (falloff) temperature,
-- strike temperature
CREATE TABLE IF NOT EXISTS mash_step_attribute_value_map (
	mash_step_attribute_value_map_uuid varchar(36) not null,
	mash_step_uuid varchar(36) not null,
	attribute_value_uuid varchar(36) not null,
	PRIMARY KEY (mash_step_attribute_value_map_uuid),
	UNIQUE KEY (mash_step_uuid, attribute_value_uuid),
	FOREIGN KEY (mash_step_uuid) REFERENCES mash_step (mash_step_uuid),
	FOREIGN KEY (attribute_value_uuid) REFERENCES attribute_value (attribute_value_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
