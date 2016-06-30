WITH category_uuid AS (SELECT unit_category_uuid FROM unit_category WHERE name = 'temperature')
INSERT INTO unit_kind (unit_kind_uuid, abbreviation, name, unit_category_uuid) VALUES 
(uuid_generate_v4(), 'C', 'celsius', (SELECT unit_category_uuid FROM category_uuid)),
(uuid_generate_v4(), 'F', 'fahrenheit', (SELECT unit_category_uuid FROM category_uuid));

WITH metric AS (SELECT measurement_system_uuid FROM measurement_system where name = 'Metric'),
imperial AS (SELECT measurement_system_uuid FROM measurement_system where name = 'Imperial'),
category_uuid AS (SELECT unit_category_uuid FROM unit_category WHERE name = 'weight')
INSERT INTO unit_kind (unit_kind_uuid, abbreviation, name, unit_category_uuid, measurement_system_uuid) VALUES 
(uuid_generate_v4(), 'g', 'gram', (SELECT unit_category_uuid FROM category_uuid), (SELECT measurement_system_uuid FROM metric)),
(uuid_generate_v4(), 'kg', 'kilogram', (SELECT unit_category_uuid FROM category_uuid), (SELECT measurement_system_uuid FROM metric)),
(uuid_generate_v4(), 'oz', 'ounce', (SELECT unit_category_uuid FROM category_uuid), (SELECT measurement_system_uuid FROM imperial)),
(uuid_generate_v4(), 'lb', 'pound', (SELECT unit_category_uuid FROM category_uuid), (SELECT measurement_system_uuid FROM imperial));

WITH metric AS (SELECT measurement_system_uuid FROM measurement_system where name = 'Metric'),
imperial AS (SELECT measurement_system_uuid FROM measurement_system where name = 'Imperial'),
us_units AS (SELECT measurement_system_uuid FROM measurement_system where name = 'US'),
category_uuid AS (SELECT unit_category_uuid FROM unit_category WHERE name = 'volume')
INSERT INTO unit_kind (unit_kind_uuid, abbreviation, name, unit_category_uuid, measurement_system_uuid) VALUES 
(uuid_generate_v4(), 'tsp', 'teaspoon', (SELECT unit_category_uuid FROM category_uuid), (SELECT measurement_system_uuid FROM us_units)),
(uuid_generate_v4(), 'tbsp', 'tablespoon', (SELECT unit_category_uuid FROM category_uuid), (SELECT measurement_system_uuid FROM us_units)),
(uuid_generate_v4(), 'oz', 'ounce', (SELECT unit_category_uuid FROM category_uuid), (SELECT measurement_system_uuid FROM us_units)),
(uuid_generate_v4(), 'pt', 'pint', (SELECT unit_category_uuid FROM category_uuid), (SELECT measurement_system_uuid FROM imperial)),
(uuid_generate_v4(), 'qt', 'quart', (SELECT unit_category_uuid FROM category_uuid), (SELECT measurement_system_uuid FROM imperial)),
(uuid_generate_v4(), 'mL', 'milliliter', (SELECT unit_category_uuid FROM category_uuid), (SELECT measurement_system_uuid FROM metric)),
(uuid_generate_v4(), 'L', 'liter', (SELECT unit_category_uuid FROM category_uuid), (SELECT measurement_system_uuid FROM metric)),
(uuid_generate_v4(), 'gal', 'gallon', (SELECT unit_category_uuid FROM category_uuid), (SELECT measurement_system_uuid FROM imperial)),
(uuid_generate_v4(), 'c', 'cup', (SELECT unit_category_uuid FROM category_uuid), (SELECT measurement_system_uuid FROM us_units));

WITH category_uuid AS (SELECT unit_category_uuid FROM unit_category WHERE name = 'specific heat')
INSERT INTO unit_kind (unit_kind_uuid, abbreviation, name, unit_category_uuid) VALUES 
(uuid_generate_v4(), 'J/K', 'joules per degree kelvin', (SELECT unit_category_uuid FROM category_uuid)),
(uuid_generate_v4(), 'cal/gC', 'calories per gram degree celcius', (SELECT unit_category_uuid FROM category_uuid)),
(uuid_generate_v4(), 'BTU/lbF', 'BTU per pound degree fahrenheit', (SELECT unit_category_uuid FROM category_uuid));
