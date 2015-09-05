-- LHBS, online vendor, etc where ingredients come from
CREATE TABLE IF NOT EXISTS distributor (
	distributor_uuid varchar(36) not null,
	name varchar(200) not null,
	url varchar(500) default null,
	PRIMARY KEY (distributor_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
