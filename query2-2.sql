-- inserimento di una traccia ad un disco
DROP PROCEDURE IF EXISTS inserimento_traccia;
DELIMITER $$
	CREATE PROCEDURE inserimento_traccia(ISRC VARCHAR(100), durata VARCHAR(100), titolo VARCHAR(100), ID_disco INTEGER)
    BEGIN
    INSERT INTO brano(ISRC, durata, titolo, ID_disco)
    VALUES(ISRC, durata, titolo, ID_disco);
    END $$
DELIMITER ;

CALL inserimento_traccia("8693502U0I3","12:00","PROVA",1);