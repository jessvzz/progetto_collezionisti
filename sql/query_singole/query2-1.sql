-- inserimento di un disco in una collezione
DROP PROCEDURE IF EXISTS inserimento_disco;
DELIMITER $$
	CREATE PROCEDURE inserimento_disco(barcode VARCHAR(100), stato_di_conservazione ENUM("OTTIMO","BUONO","USURATO"), titolo VARCHAR(100), 
									   ID_artista INTEGER, ID_etichetta INTEGER, ID_collezionista INTEGER, ID_collezione INTEGER, 
                                       ID_genere INTEGER, ID_tipo INTEGER, anno_uscita INTEGER)
    BEGIN
    INSERT INTO disco
    VALUES(ID, barcode, stato_di_conservazione, titolo, ID_artista, ID_etichetta, ID_collezionista, ID_collezione, ID_genere, ID_tipo, anno_uscita);
    END $$
DELIMITER ;

CALL inserimento_disco("123456205","USURATO","disco prova", 1, 1, 1, 1, 1, 1, 2020);