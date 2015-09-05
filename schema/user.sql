CREATE TABLE IF NOT EXISTS user (
	user_uuid varchar(36) not null,
	email varchar(200) not null,
	first_name varchar(200) default null,
	last_name varchar(200) default null,
	password char(200) not null,
	salt char(200) not null,
	date_created_timestamp int(11) unsigned not null,
	date_updated_timestamp int(11) unsigned not null,
	deleted tinyint(4) unsigned not null default 0,
	measurement_system_uuid varchar(36) default null,
	PRIMARY KEY (user_uuid),
	FOREIGN KEY (measurement_system_uuid) REFERENCES measurement_system (measurement_system_uuid),
	UNIQUE KEY (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
