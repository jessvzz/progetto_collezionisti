DROP PROCEDURE IF EXISTS conta_brani_autore;
DELIMITER $$
CREATE PROCEDURE conta_brani_autore(autore_id INTEGER UNSIGNED)

BEGIN
    DECLARE brani_count INT;
    SELECT COUNT(b.ID) INTO brani_count FROM brano b
		JOIN appartiene a ON (a.ID_brano = b.ID)
        JOIN disco d ON (d.ID = b.ID_disco)
        JOIN collezione c ON (c.ID = d.ID_collezione)
    WHERE a.ID_artista = autore_id AND c.stato = "pubblico";
    SELECT brani_count;
END $$
DELIMITER ;

CALL conta_brani_autore(1);
