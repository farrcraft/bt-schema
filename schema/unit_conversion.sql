-- units of different types can be converted between
CREATE TABLE IF NOT EXISTS unit_conversion (
	unit_conversion_uuid varchar(36) not null,
	source_unit_kind_uuid varchar(36) not null,
	target_unit_kind_uuid varchar(36) not null,
	factor varchar(255) not null,
	PRIMARY KEY (unit_conversion_uuid),
	FOREIGN KEY (source_unit_kind_uuid) REFERENCES unit_kind (unit_kind_uuid),
	FOREIGN KEY (target_unit_kind_uuid) REFERENCES unit_kind (unit_kind_uuid)
);
