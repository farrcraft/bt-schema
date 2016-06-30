-- ale, lager, wheat, wine, champagne
CREATE TABLE IF NOT EXISTS yeast_type (
	yeast_type_uuid varchar(36) not null,
	name varchar(50) not null,
	PRIMARY KEY (yeast_type_uuid),
	UNIQUE (name)
);
