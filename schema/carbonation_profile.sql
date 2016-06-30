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
);
