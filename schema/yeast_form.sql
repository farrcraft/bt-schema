-- liquid, dry, slant, culture
CREATE TABLE IF NOT EXISTS yeast_form (
	yeast_form_uuid varchar(36) not null,
	name varchar(50) not null,
	PRIMARY KEY (yeast_form_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB default CHARSET=utf8;
