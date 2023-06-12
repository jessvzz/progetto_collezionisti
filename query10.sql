DROP PROCEDURE IF EXISTS conta_brani_autore;
DELIMITER $$
CREATE PROCEDURE conta_brani_autore(
    IN autore_id INTEGER
)
BEGIN
    DECLARE brani_count INT;
    SELECT COUNT(*) INTO brani_count
    FROM appartiene
    WHERE ID_brano IN (
        SELECT ID
        FROM brano
        WHERE ID IN (
            SELECT ID_brano
            FROM contiene
            WHERE ID_collezione IN (
                SELECT ID
                FROM collezione
                WHERE stato = 'pubblico'
            )
        )
    ) AND ID_artista = autore_id;
    SELECT brani_count;
END $$
DELIMITER ;

CALL conta_brani_autore(1);
