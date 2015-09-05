CREATE TABLE IF NOT EXISTS ingredient (
	ingredient_uuid varchar(36) not null,
	ingredient_type_uuid varchar(36) not null,
	name varchar(255) not null,
	description varchar(2000) default null,
	fermentable_profile_uuid varchar(36) default null,
	hop_uuid varchar(36) default null,
	yeast_uuid varchar(36) default null,
	distributor_uuid varchar(36) default null,
	user_uuid varchar(36) not null,
	PRIMARY KEY (ingredient_uuid),
	FOREIGN KEY (ingredient_type_uuid) REFERENCES ingredient_type (ingredient_type_uuid),
	FOREIGN KEY (fermentable_profile_uuid) REFERENCES fermentable_profile (fermentable_profile_uuid),
	FOREIGN KEY (hop_uuid) REFERENCES hop (hop_uuid),
	FOREIGN KEY (yeast_uuid) REFERENCES yeast (yeast_uuid),
	FOREIGN KEY (distributor_uuid) REFERENCES distributor (distributor_uuid),
	FOREIGN KEY (user_uuid) REFERENCES user (user_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
