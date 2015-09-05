-- recipe attribute value kinds
-- brewhouse efficiency, mash efficiency, target og, target fg
-- boil size (pre-boil volume), batch size (post-boil pre-fermentation volume)
CREATE TABLE IF NOT EXISTS recipe_attribute_value_map (
	recipe_attribute_value_map_uuid varchar(36) not null,
	recipe_uuid varchar(36) not null,
	attribute_value_uuid varchar(36) not null,
	PRIMARY KEY (recipe_attribute_value_map_uuid),
	UNIQUE KEY (recipe_uuid, attribute_value_uuid),
	FOREIGN KEY (recipe_uuid) REFERENCES recipe (recipe_uuid),
	FOREIGN KEY (attribute_value_uuid) REFERENCES attribute_value (attribute_value_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
