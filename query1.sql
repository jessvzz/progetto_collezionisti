drop procedure if exists inserimento_collezione;
-- inserimento di una nuova collezione
DELIMITER $$
	create procedure inserimento_collezione(ID_collezionista integer, nome varchar(100), stato boolean)
    BEGIN
    INSERT INTO collezione(ID, ID_collezionista, nome, pubblico)
    VALUES(ID, ID_collezionista, nome, stato);
    END $$
DELIMITER ;


