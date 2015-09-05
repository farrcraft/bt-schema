-- a generic vendor (name of any company that makes an ingredient)
-- can also specifically be a maltster
CREATE TABLE IF NOT EXISTS vendor (
	vendor_uuid varchar(36) not null,
	name varchar(200) not null,
	maltster tinyint(1) not null default 0,
	PRIMARY KEY (vendor_uuid)
) ENGINE=InnoDB default CHARSET=utf8;
