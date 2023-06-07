-- inserimento di una traccia ad un disco
DROP PROCEDURE IF EXISTS inserimento_traccia;
DELIMITER $$
	CREATE PROCEDURE inserimento_traccia(ID_disco INTEGER, ISRC VARCHAR(100), durata VARCHAR(100), titolo VARCHAR(100), ID_genere INTEGER)
    BEGIN
    INSERT INTO brano(ID_disco, ISRC, durata, titolo, ID_genere)
    VALUES(ID_disco, ISRC, durata, titolo, ID_genere);
    END $$
DELIMITER ;