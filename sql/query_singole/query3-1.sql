-- modifica dello stato di pubblicazione di una collezione
DROP PROCEDURE IF EXISTS modifica_pubblicazione;
DELIMITER $$
	CREATE PROCEDURE modifica_pubblicazione(ID1 INTEGER, flag ENUM("pubblico","privato"))
    BEGIN
    SELECT ID, stato FROM collezione WHERE collezione.ID = ID1;
    IF flag = "pubblico" THEN UPDATE collezione SET stato = "pubblico" WHERE collezione.ID = ID1;
	ELSEIF flag = "privato" THEN UPDATE collezione SET stato = "privato" WHERE collezione.ID = ID1;
	END IF;
    END $$
DELIMITER ;