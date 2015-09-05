-- bittering, aroma, flavor
CREATE TABLE IF NOT EXISTS hop_type (
	hop_type_uuid varchar(36) not null,
	name varchar(50),
	PRIMARY KEY (hop_type_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB default CHARSET=utf8;
