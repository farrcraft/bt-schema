-- definition of a piece of equipment
CREATE TABLE IF NOT EXISTS equipment_profile (
	equipment_profile_uuid varchar(36) not null,
	user_uuid varchar(36) not null,
	name varchar(200) not null,
	description varchar(255) default null,
	equipment_type_uuid varchar(36) not null,
	PRIMARY KEY (equipment_profile_uuid),
	FOREIGN KEY (equipment_type_uuid) REFERENCES equipment_type (equipment_type_uuid),
	FOREIGN KEY (user_uuid) REFERENCES "user" (user_uuid)
);
