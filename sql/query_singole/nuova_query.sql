DROP PROCEDURE IF EXISTS aggiungi_disco_esistente;
DELIMITER $$
CREATE PROCEDURE aggiungi_disco_esistente(id_disco INTEGER UNSIGNED, id_coll INTEGER UNSIGNED)
BEGIN 
    -- Inserisci il nuovo disco duplicato
    INSERT INTO disco (barcode, stato_di_conservazione, titolo, ID_artista, ID_etichetta, ID_collezionista, ID_collezione, ID_genere, ID_tipo, anno_uscita)
    SELECT barcode, stato_di_conservazione, titolo, ID_artista, ID_etichetta, ID_collezionista, id_coll, ID_genere, ID_tipo, anno_uscita
    FROM disco
    WHERE ID = id_disco;
    
    -- Ottieni l'ID del nuovo disco inserito
    SET @new_disco_id = LAST_INSERT_ID();
    
    -- Inserisci i brani associati al vecchio disco nel nuovo disco
    INSERT INTO brano (ISRC, titolo, durata, ID_disco)
    SELECT b.ISRC, b.titolo, b.durata, @new_disco_id
    FROM brano b
    INNER JOIN disco d ON b.ID_disco = d.ID
    WHERE d.ID = id_disco;
    
    -- Copia le voci dalla tabella "appartiene" per i brani duplicati
    INSERT INTO appartiene (ID_brano, ID_artista, flag)
	SELECT b_new.ID, a.ID_artista, a.flag
	FROM appartiene a
	JOIN brano b_old ON a.ID_brano = b_old.ID
	JOIN brano b_new ON (b_old.titolo = b_new.titolo AND b_old.ISRC = b_new.ISRC)
	WHERE b_new.ID = @new_disco_id;


END $$
DELIMITER ;


call aggiungi_disco_esistente(1, 7);
