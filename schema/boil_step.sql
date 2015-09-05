-- an individual step during the boil
-- e.g. ingredient additions (hops, finings, etc)
CREATE TABLE IF NOT EXISTS boil_step (
	boil_step_uuid varchar(36) not null,
	boil_schedule_uuid varchar(36) not null,
	step_time int(11) not null,
	name varchar(255) default null,
	description varchar(1500) default null,
	ingredient_uuid varchar(36) default null,
	ingredient_amount decimal(19,4) default null,
	PRIMARY KEY (boil_step_uuid),
	FOREIGN KEY (boil_schedule_uuid) REFERENCES boil_schedule (boil_schedule_uuid),
	FOREIGN KEY (ingredient_uuid) REFERENCES ingredient (ingredient_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
