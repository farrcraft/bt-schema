-- a single ingredient in a purchase order
CREATE TABLE IF NOT EXISTS po_line_item (
	po_line_item_uuid varchar(36) not null,
	purchase_order_uuid varchar(36) not null,
	ingredient_uuid varchar(36) not null,
	price decimal(19,4) default null,
	amount decimal(19,4) default null,
	PRIMARY KEY (po_line_item_uuid),
	FOREIGN KEY (purchase_order_uuid) REFERENCES purchase_order (purchase_order_uuid),
	FOREIGN KEY (ingredient_uuid) REFERENCES ingredient (ingredient_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
