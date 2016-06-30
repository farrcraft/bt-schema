CREATE TABLE IF NOT EXISTS yeast_lab (
	yeast_lab_uuid varchar(36) not null,
	name varchar(200) not null,
	PRIMARY KEY (yeast_lab_uuid),
	UNIQUE (name)
);
