-- boil, dry hop, mash, first wort, flameout, whirlpool, stand
CREATE TABLE IF NOT EXISTS hop_usage (
	hop_usage_uuid varchar(36) not null,
	name varchar(200) not null,
	PRIMARY KEY (hop_usage_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB default CHARSET=utf8;
