-- lista di tutti i dischi di una collezione
DROP PROCEDURE IF EXISTS lista_dischi;
DELIMITER $$
	CREATE PROCEDURE lista_dischi(ID1 INTEGER)
    BEGIN
    SELECT d.ID, d.titolo, d.ID_artista, d.ID_etichetta, d.ID_collezionista, d.ID_genere, 
		   d.anno_uscita, d.stato_di_conservazione, d.ID_tipo, d.barcode FROM disco d
    WHERE d.ID_collezione = ID1;
    END $$
DELIMITER ;

CALL lista_dischi(1);