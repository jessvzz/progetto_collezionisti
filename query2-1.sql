-- inserimento di un disco in una collezione
DROP PROCEDURE IF EXISTS inserimento_disco;
DELIMITER $$
	CREATE PROCEDURE inserimento_disco(nome VARCHAR(100), ID_artista INTEGER, ID_etichetta INTEGER, ID_collezionista INTEGER, ID_collezione INTEGER, anno_uscita INTEGER)
    BEGIN
    INSERT INTO disco
    VALUES(ID, nome, ID_artista, ID_etichetta, ID_collezionista, ID_collezione, anno_uscita);
    END $$
DELIMITER ;

CALL inserimento_disco("disco prova", 1, 1, 1, 1, 2000);