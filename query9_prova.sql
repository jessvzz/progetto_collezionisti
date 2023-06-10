-- verifica visibilità di una collezione
DROP PROCEDURE IF EXISTS check_visibilita1;
DELIMITER $$
	CREATE PROCEDURE check_visibilita1(ID1 INTEGER, ID2 INTEGER)
    BEGIN
    DROP TABLE IF EXISTS tmp1;
    CREATE TABLE tmp1 
    SELECT * FROM collezione c
    WHERE c.ID = ID1 AND (c.stato = 'pubblico' OR c.ID_collezionista = ID2);
    END $$
DELIMITER ;

-- verifica di tutte le collezioni visibili ad un collezionista
DROP PROCEDURE IF EXISTS check_visibilita2;
DELIMITER $$
	CREATE PROCEDURE check_visibilita2(ID1 INTEGER)
    BEGIN
    CREATE VIEW visibilita2 AS
    SELECT * FROM collezione c
    WHERE c.stato = 'pubblico' OR c.ID_collezionista = ID1;
    END $$
DELIMITER ;

-- verifica di tutte le collezioni condivise con un collezionista
DROP PROCEDURE IF EXISTS check_visibilita3;
DELIMITER $$
	CREATE PROCEDURE check_visibilita3(ID1 INTEGER, ID2 INTEGER)
    BEGIN
    CREATE VIEW visibilita3 AS
    SELECT * FROM condivisa c
    WHERE c.ID_collezione = ID1 AND c.ID_collezionista = ID2;
    END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS check_visibilita;
DELIMITER $$
	CREATE PROCEDURE check_visibilita(ID1 INTEGER, ID2 INTEGER)
    BEGIN
    CALL check_visibilita1(ID1, ID2);
    CALL check_visibilita3(ID1, ID2);
    (SELECT * FROM visibilita1) UNION (SELECT * FROM visibilita3);
    END $$
DELIMITER ;

CALL check_visibilita(1,1);