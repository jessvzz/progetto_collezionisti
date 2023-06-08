-- rimozione di una collezione
DROP PROCEDURE IF EXISTS rimozione_collezione;
DELIMITER $$
	CREATE PROCEDURE rimozione_collezione(ID1 INTEGER)
    BEGIN
    DELETE FROM collezione WHERE collezione.ID = ID1;
    END $$
DELIMITER ;
