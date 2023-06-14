-- lista di tutti i dischi di una collezione
DROP PROCEDURE IF EXISTS lista_dischi;
DELIMITER $$
	CREATE PROCEDURE lista_dischi(ID1 INTEGER)
    BEGIN
    SELECT d.titolo FROM disco d
    WHERE d.ID_collezione = ID1;
    END $$
DELIMITER ;

CALL lista_dischi(1);