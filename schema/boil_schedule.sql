-- specifies amount of time to boil
CREATE TABLE IF NOT EXISTS boil_schedule (
	boil_schedule_uuid varchar(36) not null,
	recipe_uuid varchar(36) not null,
	duration integer not null default 0,
	PRIMARY KEY (boil_schedule_uuid),
	FOREIGN KEY (recipe_uuid) REFERENCES recipe (recipe_uuid)
);
