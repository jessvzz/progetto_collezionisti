-- verifica visibilità di tuutte le collezioni da parte di un collezionista
DROP PROCEDURE IF EXISTS check_visibilita2;
DELIMITER $$
	CREATE PROCEDURE check_visibilita2(ID1 INTEGER)
    BEGIN
     DROP TEMPORARY TABLE IF EXISTS tmp_visibilita;
    CREATE TEMPORARY TABLE tmp_visibilita (
        ID_collezione INTEGER
    );
    
   INSERT INTO tmp_visibilita
    SELECT DISTINCT ID FROM collezione
    WHERE stato = 'pubblico' OR ID_collezionista = ID1;

    INSERT INTO tmp_visibilita
    SELECT DISTINCT ID_collezione FROM condivisa
    WHERE ID_collezionista = ID1;

    SELECT * FROM tmp_visibilita;
    END $$
DELIMITER ;
