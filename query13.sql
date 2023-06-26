DROP PROCEDURE IF EXISTS trova_dischi_simili_barcode_nullo;
DELIMITER $$
	CREATE PROCEDURE trova_dischi_simili_barcode_nullo(titolo VARCHAR(100), autore VARCHAR(100), coll INTEGER UNSIGNED)
    BEGIN 
		SELECT d.ID, d.barcode, d.stato_di_conservazione, d.titolo, a.nome_dArte, d.ID_artista , d.ID_collezionista FROM disco d
			JOIN artista a ON (a.ID = d.ID_artista)
		WHERE (a.nome_dArte LIKE CONCAT('%', autore, '%') OR d.titolo LIKE CONCAT('%', titolo, '%'))
			   AND d.ID_collezionista = coll;
	END $$
    DELIMITER ; 
    
    
DROP PROCEDURE IF EXISTS trova_dischi_simili_barcode;
DELIMITER $$
	CREATE PROCEDURE trova_dischi_simili_barcode(barcode VARCHAR(100), coll INTEGER UNSIGNED)
    BEGIN 
		SELECT d.ID, d.barcode, d.stato_di_conservazione, d.titolo, d.ID_artista, d.ID_collezionista FROM disco d
		WHERE d.barcode = barcode AND d.ID_collezionista = coll;
	END $$
    DELIMITER ; 
    
    call trova_dischi_simili_barcode_nullo("", "Francesco Guccini", 1);