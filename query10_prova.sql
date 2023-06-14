DROP PROCEDURE IF EXISTS conta_minuti;
DELIMITER $$
CREATE PROCEDURE conta_minuti(autore_id INTEGER)

BEGIN
    DECLARE minuti_count INT;
    SELECT SUM(TIME_TO_SEC(b.durata)) INTO minuti_count FROM brano b
		JOIN appartiene a ON (a.ID_brano = b.ID)
        JOIN disco d ON (d.ID = b.ID_disco)
        JOIN contiene c ON (c.ID_disco = d.ID) 
        JOIN collezione coll ON (coll.ID = c.ID_collezione)
    WHERE a.ID_artista = autore_id AND coll.stato = 'pubblico';
    SELECT SEC_TO_TIME(minuti_count) AS minuti_totali;
END $$
DELIMITER ;

CALL conta_minuti(4);