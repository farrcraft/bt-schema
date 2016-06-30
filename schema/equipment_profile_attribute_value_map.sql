-- equipment attribute value kinds:
-- equipment capacity (kettle volume / mash tun volume / etc)
-- mash tun weight, mash tun specific heat, top up water volume, 
-- equipment material (stainless/glass/plastic/etc)
-- trub / chiller loss (volume lost from boiler after transfer to fermentation vessel)
-- boil evaporation rate, boil time, lauter deadspace, kettle top up volume, hop utilization
CREATE TABLE IF NOT EXISTS equipment_profile_attribute_value_map (
	equipment_profile_attribute_value_map_uuid varchar(36) not null,
	equipment_profile_uuid varchar(36) not null,
	attribute_value_uuid varchar(36) not null,
	PRIMARY KEY (equipment_profile_attribute_value_map_uuid),
	UNIQUE (equipment_profile_uuid, attribute_value_uuid),
	FOREIGN KEY (equipment_profile_uuid) REFERENCES equipment_profile (equipment_profile_uuid),
	FOREIGN KEY (attribute_value_uuid) REFERENCES attribute_value (attribute_value_uuid)
);
