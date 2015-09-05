-- a generic attribute descriptor. these include things like abv, og, fg, etc.
CREATE TABLE IF NOT EXISTS attribute_kind (
	attribute_kind_uuid varchar(36) not null,
	abbreviation varchar(10) default null,
	description varchar(255) not null,
	value_type enum ('string', 'integer', 'boolean', 'float') not null,
	PRIMARY KEY(attribute_kind_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
