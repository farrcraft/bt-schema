-- batch attribute value kinds
-- brewhouse efficiency, mash efficiency, actual og, actual fg
-- actual boil size (pre-boil volume), actual batch size (post-boil pre-fermentation volume)
CREATE TABLE IF NOT EXISTS batch_attribute_value_map (
	batch_attribute_value_map_uuid varchar(36) not null,
	batch_uuid varchar(36) not null,
	attribute_value_uuid varchar(36) not null,
	PRIMARY KEY (batch_attribute_value_map_uuid),
	UNIQUE KEY (batch_uuid, attribute_value_uuid),
	FOREIGN KEY (batch_uuid) REFERENCES batch (batch_uuid),
	FOREIGN KEY (attribute_value_uuid) REFERENCES attribute_value (attribute_value_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
