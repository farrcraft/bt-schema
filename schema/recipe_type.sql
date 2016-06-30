-- extract, partial mash, all grain
CREATE TABLE IF NOT EXISTS recipe_type (
	recipe_type_uuid varchar(36) not null,
	name varchar(50) not null,
	PRIMARY KEY (recipe_type_uuid),
	UNIQUE (name)
);
