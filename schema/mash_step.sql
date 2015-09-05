CREATE TABLE IF NOT EXISTS mash_step (
	mash_step_uuid varchar(36) not null,
	mash_schedule_uuid varchar(36) not null,
	name varchar (255),
	step_order int(11) not null,
	mash_step_type_uuid varchar(36) not null,
	duration int(11) not null,
	ingredient_uuid varchar(36) default null,
	ingredient_amount decimal(19,4) default null,
	PRIMARY KEY (mash_step_uuid),
	FOREIGN KEY (mash_schedule_uuid) REFERENCES mash_schedule (mash_schedule_uuid),
	FOREIGN KEY (mash_step_type_uuid) REFERENCES mash_step_type (mash_step_type_uuid),
	FOREIGN KEY (ingredient_uuid) REFERENCES ingredient (ingredient_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
