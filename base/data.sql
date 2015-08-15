INSERT INTO role (role_uuid, name, description) VALUES
(UUID(), 'admin', 'Administrative Role');

INSERT INTO measurement_system (measurement_system_uuid, name) VALUES
(UUID(), 'US'),
(UUID(), 'Imperial'),
(UUID(), 'Metric');

SELECT @metric := (SELECT measurement_system_uuid FROM measurement_system where name = 'Metric');
SELECT @imperial := (SELECT measurement_system_uuid FROM measurement_system where name = 'Imperial');
SELECT @us_units := (SELECT measurement_system_uuid FROM measurement_system where name = 'US');

INSERT INTO unit_category (unit_category_uuid, name) VALUES 
(UUID(), 'temperature'),
(UUID(), 'weight'),
(UUID(), 'volume'),
(UUID(), 'time'),
(UUID(), 'specific gravity'),
(UUID(), 'pressure'),
(UUID(), 'specific heat');

SELECT @category_uuid := (SELECT unit_category_uuid FROM unit_category WHERE name = 'temperature');

INSERT INTO unit_kind (unit_kind_uuid, abbreviation, name, unit_category_uuid) VALUES 
(UUID(), 'C', 'celsius', @category_uuid),
(UUID(), 'F', 'fahrenheit', @category_uuid);

SELECT @category_uuid := (SELECT unit_category_uuid FROM unit_category WHERE name = 'weight');

INSERT INTO unit_kind (unit_kind_uuid, abbreviation, name, unit_category_uuid, measurement_system_uuid) VALUES 
(UUID(), 'g', 'gram', @category_uuid, @metric),
(UUID(), 'kg', 'kilogram', @category_uuid, @metric),
(UUID(), 'oz', 'ounce', @category_uuid, @imperial),
(UUID(), 'lb', 'pound', @category_uuid, @imperial);

SELECT @category_uuid := (SELECT unit_category_uuid FROM unit_category WHERE name = 'volume');

INSERT INTO unit_kind (unit_kind_uuid, abbreviation, name, unit_category_uuid, measurement_system_uuid) VALUES 
(UUID(), 'tsp', 'teaspoon', @category_uuid, @us_units),
(UUID(), 'tbsp', 'tablespoon', @category_uuid, @us_units),
(UUID(), 'oz', 'ounce', @category_uuid, @us_units),
(UUID(), 'pt', 'pint', @category_uuid, @imperial),
(UUID(), 'qt', 'quart', @category_uuid, @imperial),
(UUID(), 'mL', 'milliliter', @category_uuid, @metric),
(UUID(), 'L', 'liter', @category_uuid, @metric),
(UUID(), 'gal', 'gallon', @category_uuid, @imperial),
(UUID(), 'c', 'cup', @category_uuid, @us_units);

SELECT @category_uuid := (SELECT unit_category_uuid FROM unit_category WHERE name = 'specific heat');

INSERT INTO unit_kind (unit_kind_uuid, abbreviation, name, unit_category_uuid) VALUES 
(UUID(), 'J/K', 'joules per degree kelvin', @category_uuid),
(UUID(), 'cal/gC', 'calories per gram degree celcius', @category_uuid),
(UUID(), 'BTU/lbF', 'BTU per pound degree fahrenheit', @category_uuid);


INSERT INTO attribute_kind (attribute_kind_uuid, abbreviation, description, value_type) VALUES
(UUID(), 'abv', 'alcohol by volume', 'float'),
(UUID(), 'og', 'original gravity', 'float'),
(UUID(), 'fg', 'final gravity', 'float'),
(UUID(), 'sg', 'specific gravity', 'float'),
(UUID(), 'ppg', 'points per pound per gallon', 'float'),
(UUID(), 'vol', 'volume', 'float'),
(UUID(), 'wt', 'weight', 'float'),
(UUID(), NULL, 'specific heat', 'float'),
(UUID(), NULL, 'deadspace', 'float'),
(UUID(), NULL, 'boiloff', 'float'),
(UUID(), NULL, 'lossage', 'float');


INSERT INTO measurement_type (measurement_type_uuid, name) VALUES
(UUID(), 'mash'),
(UUID(), 'boil'),
(UUID(), 'fermentation');


INSERT INTO fermentable_type (fermentable_type_uuid, name) VALUES
(UUID(), 'grain'),
(UUID(), 'liquid extract'),
(UUID(), 'dry extract'),
(UUID(), 'sugar'),
(UUID(), 'adjunct');


INSERT INTO ingredient_type (ingredient_type_uuid, name) VALUES
(UUID(), 'grain'),
(UUID(), 'hop'),
(UUID(), 'yeast'),
(UUID(), 'herb'),
(UUID(), 'spice'),
(UUID(), 'fruit'),
(UUID(), 'fining'),
(UUID(), 'mineral'),
(UUID(), 'chemical'),
(UUID(), 'fermentable'),
(UUID(), 'adjunct'),
(UUID(), 'flavor');


INSERT INTO ingredient_usage (ingredient_usage_uuid, name) VALUES
(UUID(), 'boil'),
(UUID(), 'mash'),
(UUID(), 'fermentation'),
(UUID(), 'carbonation');


INSERT INTO recipe_type (recipe_type_uuid, name) VALUES
(UUID(), 'extract'),
(UUID(), 'partial mash'),
(UUID(), 'all grain');


INSERT INTO mash_step_type (mash_step_type_uuid, name) VALUES
(UUID(), 'infusion'),
(UUID(), 'temperature'),
(UUID(), 'decoction');


INSERT INTO equipment_usage (equipment_usage_uuid, name) VALUES
(UUID(), 'boil'),
(UUID(), 'mash'),
(UUID(), 'fermentation'),
(UUID(), 'serving'),
(UUID(), 'lauter');


INSERT INTO equipment_type (equipment_type_uuid, name) VALUES
(UUID(), 'keg'),
(UUID(), 'kettle'),
(UUID(), 'bucket'),
(UUID(), 'plastic bottle'),
(UUID(), 'round cooler'),
(UUID(), 'carboy'),
(UUID(), 'rectangular cooler'),
(UUID(), 'keggle'),
(UUID(), 'conical');


INSERT INTO hop_type (hop_type_uuid, name) VALUES
(UUID(), 'bittering'),
(UUID(), 'aroma'),
(UUID(), 'flavor');


INSERT INTO hop_usage (hop_usage_uuid, name) VALUES
(UUID(), 'boil'),
(UUID(), 'dry hop'),
(UUID(), 'mash'),
(UUID(), 'first wort'), 
(UUID(), 'flameout'),
(UUID(), 'whirlpool'),
(UUID(), 'stand'),
(UUID(), 'hopback');


INSERT INTO hop_form (hop_form_uuid, name) VALUES
(UUID(), 'pellet'),
(UUID(), 'plug'),
(UUID(), 'leaf'),
(UUID(), 'wet');


INSERT INTO water_source (water_source_uuid, name) VALUES
(UUID(), 'tap'),
(UUID(), 'filtered'),
(UUID(), 'reverse osmosis'),
(UUID(), 'spring'),
(UUID(), 'distilled');


INSERT INTO yeast_type (yeast_type_uuid, name) VALUES
(UUID(), 'ale'),
(UUID(), 'lager'),
(UUID(), 'wheat'),
(UUID(), 'wine'),
(UUID(), 'champagne'),
(UUID(), 'mead');


INSERT INTO yeast_form (yeast_form_uuid, name) VALUES
(UUID(), 'liquid'),
(UUID(), 'dry'),
(UUID(), 'slant'),
(UUID(), 'culture');


INSERT INTO yeast_flocculation (yeast_flocculation_uuid, name) VALUES
(UUID(), 'low'),
(UUID(), 'medium'),
(UUID(), 'high'),
(UUID(), 'very high');

