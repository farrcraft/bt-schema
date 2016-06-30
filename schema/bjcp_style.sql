-- styles are grouped into categories
-- styles are defined by a combination of descriptive & statistical attributes (e.g. value ranges)
CREATE TABLE IF NOT EXISTS bjcp_style (
	bjcp_style_uuid varchar(36) not null,
	name varchar(100) not null,
	category varchar(5),
	parent_bjcp_style_uuid varchar(36) default null,
	PRIMARY KEY (bjcp_style_uuid),
	UNIQUE (category),
	FOREIGN KEY (parent_bjcp_style_uuid) REFERENCES bjcp_style (bjcp_style_uuid)
);
