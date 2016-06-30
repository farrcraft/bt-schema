-- all measurements taken during the brewing process are recorded here
CREATE TABLE IF NOT EXISTS measurement (
	measurement_uuid varchar(36) not null,
	attribute_value_uuid varchar(36) not null,
	measurement_type_uuid varchar(36) not null,
	user_uuid varchar(36) not null,
	batch_uuid varchar(36) default null,
	date_measured_timestamp integer not null,
	PRIMARY KEY (measurement_uuid),
	FOREIGN KEY (attribute_value_uuid) REFERENCES attribute_value (attribute_value_uuid),
	FOREIGN KEY (measurement_type_uuid) REFERENCES measurement_type (measurement_type_uuid),
	FOREIGN KEY (user_uuid) REFERENCES "user" (user_uuid),
	FOREIGN KEY (batch_uuid) REFERENCES batch (batch_uuid)
);
