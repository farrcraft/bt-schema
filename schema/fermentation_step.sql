-- defines the various fermentation steps
-- this captures basic steps, any additions during fermentation (e.g. dry hopping), or temperature
-- changes
CREATE TABLE IF NOT EXISTS fermentation_step (
	fermentation_step_uuid varchar(36) not null,
	fermentation_schedule_uuid varchar(36) not null,
	step_order integer not null,
	stage integer not null,
	temperature decimal(19,4) default null,
	duration integer not null,
	ingredient_uuid varchar(36) default null,
	ingredient_amount decimal(19,4),
	PRIMARY KEY (fermentation_step_uuid),
	FOREIGN KEY (fermentation_schedule_uuid) REFERENCES fermentation_schedule (fermentation_schedule_uuid),
	FOREIGN KEY (ingredient_uuid) REFERENCES ingredient (ingredient_uuid)
);
