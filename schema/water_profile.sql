
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
