-- lista di tutti i dischi di una collezione
DROP PROCEDURE IF EXISTS lista_dischi;
DELIMITER $$
	CREATE PROCEDURE lista_dischi(ID1 INTEGER)
    BEGIN
    SELECT d.ID, d.titolo, d.ID_artista, d.ID_etichetta, d.ID_collezionista, d.ID_genere, d.anno_uscita, c.stato_di_conservazione, c.ID_tipo, c.barcode FROM disco d
     JOIN copia c ON(c.ID_disco = d.ID)
    WHERE c.ID_collezione = ID1;
    END $$
DELIMITER ;

CALL lista_dischi(1);