-- rimozione disco da una collezione
DROP PROCEDURE IF EXISTS rimozione_disco;
DELIMITER $$
	CREATE PROCEDURE rimozione_disco(ID1 INTEGER, ID2 INTEGER)
    BEGIN
    DELETE FROM contiene WHERE ID_collezione = ID1 AND ID_disco = ID2;
    END $$
DELIMITER ;