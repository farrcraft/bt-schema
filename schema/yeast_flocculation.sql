-- low, medium, high, very high
CREATE TABLE IF NOT EXISTS yeast_flocculation (
	yeast_flocculation_uuid varchar(36) not null,
	name varchar(50) not null,
	PRIMARY KEY (yeast_flocculation_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB default CHARSET=utf8;
