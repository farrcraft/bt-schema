-- keg, kettle, bucket, plastic bottle, round cooler, carboy, rectangular cooler, keggle, conical
CREATE TABLE IF NOT EXISTS equipment_type (
	equipment_type_uuid varchar(36) not null,
	name varchar(36) not null,
	PRIMARY KEY (equipment_type_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
