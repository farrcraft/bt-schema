-- points, ppg, kPa, brix, kg, liters, celsius, etc
-- weight units: kg, g, oz, lb
-- volume units: tsp, tbsp, oz, cup, pint, quart, mL, L
-- temperature: F, C
-- time: min, hour, day, week
-- color: srm, ebc, L
-- specific gravity: sg, plato
CREATE TABLE IF NOT EXISTS unit_kind (
	unit_kind_uuid varchar(36) not null,
	abbreviation varchar(20),
	name varchar(100) not null,
	unit_category_uuid varchar(36) not null,
	measurement_system_uuid varchar(36) default null,
	state enum ('solid', 'liquid') default null,
	PRIMARY KEY (unit_kind_uuid),
	FOREIGN KEY (unit_category_uuid) REFERENCES unit_category (unit_category_uuid),
	FOREIGN KEY (measurement_system_uuid) REFERENCES measurement_system (measurement_system_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
