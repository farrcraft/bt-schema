CREATE TABLE IF NOT EXISTS yeast_profile (
	yeast_profile_uuid varchar(36) not null,
	name varchar(200) not null,
	strain varchar(200) not null,
	yeast_lab_uuid varchar(36) default null,
	description varchar(2000) default null,
	yeast_type_uuid varchar(36) not null,
	yeast_form_uuid varchar(36) not null,
	yeast_flocculation_uuid varchar(36) not null,
	PRIMARY KEY (yeast_profile_uuid),
	UNIQUE KEY (strain, yeast_lab_uuid),
	FOREIGN KEY (yeast_type_uuid) REFERENCES yeast_type (yeast_type_uuid),
	FOREIGN KEY (yeast_form_uuid) REFERENCES yeast_form (yeast_form_uuid),
	FOREIGN KEY (yeast_flocculation_uuid) REFERENCES yeast_flocculation (yeast_flocculation_uuid),
	FOREIGN KEY (yeast_lab_uuid) REFERENCES yeast_lab (yeast_lab_uuid)
) ENGINE=InnoDB default CHARSET=utf8;
