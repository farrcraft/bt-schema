-- maps an attribute value to a bjcp style
CREATE TABLE IF NOT EXISTS bjcp_style_attribute_value_map (
	bjcp_style_attribute_value_map_uuid varchar(36) not null,
	bjcp_style_uuid varchar(36) not null,
	attribute_value_uuid varchar(36) not null,
	PRIMARY KEY(bjcp_style_attribute_value_map_uuid),
	FOREIGN KEY (bjcp_style_uuid) REFERENCES bjcp_style (bjcp_style_uuid),
	FOREIGN KEY (attribute_value_uuid) REFERENCES attribute_value (attribute_value_uuid)
);
