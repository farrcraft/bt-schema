-- an actual hop instance as bought from a distributor and used in a recipe
CREATE TABLE IF NOT EXISTS hop (
	hop_uuid varchar(36) not null,
	hop_profile_uuid varchar(36) not null,
	user_uuid varchar(36) not null,
	season int(11) unsigned default null,
	distributor_uuid varchar(36) default null,
	hop_form_uuid varchar(36) not null,
	PRIMARY KEY (hop_uuid),
	FOREIGN KEY (hop_form_uuid) REFERENCES hop_form (hop_form_uuid),
	FOREIGN KEY (distributor_uuid) REFERENCES distributor (distributor_uuid),
	FOREIGN KEY (hop_profile_uuid) REFERENCES hop_profile (hop_profile_uuid),
	FOREIGN KEY (user_uuid) REFERENCES user (user_uuid)
) ENGINE=InnoDB default CHARSET=utf8;
