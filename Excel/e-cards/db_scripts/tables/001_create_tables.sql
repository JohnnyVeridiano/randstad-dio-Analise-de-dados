create database db_tcgpokemon_cards;
use db_tcgpokemon_cards;

CREATE TABLE tbl_collections (
    collection_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    collectionSetName VARCHAR(100) NOT NULL,
    releaseDate DATE,
    totalCardsInCollection INTEGER
);

CREATE TABLE tbl_types (
    T_id_type integer PRIMARY KEY,
    typeName VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_stages (
    s_id_stages INTEGER PRIMARY KEY,
    stageName VARCHAR(50) NOT NULL
);
 show tables;

CREATE TABLE tbl_cards (
    cards_id SERIAL PRIMARY KEY,
    hp INTEGER,
    name VARCHAR(100) NOT NULL,
    type_id INTEGER,
    stage_id INTEGER,
    attackInfo TEXT,
    damage VARCHAR(20),
    weakness VARCHAR(50),
    resistance VARCHAR(50),
    retreatCost INTEGER,
    cardNumberInCollection VARCHAR(20),
    collection_id INTEGER,
    constraint fk_tbl_cards_collections FOREIGN KEY (collection_id) REFERENCES tbl_collections(collection_id),
    constraint fk_tbl_cards_types FOREIGN KEY (type_id) REFERENCES tbl_types(T_id_type),
    constraint fk_tbl_cards_stages FOREIGN KEY (stage_id) REFERENCES tbl_stages(s_id_stages)
);

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
(40, 'Pikachu', 1, 1, 'Thunder Shock', '30', 'Fighting', 'Metal', 1, '025/102', 1)
(120, 'Charizard', 2, 3, 'Fire Spin', '100', 'Water', 'Grass', 3, '004/102', 1),
(60, 'Squirtle', 3, 1, 'Bubble', '20', 'Electric', 'Fire', 1, '007/102', 1),
(50, 'Oddish', 4, 1, 'Absorb', '10', 'Fire', 'Water', 1, '043/64', 2),
(70, 'Abra', 5, 1, 'Psyshock', '30', 'Bug', 'Fighting', 1, '069/102', 1);

select * from tbl_cards;


INSERT INTO tbl_cards (hp, name, type_id, stage_id, attackInfo, damage, weakness, resistance, retreatCost, cardNumberInCollection, collection_id) 
VALUES 
(60, 'Pikachu', 1, 1, 'Thunder Shock', '30', 'Ground', 'Flying', 1, '001/100', 1),
(80, 'Charizard', 2, 3, 'Flamethrower', '90', 'Water', 'Grass', 3, '002/100', 1),
(70, 'Bulbasaur', 3, 1, 'Vine Whip', '20', 'Fire', 'Water', 1, '003/100', 1),
(90, 'Blastoise', 4, 3, 'Hydro Pump', '80', 'Electric', 'Fire', 3, '004/100', 1),
(50, 'Jigglypuff', 5, 1, 'Sing', '0', 'Steel', 'Dragon', 1, '005/100', 2),
(110, 'Snorlax', 3, 3, 'Body Slam', '100', 'Fighting', 'Ghost', 4, '006/100', 2),
(30, 'Magikarp', 4, 1, 'Splash', '0', 'Electric', 'Fire', 1, '007/100', 2),
(60, 'Meowth', 4, 1, 'Scratch', '20', 'Fighting', 'Ghost', 1, '008/100', 2),
(70, 'Gengar', 5, 3, 'Shadow Ball', '70', 'Dark', 'Psychic', 2, '009/100', 2),
(40, 'Eevee', 5, 1, 'Quick Attack', '10', 'Fighting', 'Psychic', 1, '010/100', 3),
(100, 'Machamp', 3, 3, 'Cross Chop', '90', 'Psychic', 'Dark', 3, '011/100', 3),
(80, 'Arcanine', 2, 2, 'Flame Charge', '60', 'Water', 'Grass', 2, '012/100', 3),
(70, 'Lapras', 4, 2, 'Surf', '50', 'Electric', 'Fire', 2, '013/100', 3),
(60, 'Sandshrew', 4, 1, 'Sand Attack', '20', 'Water', 'Grass', 1, '014/100', 4),
(90, 'Dragonite', 5, 3, 'Dragon Tail', '100', 'Ice', 'Fire', 3, '015/100', 4),
(50, 'Zubat', 2, 1, 'Bite', '10', 'Electric', 'Psychic', 1, '016/100', 4),
(40, 'Rattata', 1, 1, 'Tackle', '10', 'Fighting', 'Ghost', 1, '017/100', 4),
(70, 'Alakazam', 2, 3, 'Psybeam', '70', 'Dark', 'Fighting', 2, '018/100', 4),
(80, 'Lucario', 4, 2, 'Aura Sphere', '60', 'Psychic', 'Dark', 2, '019/100', 5),
(60, 'Togepi', 5, 1, 'Charm', '0', 'Steel', 'Dark', 1, '020/100', 5);

INSERT INTO tbl_cards (hp, name, type_id, stage_id, attackInfo, damage, weakness, resistance, retreatCost, cardNumberInCollection, collection_id)
VALUES
(40, 'Chikorita', 4, 1, 'Razor Leaf', '30', 'Fire', 'Water', 1, '101/150', 2),
(60, 'Bayleef', 4, 2, 'Vine Whip, Seed Bomb', '40,60', 'Fire', 'Water', 2, '102/150', 2),
(80, 'Meganium', 4, 3, 'Solar Beam', '70', 'Fire', 'Water', 3, '103/150', 2),
(50, 'Cyndaquil', 2, 1, 'Ember', '30', 'Water', 'Grass', 1, '104/150', 2),
(70, 'Quilava', 2, 2, 'Flame Wheel', '50', 'Water', 'Grass', 2, '105/150', 2),
(90, 'Typhlosion', 2, 3, 'Blast Burn', '80', 'Water', 'Grass', 3, '106/150', 2),
(50, 'Totodile', 3, 1, 'Water Gun', '30', 'Electric', 'Fire', 1, '107/150', 2),
(70, 'Croconaw', 3, 2, 'Aqua Jet', '40', 'Electric', 'Fire', 2, '108/150', 2),
(100, 'Feraligatr', 3, 3, 'Hydro Cannon', '90', 'Electric', 'Fire', 3, '109/150', 2),
(40, 'Hoothoot', 5, 1, 'Peck', '20', 'Electric', 'Grass', 1, '110/150', 2),
(60, 'Noctowl', 5, 2, 'Wing Attack, Hypnosis', '40,0', 'Electric', 'Grass', 2, '111/150', 2),
(50, 'Sentret', 2, 1, 'Scratch', '20', 'Fighting', 'Ghost', 1, '112/150', 2),
(70, 'Furret', 3, 2, 'Quick Attack', '30', 'Fighting', 'Ghost', 2, '113/150', 2),
(60, 'Spinarak', 4, 1, 'Poison Sting', '30', 'Fire', 'Water', 1, '114/150', 2),
(80, 'Ariados', 4, 2, 'Sticky Web', '50', 'Fire', 'Water', 2, '115/150', 2),
(40, 'Mareep', 1, 1, 'Thunder Wave', '20', 'Ground', 'Flying', 1, '116/150', 2),
(60, 'Flaaffy', 1, 2, 'Spark', '30', 'Ground', 'Flying', 2, '117/150', 2),
(90, 'Ampharos', 1, 3, 'Thunderbolt', '80', 'Ground', 'Flying', 3, '118/150', 2),
(70, 'Bellossom', 4, 3, 'Leaf Blade', '70', 'Fire', 'Water', 2, '119/150', 2),
(100, 'Sudowoodo', 5, 2, 'Rock Throw, Mimic', '40,0', 'Grass', 'Electric', 2, '120/150', 2),
(50, 'Politoed', 3, 3, 'Bubble Beam', '60', 'Electric', 'Fire', 2, '121/150', 2),
(90, 'Espeon', 5, 3, 'Psychic Blast', '70', 'Dark', 'Fighting', 2, '122/150', 2),
(90, 'Umbreon', 3, 3, 'Shadow Rush', '70', 'Fighting', 'Psychic', 2, '123/150', 2),
(60, 'Murkrow', 2, 1, 'Night Shade', '30', 'Electric', 'Psychic', 1, '124/150', 2),
(100, 'Slowking', 3, 3, 'Mind Control, Water Pulse', '50,60', 'Electric', 'Fire', 3, '125/150', 2),
(50, 'Misdreavus', 5, 1, 'Confuse Ray', '30', 'Dark', 'Normal', 1, '126/150', 2),
(70, 'Steelix', 1, 3, 'Iron Tail', '80', 'Fire', 'Flying', 3, '127/150', 2),
(60, 'Scizor', 1, 3, 'Bullet Punch', '70', 'Fire', 'Grass', 2, '128/150', 2),
(80, 'Heracross', 4, 2, 'Mega Horn', '60', 'Psychic', 'Dark', 2, '129/150', 2),
(120, 'Tyranitar', 5, 3, 'Crunch, Earthquake', '50,80', 'Fighting', 'Psychic', 4, '130/150', 2);


INSERT INTO tbl_cards (hp, name, type_id, stage_id, attackInfo, damage, weakness, resistance, retreatCost, cardNumberInCollection, collection_id)
VALUES
(90, 'Lugia', 5, 3, 'Aeroblast', '80', 'Electric', 'Fighting', 3, '131/150', 2),
(120, 'Ho-Oh', 2, 3, 'Sacred Fire', '90', 'Water', 'Grass', 3, '132/150', 2),
(60, 'Celebi', 5, 1, 'Time Travel', '40', 'Dark', 'Fighting', 1, '133/150', 2),
(80, 'Smeargle', 1, 1, 'Sketch', '0', 'Fighting', 'Ghost', 1, '134/150', 2),
(70, 'Delibird', 5, 1, 'Present', '30', 'Electric', 'Fighting', 1, '135/150', 2),
(90, 'Stantler', 3, 1, 'Stomp', '40', 'Fighting', 'Ghost', 2, '136/150', 2),
(110, 'Entei', 2, 3, 'Volcanic Flame', '80', 'Water', 'Grass', 3, '137/150', 2),
(110, 'Raikou', 1, 3, 'Thunder Claw', '80', 'Ground', 'Flying', 3, '138/150', 2),
(110, 'Suicune', 3, 3, 'Crystal Wave', '80', 'Electric', 'Fire', 3, '139/150', 2),
(50, 'Teddiursa', 4, 1, 'Scratch', '20', 'Fighting', 'Ghost', 1, '140/150', 2),
(70, 'Ursaring', 2, 2, 'Slash', '60', 'Fighting', 'Ghost', 3, '141/150', 2),
(60, 'Swinub', 5, 1, 'Powder Snow', '30', 'Fire', 'Grass', 1, '142/150', 2),
(90, 'Piloswine', 3, 2, 'Icicle Crash', '70', 'Fire', 'Grass', 2, '143/150', 2),
(80, 'Corsola', 3, 1, 'Bubble Beam', '40', 'Electric', 'Fire', 1, '144/150', 2),
(70, 'Mantine', 3, 1, 'Aqua Ring', '30', 'Electric', 'Fire', 2, '145/150', 2),
(60, 'Phanpy', 3, 1, 'Rollout', '20', 'Water', 'Electric', 1, '146/150', 2),
(90, 'Donphan', 3, 2, 'Earthquake', '80', 'Water', 'Electric', 3, '147/150', 2),
(40, 'Sunkern', 4, 1, 'Growth', '10', 'Fire', 'Water', 1, '148/150', 2),
(60, 'Sunflora', 4, 2, 'Petal Dance', '40', 'Fire', 'Water', 2, '149/150', 2),
(100, 'Kingdra', 3, 3, 'Dragon Pump', '90', 'Dragon', 'Fairy', 3, '150/150', 2),
(60, 'Octillery', 3, 2, 'Ink Blast', '50', 'Electric', 'Fire', 2, '151/150', 2),
(40, 'Tyrogue', 1, 1, 'Punch', '20', 'Psychic', 'Dark', 1, '152/150', 2),
(70, 'Hitmontop', 4, 2, 'Rapid Spin', '40', 'Psychic', 'Dark', 2, '153/150', 2),
(50, 'Magby', 2, 1, 'Fire Spark', '30', 'Water', 'Grass', 1, '154/150', 2),
(50, 'Elekid', 1, 1, 'Shock', '30', 'Ground', 'Flying', 1, '155/150', 2),
(90, 'Blissey', 5, 3, 'Healing Egg', '60', 'Fighting', 'Ghost', 3, '156/150', 2),
(80, 'Miltank', 5, 2, 'Milk Drink, Tackle', '0,40', 'Fighting', 'Ghost', 2, '157/150', 2),
(100, 'Skarmory', 3, 2, 'Steel Wing', '70', 'Fire', 'Grass', 2, '158/150', 2),
(60, 'Houndour', 4, 1, 'Dark Fang', '30', 'Water', 'Fairy', 1, '159/150', 2),
(90, 'Houndoom', 4, 2, 'Inferno Howl', '70', 'Water', 'Fairy', 2, '160/150', 2);

