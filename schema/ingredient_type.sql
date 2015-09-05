-- e.g. grain, hop, yeast, herb, spice, fruit, fining, mineral, chemical, fermentable, adjunct, flavor
CREATE TABLE IF NOT EXISTS ingredient_type (
	ingredient_type_uuid varchar(36) not null,
	name varchar(100) not null,
	PRIMARY KEY (ingredient_type_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
