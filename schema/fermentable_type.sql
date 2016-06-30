-- grain, sugar, (liquid) extract, dry extract, adjunct
CREATE TABLE IF NOT EXISTS fermentable_type (
	fermentable_type_uuid varchar(36) not null,
	name varchar(50) not null,
	PRIMARY KEY (fermentable_type_uuid),
	UNIQUE (name)
);
