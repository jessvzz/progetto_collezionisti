-- verifica visibilità di una collezione
DROP PROCEDURE IF EXISTS check_visibilita;
DELIMITER $$
	CREATE PROCEDURE check_visibilita(ID1 INTEGER, ID2 INTEGER)
    BEGIN
    DECLARE p BOOL;
    SET p = false;
    SELECT 1 INTO p
    FROM collezione c
    WHERE c.ID = ID1 AND (c.stato = 'pubblico' OR c.ID_collezionista = ID2);
    
    IF p = false then
    SELECT 1 INTO p
    FROM condivisa c
    WHERE c.ID_collezione = ID1 AND c.ID_collezionista = ID2;
    END IF;
    
    SELECT p;
    
    END $$
DELIMITER ;

call check_visibilita(4,1);
