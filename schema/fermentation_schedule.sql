CREATE TABLE IF NOT EXISTS fermentation_schedule (
	fermentation_schedule_uuid varchar(36) not null,
	recipe_uuid varchar(36) not null,
	PRIMARY KEY (fermentation_schedule_uuid),
	FOREIGN KEY (recipe_uuid) REFERENCES recipe (recipe_uuid)
);
