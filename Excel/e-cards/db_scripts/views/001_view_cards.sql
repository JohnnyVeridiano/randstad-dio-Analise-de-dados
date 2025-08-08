CREATE VIEW vw_pokemon_cards_info AS
SELECT
    c.cards_id,
    c.name AS card_name,
    c.hp,
    t.typeName AS card_type,
    s.stageName AS card_stage,
    c.attackInfo,
    c.damage,
    c.weakness,
    c.resistance,
    c.retreatCost,
    c.cardNumberInCollection,
    col.collectionSetName AS collection_name,
    col.releaseDate AS release_date,
    col.totalCardsInCollection
FROM tbl_cards c
JOIN tbl_types t ON c.type_id = t.T_id_type
JOIN tbl_stages s ON c.stage_id = s.s_id_stages
JOIN tbl_collections col ON c.collection_id = col.collection_id; 

