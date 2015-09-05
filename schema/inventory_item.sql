-- current inventory level of an ingredient
CREATE TABLE IF NOT EXISTS inventory_item (
	inventory_item_uuid varchar(36) not null,
	inventory_uuid varchar(36) not null,
	ingredient_uuid varchar(36) not null,
	amount decimal(19,4),
	PRIMARY KEY (inventory_item_uuid),
	FOREIGN KEY (inventory_uuid) REFERENCES inventory (inventory_uuid),
	FOREIGN KEY (ingredient_uuid) REFERENCES ingredient (ingredient_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
