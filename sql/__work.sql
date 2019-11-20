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

CREATE OR REPLACE VIEW 
    agi_dm01avso24.vw_einzelobjekte_linienlelement
AS 
SELECT
    linienelement.t_id, 
    einzelobjekt.qualitaet,
    einzelobjekt.art,
    einzelobjekt.entstehung,
    linienelement.geometrie
FROM
    agi_dm01avso24.einzelobjekte_einzelobjekt AS einzelobjekt
    RIGHT JOIN agi_dm01avso24.einzelobjekte_linienelement AS linienelement
    ON linienelement.linienelement_von = einzelobjekt.t_id
;

CREATE OR REPLACE VIEW 
    agi_dm01avso24.vw_einzelobjekte_punktelement
AS 
SELECT
    punktelement.t_id, 
    einzelobjekt.qualitaet,
    einzelobjekt.art,
    einzelobjekt.entstehung,
    punktelement.geometrie
FROM
    agi_dm01avso24.einzelobjekte_einzelobjekt AS einzelobjekt
    RIGHT JOIN agi_dm01avso24.einzelobjekte_punktelement AS punktelement
    ON punktelement.punktelement_von = einzelobjekt.t_id
;

CREATE OR REPLACE VIEW 
    agi_dm01avso24.vw_bodenbedeckung_boflaechesymbol
AS 
SELECT
    symbol.t_id,
    symbol.ori,
    bb.art,
    symbol.pos
FROM
    agi_dm01avso24.bodenbedeckung_boflaechesymbol AS symbol
    LEFT JOIN agi_dm01avso24.bodenbedeckung_boflaeche AS bb
    ON bb.t_id = boflaechesymbol_von
;

CREATE OR REPLACE VIEW 
    agi_dm01avso24.vw_liegenschaften_grenzpunkt
AS 
SELECT
    grenzpunkt.t_id,
    grenzpunkt.geometrie,
    grenzpunkt.punktzeichen,
    nf.gueltigkeit
FROM
    agi_dm01avso24.liegenschaften_grenzpunkt AS grenzpunkt
    LEFT JOIN agi_dm01avso24.liegenschaften_lsnachfuehrung AS nf 
    ON grenzpunkt.entstehung = nf.t_id
;

CREATE OR REPLACE VIEW 
    agi_dm01avso24.vw_gemeindegrenzen_gemeindegrenze
AS 
SELECT
    gemeindegrenze.t_id,
    gemeinde.aname AS aname,
    gemeindegrenze.geometrie
FROM
    agi_dm01avso24.gemeindegrenzen_gemeindegrenze AS gemeindegrenze
    LEFT JOIN agi_dm01avso24.gemeindegrenzen_gemeinde AS gemeinde 
    ON gemeinde.t_id = gemeindegrenze.gemeindegrenze_von
;

CREATE OR REPLACE VIEW 
    agi_dm01avso24.vw_gemeindegrenzen_hoheitsgrenzpunkt
AS 
SELECT
    hoheitsgrenzpunkt.t_id,
    hoheitsgrenzpunkt.geometrie,
    hoheitsgrenzpunkt.punktzeichen,
    nf.gueltigkeit
    
FROM
    agi_dm01avso24.gemeindegrenzen_hoheitsgrenzpunkt AS hoheitsgrenzpunkt
    LEFT JOIN agi_dm01avso24.gemeindegrenzen_gemnachfuehrung AS nf 
    ON nf.t_id = hoheitsgrenzpunkt.entstehung
;

CREATE OR REPLACE VIEW 
    agi_dm01avso24.vw_liegenschaften_grundstueckpos
AS 
SELECT
    pos.t_id,
    pos.hali,
    pos.vali,
    pos.ori,
    pos.pos,
    grundstueck.gueltigkeit,
    grundstueck.nummer,
    grundstueck.art
FROM
    agi_dm01avso24.liegenschaften_grundstueck AS grundstueck
    LEFT JOIN agi_dm01avso24.liegenschaften_grundstueckpos AS pos 
    ON grundstueck.t_id = pos.grundstueckpos_von
;

CREATE OR REPLACE VIEW 
    agi_dm01avso24.vw_liegenschaften_projgrundstueckpos
AS 
SELECT
    pos.t_id,
    pos.hali,
    pos.vali,
    pos.ori,
    pos.pos,
    grundstueck.gueltigkeit,
    grundstueck.nummer,
    grundstueck.art
FROM
    agi_dm01avso24.liegenschaften_projgrundstueck AS grundstueck
    LEFT JOIN agi_dm01avso24.liegenschaften_projgrundstueckpos AS pos 
    ON grundstueck.t_id = pos.projgrundstueckpos_von
;

CREATE OR REPLACE VIEW 
    agi_dm01avso24.vw_gebaeudeadressen_lokalisationsnamepos
AS 
SELECT
    pos.t_id,
    pos.hali,
    pos.vali,
    pos.ori,
    pos.pos,
    aname.atext
FROM
    agi_dm01avso24.gebaeudeadressen_lokalisationsnamepos AS pos 
    LEFT JOIN agi_dm01avso24.gebaeudeadressen_lokalisationsname AS aname
    ON aname.t_id = pos.lokalisationsnamepos_von
;

CREATE OR REPLACE VIEW 
    agi_dm01avso24.vw_gebaeudeadressen_hausnummerpos
AS 
SELECT
    pos.t_id,
    pos.hali,
    pos.vali,
    pos.ori,
    pos.pos,
    eingang.hausnummer
FROM
    agi_dm01avso24.gebaeudeadressen_gebaeudeeingang AS eingang
    RIGHT JOIN agi_dm01avso24.gebaeudeadressen_hausnummerpos AS pos
    ON eingang.t_id = pos.hausnummerpos_von
;

CREATE OR REPLACE VIEW 
    agi_dm01avso24.vw_nomenklatur_flurnamepos
AS 
SELECT
    pos.t_id,
    pos.hali,
    pos.vali,
    pos.ori,
    pos.pos,
    flurname.aname
FROM
    agi_dm01avso24.nomenklatur_flurnamepos AS pos
    LEFT JOIN agi_dm01avso24.nomenklatur_flurname AS flurname
    ON pos.flurnamepos_von = flurname.t_id
;

CREATE OR REPLACE VIEW 
    agi_dm01avso24.vw_nomenklatur_gelaendenamepos
AS 
SELECT
    pos.t_id,
    pos.hali,
    pos.vali,
    pos.ori,
    pos.pos,
    gelaendename.aname
FROM
    agi_dm01avso24.nomenklatur_gelaendenamepos AS pos
    LEFT JOIN agi_dm01avso24.nomenklatur_gelaendename AS gelaendename
    ON pos.gelaendenamepos_von = gelaendename.t_id
;

CREATE OR REPLACE VIEW 
    agi_dm01avso24.vw_nomenklatur_ortsnamepos
AS 
SELECT
    pos.t_id,
    pos.hali,
    pos.vali,
    pos.ori,
    pos.pos,
    ortsname.aname
FROM
    agi_dm01avso24.nomenklatur_ortsnamepos AS pos
    LEFT JOIN agi_dm01avso24.nomenklatur_ortsname AS ortsname
    ON pos.ortsnamepos_von = ortsname.t_id
;

CREATE OR REPLACE VIEW 
    agi_dm01avso24.vw_bodenbedeckung_objektnamepos
AS 
SELECT
    pos.t_id,
    pos.hali,
    pos.vali,
    pos.ori,
    pos.pos,
    objektname.aname
FROM
    agi_dm01avso24.bodenbedeckung_objektnamepos AS pos
    LEFT JOIN agi_dm01avso24.bodenbedeckung_objektname AS objektname
    ON pos.objektnamepos_von = objektname.t_id
;

CREATE OR REPLACE VIEW 
    agi_dm01avso24.vw_rohrleitungen_leitungsobjektpos
AS 
SELECT
    pos.t_id,
    pos.hali,
    pos.vali,
    pos.ori,
    pos.pos,
    leitungsobjekt.betreiber
FROM
    agi_dm01avso24.rohrleitungen_leitungsobjektpos AS pos
    LEFT JOIN agi_dm01avso24.rohrleitungen_leitungsobjekt AS leitungsobjekt
    ON pos.leitungsobjektpos_von = leitungsobjekt.t_id
;