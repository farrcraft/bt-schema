-- defines where in the process that the measurement was taken
-- e.g. mash, boil, fermentation
CREATE TABLE IF NOT EXISTS measurement_type (
	measurement_type_uuid varchar(36) not null,
	name varchar(100) not null,
	PRIMARY KEY (measurement_type_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
