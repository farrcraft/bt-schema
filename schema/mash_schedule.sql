CREATE TABLE IF NOT EXISTS mash_schedule (
	mash_schedule_uuid varchar(36) not null,
	recipe_uuid varchar(36) not null,
	name varchar(255) default null,
	description varchar(2000) default null,
	duration int(11) not null,
	PRIMARY KEY (mash_schedule_uuid),
	FOREIGN KEY (recipe_uuid) REFERENCES recipe (recipe_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
