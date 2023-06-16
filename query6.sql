-- lista di tutti i dischi di una collezione
DROP PROCEDURE IF EXISTS lista_dischi;
DELIMITER $$
	CREATE PROCEDURE lista_dischi(ID1 INTEGER)
    BEGIN
    SELECT c.titolo FROM copia c
    WHERE c.ID_collezione = ID1;
    END $$
DELIMITER ;

CALL lista_dischi(1);