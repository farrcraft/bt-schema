CREATE TABLE IF NOT EXISTS yeast (
	yeast_uuid varchar(36) not null,
	user_uuid varchar(36) not null,
	yeast_profile_uuid varchar(36) not null,
	lot_number varchar(100) default null,
	best_use_by_timestamp integer default null,
	culture_count integer default 0,
	PRIMARY KEY (yeast_uuid),
	FOREIGN KEY (yeast_profile_uuid) REFERENCES yeast_profile (yeast_profile_uuid),
	FOREIGN KEY (user_uuid) REFERENCES "user" (user_uuid)
);
