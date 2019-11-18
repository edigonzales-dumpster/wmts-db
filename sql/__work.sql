CREATE OR REPLACE VIEW 
    agi_dm01avso24.vw_einzelobjekte_flaechenelement
AS 
SELECT
    flaechenelement.t_id, 
    einzelobjekt.qualitaet,
    einzelobjekt.art,
    einzelobjekt.entstehung,
    flaechenelement.geometrie
FROM
    agi_dm01avso24.einzelobjekte_einzelobjekt AS einzelobjekt
    RIGHT JOIN agi_dm01avso24.einzelobjekte_flaechenelement AS flaechenelement
    ON flaechenelement.flaechenelement_von = einzelobjekt.t_id
;
