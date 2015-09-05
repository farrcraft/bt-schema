CREATE TABLE IF NOT EXISTS user_role (
	user_role_uuid varchar(36) not null,
	user_uuid varchar(36) not null,
	role_uuid varchar(36) not null,
	PRIMARY KEY (user_role_uuid),
	FOREIGN KEY (user_uuid) REFERENCES user (user_uuid),
	FOREIGN KEY (role_uuid) REFERENCES role (role_uuid),
	UNIQUE KEY (user_uuid, role_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
