-- recipes aren't brewed directly, instead a batch of a recipe is brewed
-- this allows multiple batches of the same recipe to be brewed
-- recipe represents target values while the batch represents actual collected data points
CREATE TABLE IF NOT EXISTS batch (
	batch_uuid varchar(36) not null,
	recipe_uuid varchar(36) not null,
	date_brewed_timestamp int(11) unsigned not null,
	name varchar(50) not null,
	PRIMARY KEY (batch_uuid),
	FOREIGN KEY (recipe_uuid) REFERENCES recipe (recipe_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
