-- inserimento di condivisioni ad una collezione
DROP PROCEDURE IF EXISTS inserimento_condivisioni;
DELIMITER $$
	CREATE PROCEDURE inserimento_condivisioni(ID_collezione INTEGER, ID_collezionista INTEGER)
    BEGIN
    INSERT INTO condivisa(ID_collezione, ID_collezionista)
    VALUES(ID_collezione, ID_collezionista);
    END $$
DELIMITER ;