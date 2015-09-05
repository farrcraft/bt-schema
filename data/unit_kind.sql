SELECT @metric := (SELECT measurement_system_uuid FROM measurement_system where name = 'Metric');
SELECT @imperial := (SELECT measurement_system_uuid FROM measurement_system where name = 'Imperial');
SELECT @us_units := (SELECT measurement_system_uuid FROM measurement_system where name = 'US');

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
