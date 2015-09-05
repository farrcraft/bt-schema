CREATE TABLE IF NOT EXISTS inventory (
	inventory_uuid varchar(36) not null,
	user_uuid varchar(36) not null,
	PRIMARY KEY (inventory_uuid),
	FOREIGN KEY (user_uuid) REFERENCES user (user_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
