CREATE TABLE IF NOT EXISTS role (
	role_uuid varchar(36) not null,
	name varchar(50) not null,
	description varchar(255) default null,
	PRIMARY KEY (role_uuid),
	UNIQUE (name)
);
