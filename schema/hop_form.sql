-- pellet, plug, leaf, wet
CREATE TABLE IF NOT EXISTS hop_form (
	hop_form_uuid varchar(36) not null,
	name varchar(50) not null,
	PRIMARY KEY (hop_form_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB default CHARSET=utf8;
