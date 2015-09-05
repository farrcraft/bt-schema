CREATE TABLE IF NOT EXISTS measurement_system (
	measurement_system_uuid varchar(36) not null,
	name varchar(50) not null,
	PRIMARY KEY (measurement_system_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
