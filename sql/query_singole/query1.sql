-- inserimento di una nuova collezione
DROP PROCEDURE IF EXISTS inserimento_collezione;
DELIMITER $$
	CREATE PROCEDURE inserimento_collezione(ID_collezionista INTEGER, nome VARCHAR(100), stato ENUM("pubblico","privato"))
    BEGIN
    INSERT INTO collezione(ID, ID_collezionista, nome, stato)
    VALUES(ID, ID_collezionista, nome, stato);
    END $$
DELIMITER ;

