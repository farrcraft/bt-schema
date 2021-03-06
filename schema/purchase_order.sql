-- used to group together all of the ingredients bought from a distributor
CREATE TABLE IF NOT EXISTS purchase_order (
	purchase_order_uuid varchar(36) not null,
	user_uuid varchar(36) not null,
	distributor_uuid varchar(36) not null,
	fullfilled smallint default 0,
	date_ordered_timestamp integer default null,
	date_shipped_timestamp integer default null,
	date_fullfilled_timestamp integer default null,
	shipping decimal(19,4) default null,
	sales_tax decimal(19,4) default null,
	PRIMARY KEY (purchase_order_uuid),
	FOREIGN KEY (user_uuid) REFERENCES "user" (user_uuid),
	FOREIGN KEY (distributor_uuid) REFERENCES distributor (distributor_uuid)
);
