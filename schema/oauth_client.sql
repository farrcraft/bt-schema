-- An API consumer (e.g. the brewtheory website frontend)
CREATE TABLE IF NOT EXISTS oauth_client (
	oauth_client_uuid varchar(36) not null,
	name varchar(100) not null,
	secret varchar(80) not null,
	PRIMARY KEY (oauth_client_uuid)
);
