-- tap, filtered, reverse osmosis, spring, distilled
CREATE TABLE IF NOT EXISTS water_source (
	water_source_uuid varchar(36),
	name varchar(50) not null,
	PRIMARY KEY (water_source_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
