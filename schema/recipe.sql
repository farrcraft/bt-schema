-- top level table for recipes
-- recipe lineages allow recipes to be copied/cloned and altered
CREATE TABLE IF NOT EXISTS recipe (
	recipe_uuid varchar(36) not null,
	user_uuid varchar(36) not null,
	name varchar(200) not null,
	recipe_type_uuid varchar(36) not null,
	lineage_recipe_uuid varchar(36) default null,
	bjcp_style_uuid varchar(36) default null,
	date_created_timestamp integer not null,
	visibility text default null CHECK (visibility IN ('public', 'private')),
	PRIMARY KEY (recipe_uuid),
	FOREIGN KEY (user_uuid) REFERENCES "user" (user_uuid),
	FOREIGN KEY (recipe_type_uuid) REFERENCES recipe_type (recipe_type_uuid),
--	FOREIGN KEY (lineage_recipe_uuid) REFERENCES recipe (lineage_recipe_uuid),
	FOREIGN KEY (bjcp_style_uuid) REFERENCES bjcp_style (bjcp_style_uuid)
);
