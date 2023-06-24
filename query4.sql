-- rimozione disco da una collezione
DROP PROCEDURE IF EXISTS rimozione_disco;
DELIMITER $$
	CREATE PROCEDURE rimozione_disco(ID1 INTEGER)
    BEGIN
    DELETE FROM disco WHERE ID = ID1;
    END $$
DELIMITER ;

CALL rimozione_disco(9);