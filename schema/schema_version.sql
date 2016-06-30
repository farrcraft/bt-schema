-- type can be 'table' or 'data'
CREATE TABLE IF NOT EXISTS schema_version (
	schema_version_uuid varchar(36) not null,
	name varchar(120) not null,
	type varchar(50) not null,
	version integer not null default 0,
	PRIMARY KEY (schema_version_uuid),
	UNIQUE (name, type)
);
