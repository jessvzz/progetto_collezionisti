-- inserimento di un disco in una collezione
DROP PROCEDURE IF EXISTS inserimento_disco;
DELIMITER $$
	CREATE PROCEDURE inserimento_disco(ID_collezione INTEGER, ID_disco INTEGER)
    BEGIN
    INSERT INTO contiene(ID_collezione, ID_disco)
    VALUES(ID_collezione, ID_disco);
    END $$
DELIMITER ;