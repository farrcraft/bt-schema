-- temperature, weight, volume, time, specific gravity, pressure
CREATE TABLE IF NOT EXISTS unit_category (
	unit_category_uuid varchar(36) not null,
	name varchar(50) not null,
	PRIMARY KEY (unit_category_uuid),
	UNIQUE (name)
);
