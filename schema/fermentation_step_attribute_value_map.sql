-- fermentation step attribute value kinds
-- temperature, duration
CREATE TABLE IF NOT EXISTS fermentation_step_attribute_value_map (
	fermentation_step_attribute_value_map_uuid varchar(36) not null,
	fermentation_step_uuid varchar(36) not null,
	attribute_value_uuid varchar(36) not null,
	PRIMARY KEY (fermentation_step_attribute_value_map_uuid),
	UNIQUE KEY (fermentation_step_uuid, attribute_value_uuid),
	FOREIGN KEY (fermentation_step_uuid) REFERENCES fermentation_step (fermentation_step_uuid),
	FOREIGN KEY (attribute_value_uuid) REFERENCES attribute_value (attribute_value_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
