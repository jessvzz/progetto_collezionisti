-- lista di tutti i dischi di una collezione
DROP PROCEDURE IF EXISTS lista_dischi;
DELIMITER $$
	CREATE PROCEDURE lista_dischi(ID1 INTEGER)
    BEGIN
    SELECT d.titolo FROM contiene co
		JOIN collezione c ON (co.ID_collezione = c.ID)
        JOIN disco d ON (co.ID_disco = d.ID)
    WHERE c.ID = ID1;
    END $$
DELIMITER ;