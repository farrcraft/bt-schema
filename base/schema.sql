CREATE DATABASE IF NOT EXISTS brewtheory CHARACTER SET utf8;
use brewtheory;


CREATE TABLE IF NOT EXISTS measurement_system (
	measurement_system_uuid varchar(36) not null,
	name varchar(50) not null,
	PRIMARY KEY (measurement_system_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS user (
	user_uuid varchar(36) not null,
	email varchar(200) not null,
	first_name varchar(200) default null,
	last_name varchar(200) default null,
	password char(200) not null,
	salt char(200) not null,
	date_created_timestamp int(11) unsigned not null,
	date_updated_timestamp int(11) unsigned not null,
	deleted tinyint(4) unsigned not null default 0,
	measurement_system_uuid varchar(36) default null,
	PRIMARY KEY (user_uuid),
	FOREIGN KEY (measurement_system_uuid) REFERENCES measurement_system (measurement_system_uuid),
	UNIQUE KEY (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS role (
	role_uuid varchar(36) not null,
	name varchar(50) not null,
	description varchar(255) default null,
	PRIMARY KEY (role_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS user_role (
	user_role_uuid varchar(36) not null,
	user_uuid varchar(36) not null,
	role_uuid varchar(36) not null,
	PRIMARY KEY (user_role_uuid),
	FOREIGN KEY (user_uuid) REFERENCES user (user_uuid),
	FOREIGN KEY (role_uuid) REFERENCES role (role_uuid),
	UNIQUE KEY (user_uuid, role_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- An API consumer (e.g. the brewtheory website frontend)
CREATE TABLE IF NOT EXISTS oauth_client (
	oauth_client_uuid varchar(36) not null,
	name varchar(100) not null,
	secret varchar(80) not null,
	PRIMARY KEY (oauth_client_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS oauth_access_token (
	oauth_access_token_uuid varchar(36) not null,
	token varchar(40) not null,
	oauth_client_uuid varchar(36) not null,
	user_uuid varchar(36) not null,
	expiration_timestamp int(11) unsigned default null,
	PRIMARY KEY (oauth_access_token_uuid),
	FOREIGN KEY (user_uuid) REFERENCES user (user_uuid),
	FOREIGN KEY (oauth_client_uuid) REFERENCES oauth_client (oauth_client_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- temperature, weight, volume, time, specific gravity, pressure
CREATE TABLE IF NOT EXISTS unit_category (
	unit_category_uuid varchar(36) not null,
	name varchar(50) not null,
	PRIMARY KEY (unit_category_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- points, ppg, kPa, brix, kg, liters, celsius, etc
-- weight units: kg, g, oz, lb
-- volume units: tsp, tbsp, oz, cup, pint, quart, mL, L
-- temperature: F, C
-- time: min, hour, day, week
-- color: srm, ebc, L
-- specific gravity: sg, plato
CREATE TABLE IF NOT EXISTS unit_kind (
	unit_kind_uuid varchar(36) not null,
	abbreviation varchar(20),
	name varchar(100) not null,
	unit_category_uuid varchar(36) not null,
	measurement_system_uuid varchar(36) default null,
	state enum ('solid', 'liquid') default null,
	PRIMARY KEY (unit_kind_uuid),
	FOREIGN KEY (unit_category_uuid) REFERENCES unit_category (unit_category_uuid),
	FOREIGN KEY (measurement_system_uuid) REFERENCES measurement_system (measurement_system_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- units of different types can be converted between
CREATE TABLE IF NOT EXISTS unit_conversion (
	unit_conversion_uuid varchar(36) not null,
	source_unit_kind_uuid varchar(36) not null,
	target_unit_kind_uuid varchar(36) not null,
	factor varchar(255) not null,
	PRIMARY KEY (unit_conversion_uuid),
	KEY (source_unit_kind_uuid),
	KEY (target_unit_kind_uuid),
	FOREIGN KEY (source_unit_kind_uuid) REFERENCES unit_kind (unit_kind_uuid),
	FOREIGN KEY (target_unit_kind_uuid) REFERENCES unit_kind (unit_kind_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- a generic attribute descriptor. these include things like abv, og, fg, etc.
CREATE TABLE IF NOT EXISTS attribute_kind (
	attribute_kind_uuid varchar(36) not null,
	abbreviation varchar(10) default null,
	description varchar(255) not null,
	value_type enum ('string', 'integer', 'boolean', 'float') not null,
	PRIMARY KEY(attribute_kind_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- a single attribute value as it applies to a particular product
CREATE TABLE IF NOT EXISTS attribute_value (
	attribute_value_uuid varchar(36) not null,
	attribute_kind_uuid varchar(36) not null,
	t_value varchar(2000) default null,
	n_value int(10) default null,
	b_value tinyint(1) default null,
	f_value decimal(19,4) default null,
	unit_kind_uuid varchar(36) default null,
	range_type enum ('minimum', 'maximum') default null,
	PRIMARY KEY(attribute_value_uuid),
	FOREIGN KEY (attribute_kind_uuid) REFERENCES attribute_kind (attribute_kind_uuid),
	FOREIGN KEY (unit_kind_uuid) REFERENCES unit_kind (unit_kind_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- defines where in the process that the measurement was taken
-- e.g. mash, boil, fermentation
CREATE TABLE IF NOT EXISTS measurement_type (
	measurement_type_uuid varchar(36) not null,
	name varchar(100) not null,
	PRIMARY KEY (measurement_type_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- styles are grouped into categories
-- styles are defined by a combination of descriptive & statistical attributes (e.g. value ranges)
CREATE TABLE IF NOT EXISTS bjcp_style (
	bjcp_style_uuid varchar(36) not null,
	name varchar(100) not null,
	category varchar(5),
	parent_bjcp_style_uuid varchar(36) default null,
	PRIMARY KEY (bjcp_style_uuid),
	UNIQUE KEY (category),
	FOREIGN KEY (parent_bjcp_style_uuid) REFERENCES bjcp_style (bjcp_style_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- maps an attribute value to a bjcp style
CREATE TABLE IF NOT EXISTS bjcp_style_attribute_value_map (
	bjcp_style_attribute_value_map_uuid varchar(36) not null,
	bjcp_style_uuid varchar(36) not null,
	attribute_value_uuid varchar(36) not null,
	PRIMARY KEY(bjcp_style_attribute_value_map_uuid),
	FOREIGN KEY (bjcp_style_uuid) REFERENCES bjcp_style (bjcp_style_uuid),
	FOREIGN KEY (attribute_value_uuid) REFERENCES attribute_value (attribute_value_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- LHBS, online vendor, etc where ingredients come from
CREATE TABLE IF NOT EXISTS distributor (
	distributor_uuid varchar(36) not null,
	name varchar(200) not null,
	url varchar(500) default null,
	PRIMARY KEY (distributor_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


SOURCE hops.sql;
SOURCE yeast.sql;


-- a generic vendor (name of any company that makes an ingredient)
-- can also specifically be a maltster
CREATE TABLE IF NOT EXISTS vendor (
	vendor_uuid varchar(36) not null,
	name varchar(200) not null,
	maltster tinyint(1) not null default 0,
	PRIMARY KEY (vendor_uuid)
) ENGINE=InnoDB default CHARSET=utf8;


-- grain, sugar, (liquid) extract, dry extract, adjunct
CREATE TABLE IF NOT EXISTS fermentable_type (
	fermentable_type_uuid varchar(36) not null,
	name varchar(50) not null,
	PRIMARY KEY (fermentable_type_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- common properties of fermentable ingredients (grains, sugars, honeys, fruits, etc)
CREATE TABLE IF NOT EXISTS fermentable_profile (
	fermentable_profile_uuid varchar(36) not null,
	name varchar(200) not null,
	description varchar(1000) default null,
	origin varchar(50) default null,
	fermentable_type_uuid varchar(36) not null,
	vendor_uuid varchar(36) default null,
	PRIMARY KEY (fermentable_profile_uuid),
	FOREIGN KEY (fermentable_type_uuid) REFERENCES fermentable_type (fermentable_type_uuid),
	FOREIGN KEY (vendor_uuid) REFERENCES vendor (vendor_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- fermentable attribute value kinds:
-- color (lovibond or srm), yield (percent dry yield or raw yield by weight), moisture (%),
-- diastatic power (lintner), coarse/fine yield delta (grains & adjuncts), protein (%),
-- post-boil (bool), recommend mash (bool), max in batch (% by weight)
CREATE TABLE IF NOT EXISTS fermentable_attribute_value_map (
	fermentable_attribute_value_map_uuid varchar(36) not null,
	fermentable_profile_uuid varchar(36) not null,
	attribute_value_uuid varchar(36) not null,
	PRIMARY KEY (fermentable_attribute_value_map_uuid),
	UNIQUE KEY (fermentable_profile_uuid, attribute_value_uuid),
	FOREIGN KEY (fermentable_profile_uuid) REFERENCES fermentable_profile (fermentable_profile_uuid),
	FOREIGN KEY (attribute_value_uuid) REFERENCES attribute_value (attribute_value_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- e.g. grain, hop, yeast, herb, spice, fruit, fining, mineral, chemical, fermentable, adjunct, flavor
CREATE TABLE IF NOT EXISTS ingredient_type (
	ingredient_type_uuid varchar(36) not null,
	name varchar(100) not null,
	PRIMARY KEY (ingredient_type_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- boil, mash, primary, secondary, bottling
CREATE TABLE IF NOT EXISTS ingredient_usage (
	ingredient_usage_uuid varchar(36) not null,
	name varchar(100) not null,
	PRIMARY KEY (ingredient_usage_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS ingredient (
	ingredient_uuid varchar(36) not null,
	ingredient_type_uuid varchar(36) not null,
	name varchar(255) not null,
	description varchar(2000) default null,
	fermentable_profile_uuid varchar(36) default null,
	hop_uuid varchar(36) default null,
	yeast_uuid varchar(36) default null,
	distributor_uuid varchar(36) default null,
	user_uuid varchar(36) not null,
	PRIMARY KEY (ingredient_uuid),
	FOREIGN KEY (ingredient_type_uuid) REFERENCES ingredient_type (ingredient_type_uuid),
	FOREIGN KEY (fermentable_profile_uuid) REFERENCES fermentable_profile (fermentable_profile_uuid),
	FOREIGN KEY (hop_uuid) REFERENCES hop (hop_uuid),
	FOREIGN KEY (yeast_uuid) REFERENCES yeast (yeast_uuid),
	FOREIGN KEY (distributor_uuid) REFERENCES distributor (distributor_uuid),
	FOREIGN KEY (user_uuid) REFERENCES user (user_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- extract, partial mash, all grain
CREATE TABLE IF NOT EXISTS recipe_type (
	recipe_type_uuid varchar(36) not null,
	name varchar(50) not null,
	PRIMARY KEY (recipe_type_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- top level table for recipes
-- recipe lineages allow recipes to be copied/cloned and altered
CREATE TABLE IF NOT EXISTS recipe (
	recipe_uuid varchar(36) not null,
	user_uuid varchar(36) not null,
	name varchar(200) not null,
	recipe_type_uuid varchar(36) not null,
	lineage_recipe_uuid varchar(36) default null,
	bjcp_style_uuid varchar(36) default null,
	date_created_timestamp int(11) unsigned not null,
	visibility enum ('public', 'private') default null,
	PRIMARY KEY (recipe_uuid),
	FOREIGN KEY (user_uuid) REFERENCES user (user_uuid),
	FOREIGN KEY (recipe_type_uuid) REFERENCES recipe_type (recipe_type_uuid),
--	FOREIGN KEY (lineage_recipe_uuid) REFERENCES recipe (lineage_recipe_uuid),
	FOREIGN KEY (bjcp_style_uuid) REFERENCES bjcp_style (bjcp_style_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- recipes aren't brewed directly, instead a batch of a recipe is brewed
-- this allows multiple batches of the same recipe to be brewed
-- recipe represents target values while the batch represents actual collected data points
CREATE TABLE IF NOT EXISTS batch (
	batch_uuid varchar(36) not null,
	recipe_uuid varchar(36) not null,
	date_brewed_timestamp int(11) unsigned not null,
	name varchar(50) not null,
	PRIMARY KEY (batch_uuid),
	FOREIGN KEY (recipe_uuid) REFERENCES recipe (recipe_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- batch attribute value kinds
-- brewhouse efficiency, mash efficiency, actual og, actual fg
-- actual boil size (pre-boil volume), actual batch size (post-boil pre-fermentation volume)
CREATE TABLE IF NOT EXISTS batch_attribute_value_map (
	batch_attribute_value_map_uuid varchar(36) not null,
	batch_uuid varchar(36) not null,
	attribute_value_uuid varchar(36) not null,
	PRIMARY KEY (batch_attribute_value_map_uuid),
	UNIQUE KEY (batch_uuid, attribute_value_uuid),
	FOREIGN KEY (batch_uuid) REFERENCES batch (batch_uuid),
	FOREIGN KEY (attribute_value_uuid) REFERENCES attribute_value (attribute_value_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- all measurements taken during the brewing process are recorded here
CREATE TABLE IF NOT EXISTS measurement (
	measurement_uuid varchar(36) not null,
	attribute_value_uuid varchar(36) not null,
	measurement_type_uuid varchar(36) not null,
	user_uuid varchar(36) not null,
	batch_uuid varchar(36) default null,
	date_measured_timestamp int(11) unsigned not null,
	PRIMARY KEY (measurement_uuid),
	FOREIGN KEY (attribute_value_uuid) REFERENCES attribute_value (attribute_value_uuid),
	FOREIGN KEY (measurement_type_uuid) REFERENCES measurement_type (measurement_type_uuid),
	FOREIGN KEY (user_uuid) REFERENCES user (user_uuid),
	FOREIGN KEY (batch_uuid) REFERENCES batch (batch_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- recipe attribute value kinds
-- brewhouse efficiency, mash efficiency, target og, target fg
-- boil size (pre-boil volume), batch size (post-boil pre-fermentation volume)
CREATE TABLE IF NOT EXISTS recipe_attribute_value_map (
	recipe_attribute_value_map_uuid varchar(36) not null,
	recipe_uuid varchar(36) not null,
	attribute_value_uuid varchar(36) not null,
	PRIMARY KEY (recipe_attribute_value_map_uuid),
	UNIQUE KEY (recipe_uuid, attribute_value_uuid),
	FOREIGN KEY (recipe_uuid) REFERENCES recipe (recipe_uuid),
	FOREIGN KEY (attribute_value_uuid) REFERENCES attribute_value (attribute_value_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS grain_bill (
	grain_bill_uuid varchar(36) not null,
	recipe_uuid varchar(36) not null,
	ingredient_uuid varchar(36) not null,
	unit_kind_uuid varchar(36) not null,
	amount decimal(19,4) default 0,
	PRIMARY KEY (grain_bill_uuid),
	FOREIGN KEY (recipe_uuid) REFERENCES recipe (recipe_uuid),
	FOREIGN KEY (unit_kind_uuid) REFERENCES unit_kind (unit_kind_uuid),
	FOREIGN KEY (ingredient_uuid) REFERENCES ingredient (ingredient_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- specifies amount of time to boil
CREATE TABLE IF NOT EXISTS boil_schedule (
	boil_schedule_uuid varchar(36) not null,
	recipe_uuid varchar(36) not null,
	duration int(10) not null default 0,
	PRIMARY KEY (boil_schedule_uuid),
	FOREIGN KEY (recipe_uuid) REFERENCES recipe (recipe_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- an individual step during the boil
-- e.g. ingredient additions (hops, finings, etc)
CREATE TABLE IF NOT EXISTS boil_step (
	boil_step_uuid varchar(36) not null,
	boil_schedule_uuid varchar(36) not null,
	step_time int(11) not null,
	name varchar(255) default null,
	description varchar(1500) default null,
	ingredient_uuid varchar(36) default null,
	ingredient_amount decimal(19,4) default null,
	PRIMARY KEY (boil_step_uuid),
	FOREIGN KEY (boil_schedule_uuid) REFERENCES boil_schedule (boil_schedule_uuid),
	FOREIGN KEY (ingredient_uuid) REFERENCES ingredient (ingredient_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS mash_schedule (
	mash_schedule_uuid varchar(36) not null,
	recipe_uuid varchar(36) not null,
	name varchar(255) default null,
	description varchar(2000) default null,
	duration int(11) not null,
	PRIMARY KEY (mash_schedule_uuid),
	FOREIGN KEY (recipe_uuid) REFERENCES recipe (recipe_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- mash profile attribute value kinds:
-- grain temperature (prior to mash), tun temperature (e.g. if tun is preheated), sparge temperature,
-- sparge ph, tun weight, tun specific heat (calories per gram-degree C)
CREATE TABLE IF NOT EXISTS mash_schedule_attribute_value_map (
	mash_schedule_attribute_value_map_uuid varchar(36) not null,
	mash_schedule_uuid varchar(36) not null,
	attribute_value_uuid varchar(36) not null,
	PRIMARY KEY (mash_schedule_attribute_value_map_uuid),
	UNIQUE KEY (mash_schedule_uuid, attribute_value_uuid),
	FOREIGN KEY (mash_schedule_uuid) REFERENCES mash_schedule (mash_schedule_uuid),
	FOREIGN KEY (attribute_value_uuid) REFERENCES attribute_value (attribute_value_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- infusion, temperature, decoction
CREATE TABLE IF NOT EXISTS mash_step_type (
	mash_step_type_uuid varchar(36) not null,
	name varchar(36) not null,
	PRIMARY KEY (mash_step_type_uuid),
	UNIQUE KEY (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS mash_step (
	mash_step_uuid varchar(36) not null,
	mash_schedule_uuid varchar(36) not null,
	name varchar (255),
	step_order int(11) not null,
	mash_step_type_uuid varchar(36) not null,
	duration int(11) not null,
	ingredient_uuid varchar(36) default null,
	ingredient_amount decimal(19,4) default null,
	PRIMARY KEY (mash_step_uuid),
	FOREIGN KEY (mash_schedule_uuid) REFERENCES mash_schedule (mash_schedule_uuid),
	FOREIGN KEY (mash_step_type_uuid) REFERENCES mash_step_type (mash_step_type_uuid),
	FOREIGN KEY (ingredient_uuid) REFERENCES ingredient (ingredient_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- mash step attribute value kinds:
-- infusion amount, step temperature, step time, ramp time, end (falloff) temperature,
-- strike temperature
CREATE TABLE IF NOT EXISTS mash_step_attribute_value_map (
	mash_step_attribute_value_map_uuid varchar(36) not null,
	mash_step_uuid varchar(36) not null,
	attribute_value_uuid varchar(36) not null,
	PRIMARY KEY (mash_step_attribute_value_map_uuid),
	UNIQUE KEY (mash_step_uuid, attribute_value_uuid),
	FOREIGN KEY (mash_step_uuid) REFERENCES mash_step (mash_step_uuid),
	FOREIGN KEY (attribute_value_uuid) REFERENCES attribute_value (attribute_value_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS fermentation_schedule (
	fermentation_schedule_uuid varchar(36) not null,
	recipe_uuid varchar(36) not null,
	PRIMARY KEY (fermentation_schedule_uuid),
	FOREIGN KEY (recipe_uuid) REFERENCES recipe (recipe_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- defines the various fermentation steps
-- this captures basic steps, any additions during fermentation (e.g. dry hopping), or temperature
-- changes
CREATE TABLE IF NOT EXISTS fermentation_step (
	fermentation_step_uuid varchar(36) not null,
	fermentation_schedule_uuid varchar(36) not null,
	step_order int(11) not null,
	stage int(11) not null,
	temperature decimal(19,4) default null,
	duration int(11) not null,
	ingredient_uuid varchar(36) default null,
	ingredient_amount decimal(19,4),
	PRIMARY KEY (fermentation_step_uuid),
	FOREIGN KEY (fermentation_schedule_uuid) REFERENCES fermentation_schedule (fermentation_schedule_uuid),
	FOREIGN KEY (ingredient_uuid) REFERENCES ingredient (ingredient_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- fermentation step attribute value kinds
-- temperature, duration
CREATE TABLE IF NOT EXISTS fermentation_step_attribute_value_map (
	fermentation_step_attribute_value_map_uuid varchar(36) not null,
	fermentation_step_uuid varchar(36) not null,
	attribute_value_uuid varchar(36) not null,
	PRIMARY KEY (fermentation_step_attribute_value_map_uuid),
	UNIQUE KEY (fermentation_step_uuid, attribute_value_uuid),
	FOREIGN KEY (fermentation_step_uuid) REFERENCES fermentation_step (fermentation_step_uuid),
	FOREIGN KEY (attribute_value_uuid) REFERENCES attribute_value (attribute_value_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- force carb, condition
-- co2 volumes
-- priming sugar type (honey, corn sugar, etc)
-- carbonation temperature
-- priming sugar amount
-- keg priming factor (sugar amount multiplier when conditioning in keg vs bottles)
-- priming sugar conversion (multiplier for equivalent amount of corn sugar)
CREATE TABLE IF NOT EXISTS carbonation_profile (
	carbonation_profile_uuid varchar(36) not null,
	recipe_uuid varchar(36) not null,
	PRIMARY KEY (carbonation_profile_uuid),
	FOREIGN KEY (recipe_uuid) REFERENCES recipe (recipe_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


SOURCE water.sql;


-- used to group together all of the ingredients bought from a distributor
CREATE TABLE IF NOT EXISTS purchase_order (
	purchase_order_uuid varchar(36) not null,
	user_uuid varchar(36) not null,
	distributor_uuid varchar(36) not null,
	fullfilled tinyint(1) default 0,
	date_ordered_timestamp int(11) unsigned default null,
	date_shipped_timestamp int(11) unsigned default null,
	date_fullfilled_timestamp int(11) unsigned default null,
	shipping decimal(19,4) default null,
	sales_tax decimal(19,4) default null,
	PRIMARY KEY (purchase_order_uuid),
	FOREIGN KEY (user_uuid) REFERENCES user (user_uuid),
	FOREIGN KEY (distributor_uuid) REFERENCES distributor (distributor_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- a single ingredient in a purchase order
CREATE TABLE IF NOT EXISTS po_line_item (
	po_line_item_uuid varchar(36) not null,
	purchase_order_uuid varchar(36) not null,
	ingredient_uuid varchar(36) not null,
	price decimal(19,4) default null,
	amount decimal(19,4) default null,
	PRIMARY KEY (po_line_item_uuid),
	FOREIGN KEY (purchase_order_uuid) REFERENCES purchase_order (purchase_order_uuid),
	FOREIGN KEY (ingredient_uuid) REFERENCES ingredient (ingredient_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS inventory (
	inventory_uuid varchar(36) not null,
	user_uuid varchar(36) not null,
	PRIMARY KEY (inventory_uuid),
	FOREIGN KEY (user_uuid) REFERENCES user (user_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- current inventory level of an ingredient
CREATE TABLE IF NOT EXISTS inventory_item (
	inventory_item_uuid varchar(36) not null,
	inventory_uuid varchar(36) not null,
	ingredient_uuid varchar(36) not null,
	amount decimal(19,4),
	PRIMARY KEY (inventory_item_uuid),
	FOREIGN KEY (ingredient_uuid) REFERENCES ingredient (ingredient_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


SOURCE equipment.sql

SOURCE data.sql;

