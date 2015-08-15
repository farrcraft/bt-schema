-- tap, filtered, reverse osmosis, spring, distilled
CREATE TABLE IF NOT EXISTS water_source (
	water_source_uuid varchar(36),
	name varchar(50) not null,
	PRIMARY KEY (water_source_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS water_profile (
	water_profile_uuid varchar(36) not null,
	name varchar(200) not null,
	description varchar(2000) default null,
	calcium decimal(19,4),
	magnesium decimal(19,4),
	sulfate decimal(19,4),
	sodium decimal(19,4),
	chloride decimal(19,4),
	alkalinity decimal(19,4),
	bicarbonate decimal(19,4),
	ph decimal(19,4),
	PRIMARY KEY (water_profile_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- specifies a percentage mix of water profiles that are combined to create a final profile
CREATE TABLE IF NOT EXISTS water_mix (
	water_mix_uuid varchar(36) not null,
	water_source_uuid varchar(36) not null,
	water_profile_uuid varchar(36) not null,
	PRIMARY KEY (water_mix_uuid),
	FOREIGN KEY (water_source_uuid) REFERENCES water_source (water_source_uuid),
	FOREIGN KEY (water_profile_uuid) REFERENCES water_profile (water_profile_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- an adjustment made to water
CREATE TABLE IF NOT EXISTS water_adjustment (
	water_adjustment_uuid varchar(36) not null,
	ingredient_uuid varchar(36) not null,
	water_profile_uuid varchar(36) not null,
	amount decimal(19,4),
	PRIMARY KEY (water_adjustment_uuid),
	UNIQUE KEY (ingredient_uuid, water_profile_uuid),
	FOREIGN KEY (ingredient_uuid) REFERENCES ingredient (ingredient_uuid),
	FOREIGN KEY (water_profile_uuid) REFERENCES water_profile (water_profile_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
