INSERT INTO tbl_collections (collectionSetName, releaseDate, totalCardsInCollection) VALUES
('Base Set', '1999-01-09', 102),
('Jungle', '1999-06-16', 64),
('Fossil', '1999-10-10', 62),
('Team Rocket', '2000-04-24', 83),
('Gym Heroes', '2000-08-14', 132);

INSERT INTO tbl_types (T_id_type, typeName) VALUES
(1, 'Electric'),
(2, 'Fire'),
(3, 'Water'),
(4, 'Grass'),
(5, 'Psychic');

INSERT INTO tbl_stages (s_id_stages, stageName) VALUES
(1, 'Basic'),
(2, 'Stage 1'),
(3, 'Stage 2'),
(4, 'Mega'),
(5, 'EX');

INSERT INTO tbl_cards (hp, name, type_id, stage_id, attackInfo, damage, weakness, resistance, retreatCost, cardNumberInCollection, collection_id) VALUES
(40, 'Pikachu', 1, 1, 'Thunder Shock', '30', 'Fighting', 'Metal', 1, '025/102', 1),
(120, 'Charizard', 2, 3, 'Fire Spin', '100', 'Water', 'Grass', 3, '004/102', 1),
(60, 'Squirtle', 3, 1, 'Bubble', '20', 'Electric', 'Fire', 1, '007/102', 1),
(50, 'Oddish', 4, 1, 'Absorb', '10', 'Fire', 'Water', 1, '043/64', 2),
(70, 'Abra', 5, 1, 'Psyshock', '30', 'Bug', 'Fighting', 1, '069/102', 1);