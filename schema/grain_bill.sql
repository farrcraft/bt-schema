CREATE TABLE IF NOT EXISTS grain_bill (
	grain_bill_uuid varchar(36) not null,
	recipe_uuid varchar(36) not null,
	ingredient_uuid varchar(36) not null,
	unit_kind_uuid varchar(36) not null,
	amount decimal(19,4) default 0,
	PRIMARY KEY (grain_bill_uuid),
	FOREIGN KEY (recipe_uuid) REFERENCES recipe (recipe_uuid),
	FOREIGN KEY (unit_kind_uuid) REFERENCES unit_kind (unit_kind_uuid),
	FOREIGN KEY (ingredient_uuid) REFERENCES ingredient (ingredient_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
