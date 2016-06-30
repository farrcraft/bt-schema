-- an adjustment made to water
CREATE TABLE IF NOT EXISTS water_adjustment (
	water_adjustment_uuid varchar(36) not null,
	ingredient_uuid varchar(36) not null,
	water_profile_uuid varchar(36) not null,
	amount decimal(19,4),
	PRIMARY KEY (water_adjustment_uuid),
	UNIQUE (ingredient_uuid, water_profile_uuid),
	FOREIGN KEY (ingredient_uuid) REFERENCES ingredient (ingredient_uuid),
	FOREIGN KEY (water_profile_uuid) REFERENCES water_profile (water_profile_uuid)
);
