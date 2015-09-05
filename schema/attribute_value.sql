-- a single attribute value as it applies to a particular product
CREATE TABLE IF NOT EXISTS attribute_value (
	attribute_value_uuid varchar(36) not null,
	attribute_kind_uuid varchar(36) not null,
	t_value varchar(2000) default null,
	n_value int(10) default null,
	b_value tinyint(1) default null,
	f_value decimal(19,4) default null,
	unit_kind_uuid varchar(36) default null,
	range_type enum ('minimum', 'maximum') default null,
	PRIMARY KEY(attribute_value_uuid),
	FOREIGN KEY (attribute_kind_uuid) REFERENCES attribute_kind (attribute_kind_uuid),
	FOREIGN KEY (unit_kind_uuid) REFERENCES unit_kind (unit_kind_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
