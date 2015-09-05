-- boil, mash, primary, secondary, bottling
CREATE TABLE IF NOT EXISTS ingredient_usage (
	ingredient_usage_uuid varchar(36) not null,
	name varchar(100) not null,
	PRIMARY KEY (ingredient_usage_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
