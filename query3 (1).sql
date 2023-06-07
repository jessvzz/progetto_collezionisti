-- modifica dello stato di pubblicazione di una collezione
drop procedure if exists modifica_pubblicazione;
DELIMITER $$
	create procedure modifica_pubblicazione(ID1 integer, flag enum("pubblico","privato"))
    BEGIN
    SELECT ID, stato FROM collezione WHERE collezione.ID = ID1;
    IF flag = "pubblico" THEN UPDATE collezione SET stato = "pubblico" WHERE collezione.ID = ID1;
	ELSEIF flag = "privato" THEN UPDATE collezione SET stato = "privato" WHERE collezione.ID = ID1;
	END IF;
    END $$
DELIMITER ;