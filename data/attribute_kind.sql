INSERT INTO attribute_kind (attribute_kind_uuid, abbreviation, description, value_type) VALUES
(uuid_generate_v4(), 'abv', 'alcohol by volume', 'float'),
(uuid_generate_v4(), 'og', 'original gravity', 'float'),
(uuid_generate_v4(), 'fg', 'final gravity', 'float'),
(uuid_generate_v4(), 'sg', 'specific gravity', 'float'),
(uuid_generate_v4(), 'ppg', 'points per pound per gallon', 'float'),
(uuid_generate_v4(), 'vol', 'volume', 'float'),
(uuid_generate_v4(), 'wt', 'weight', 'float'),
(uuid_generate_v4(), NULL, 'specific heat', 'float'),
(uuid_generate_v4(), NULL, 'deadspace', 'float'),
(uuid_generate_v4(), NULL, 'boiloff', 'float'),
(uuid_generate_v4(), NULL, 'lossage', 'float');
