-- map of yeast to recommended bjcp styles
CREATE TABLE IF NOT EXISTS yeast_style (
	yeast_style_uuid varchar(36) not null,
	yeast_profile_uuid varchar(36) not null,
	bjcp_style_uuid varchar(36) not null,
	PRIMARY KEY (yeast_style_uuid),
	UNIQUE KEY (yeast_profile_uuid, bjcp_style_uuid),
	FOREIGN KEY (yeast_profile_uuid) REFERENCES yeast_profile (yeast_profile_uuid),
	FOREIGN KEY (bjcp_style_uuid) REFERENCES bjcp_style (bjcp_style_uuid)
) ENGINE=InnoDB default CHARSET=utf8;
