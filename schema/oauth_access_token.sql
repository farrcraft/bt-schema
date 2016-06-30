CREATE TABLE IF NOT EXISTS oauth_access_token (
	oauth_access_token_uuid varchar(36) not null,
	token varchar(40) not null,
	oauth_client_uuid varchar(36) not null,
	user_uuid varchar(36) not null,
	expiration_timestamp integer default null,
	PRIMARY KEY (oauth_access_token_uuid),
	FOREIGN KEY (user_uuid) REFERENCES "user" (user_uuid),
	FOREIGN KEY (oauth_client_uuid) REFERENCES oauth_client (oauth_client_uuid)
);
