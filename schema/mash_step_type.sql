-- infusion, temperature, decoction
CREATE TABLE IF NOT EXISTS mash_step_type (
	mash_step_type_uuid varchar(36) not null,
	name varchar(36) not null,
	PRIMARY KEY (mash_step_type_uuid),
	UNIQUE (name)
);
