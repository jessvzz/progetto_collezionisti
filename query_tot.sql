/* QUERY 1: Inserimento di una nuova collezione */

DROP PROCEDURE IF EXISTS inserimento_collezione;
DELIMITER $$
	CREATE PROCEDURE inserimento_collezione(ID_collezionista INTEGER, nome VARCHAR(100), stato ENUM("PUBBLICO","PRIVATO"))
    BEGIN
    INSERT INTO collezione(ID, ID_collezionista, nome, stato)
    VALUES(ID, ID_collezionista, nome, stato);
    END $$
DELIMITER ;

/* QUERY 2a: Aggiunta di dischi ad una collezione */

DROP PROCEDURE IF EXISTS inserimento_disco;
DELIMITER $$
	CREATE PROCEDURE inserimento_disco(nome VARCHAR(100), ID_artista INTEGER, ID_etichetta INTEGER, ID_collezionista INTEGER, ID_collezione INTEGER, anno_uscita INTEGER)
    BEGIN
    INSERT INTO disco
    VALUES(ID, nome, ID_artista, ID_etichetta, ID_collezionista, ID_collezione, anno_uscita);
    END $$
DELIMITER ;

/* QUERY 2b: Aggiunta di tracce ad un disco */

DROP PROCEDURE IF EXISTS inserimento_traccia;
DELIMITER $$
	CREATE PROCEDURE inserimento_traccia(ID_disco INTEGER, ISRC VARCHAR(100), durata VARCHAR(100), titolo VARCHAR(100), ID_genere INTEGER)
    BEGIN
    INSERT INTO brano(ID_disco, ISRC, durata, titolo, ID_genere)
    VALUES(ID_disco, ISRC, durata, titolo, ID_genere);
    END $$
DELIMITER ;

/* QUERY 3a: Modifica dello stato di pubblicazione di una collezione (da privata a pubblica e viceversa)*/

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

/* QUERY 3b: Aggiunta di nuove condivisioni a una collezione */

DROP PROCEDURE IF EXISTS inserimento_condivisioni;
DELIMITER $$
	CREATE PROCEDURE inserimento_condivisioni(ID_collezione INTEGER, ID_collezionista INTEGER)
    BEGIN
    INSERT INTO condivisa(ID_collezione, ID_collezionista)
    VALUES(ID_collezione, ID_collezionista);
    END $$
DELIMITER ;

/* QUERY 4: Rimozione di un disco da una collezione. */

DROP PROCEDURE IF EXISTS rimozione_disco;
DELIMITER $$
	CREATE PROCEDURE rimozione_disco(ID1 INTEGER)
    BEGIN
    DELETE FROM copia WHERE ID = ID1;
    END $$
DELIMITER ;

/* QUERY 5: Rimozione di una collezione. */

DROP PROCEDURE IF EXISTS rimozione_collezione;
DELIMITER $$
	CREATE PROCEDURE rimozione_collezione(ID1 INTEGER)
    BEGIN
    DELETE FROM collezione WHERE collezione.ID = ID1;
    END $$
DELIMITER ;

/* QUERY 6: Lista di tutti i dischi in una collezione. */

DROP PROCEDURE IF EXISTS lista_dischi;
DELIMITER $$
	CREATE PROCEDURE lista_dischi(ID1 INTEGER)
    BEGIN
    SELECT d.ID, d.titolo, d.ID_artista, d.ID_etichetta, d.ID_collezionista, d.ID_genere, d.anno_uscita, c.stato_di_conservazione, c.ID_tipo, c.barcode FROM disco d
     JOIN copia c ON(c.ID_disco = d.ID)
    WHERE c.ID_collezione = ID1;
    END $$
DELIMITER ;

/* QUERY 7: Track list di un disco. */

DROP PROCEDURE IF EXISTS tracklist;
DELIMITER $$
	CREATE PROCEDURE tracklist(ID1 INTEGER)
    BEGIN
    SELECT b.titolo FROM brano b
        JOIN disco d ON (b.ID_disco = d.ID)
    WHERE d.ID = ID1;
    END $$
DELIMITER ;

/* QUERY 8: Ricerca di dischi in base a nomi di autori/compositori/interpreti e/o titoli. 
Si potrà decidere di includere nella ricerca le collezioni di un certo collezionista e/o 
quelle condivise con lo stesso collezionista e/o quelle pubbliche. */

DROP PROCEDURE IF EXISTS ricerca_dischi;
DELIMITER $$
CREATE PROCEDURE ricerca_dischi(
    stringa VARCHAR(100), ID_coll INTEGER, posseduta BOOLEAN, condivisa BOOLEAN, pubblica BOOLEAN
)
BEGIN
	IF (posseduta AND condivisa AND pubblica) THEN
	CALL ricerca1(stringa, ID_coll) ;
    CALL ricerca2(stringa, ID_coll) ;
    CALL ricerca3(stringa, ID_coll);
    (SELECT * FROM ric1) UNION DISTINCT (SELECT * FROM ric2) UNION DISTINCT (SELECT * FROM ric3);
    
    ELSEIF (posseduta AND NOT pubblica AND NOT condivisa) THEN
    CALL ricerca1(stringa, ID_coll);
    SELECT * FROM ric1;
    
    ELSEIF (condivisa AND NOT pubblica AND NOT posseduta) THEN
    CALL ricerca2(stringa, ID_coll);
    SELECT * FROM ric2;
    
    ELSEIF (pubblica AND NOT posseduta AND NOT condivisa) THEN
    CALL ricerca3(stringa, ID_coll);
    SELECT * FROM ric3;
    
    ELSEIF (posseduta AND condivisa AND NOT pubblica) THEN
    CALL ricerca1(stringa, ID_coll);
    CALL ricerca2(stringa, ID_coll);
    (SELECT * FROM ric1) UNION DISTINCT (SELECT * FROM ric2);
    
    ELSEIF (posseduta AND pubblica AND NOT condivisa) THEN
    CALL ricerca1(stringa, ID_coll);
    CALL ricerca3(stringa, ID_coll);
    (SELECT * FROM ric1) UNION DISTINCT (SELECT * FROM ric3);
    
    ELSEIF (condivisa AND pubblica AND NOT posseduta ) THEN
    CALL ricerca2(stringa, ID_coll);
    CALL ricerca3(stringa, ID_coll);
    SELECT * FROM ric2 UNION DISTINCT SELECT * FROM ric3;
    
    END IF;
	END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS ricerca1;
DELIMITER $$
CREATE PROCEDURE ricerca1(stringa VARCHAR(100), ID_coll INTEGER)
BEGIN
DROP TEMPORARY TABLE IF EXISTS ric1;
CREATE TEMPORARY TABLE ric1 AS
	SELECT DISTINCT d.ID, d.titolo AS disco_titolo, a.nome_dArte AS artista_nome 
		FROM disco d
		JOIN artista a ON d.ID_artista = a.ID
		WHERE (d.titolo = stringa OR a.nome_dArte = stringa)
		AND d.ID_collezionista = ID_coll;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS ricerca2;
DELIMITER $$
CREATE PROCEDURE ricerca2(stringa VARCHAR(100), ID_coll INTEGER)
BEGIN
DROP TEMPORARY TABLE IF EXISTS ric2;
CREATE TEMPORARY TABLE ric2 AS
		SELECT DISTINCT d.ID, d.titolo AS disco_titolo, a.nome_dArte AS artista_nome 
		FROM disco d
		JOIN artista a ON d.ID_artista = a.ID
		JOIN copia c ON c.ID_disco = d.ID
		WHERE (d.titolo = stringa OR a.nome_dArte = stringa) AND (c.ID_collezione IN(
			SELECT ID_collezione FROM condivisa con WHERE con.ID_collezionista = ID_coll));
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS ricerca3;
DELIMITER $$
CREATE PROCEDURE ricerca3(stringa VARCHAR(100), ID_coll INTEGER)
BEGIN
DROP TEMPORARY TABLE IF EXISTS ric3;
CREATE TEMPORARY TABLE ric3 AS
		SELECT DISTINCT d.ID, d.titolo AS disco_titolo, a.nome_dArte AS artista_nome
			FROM disco d
			JOIN artista a ON d.ID_artista = a.ID
			JOIN copia c ON c.ID_disco = d.ID
			WHERE (d.titolo = stringa OR a.nome_dArte = stringa) AND (c.ID_collezione IN(
					SELECT ID
					FROM collezione
					WHERE stato = 'pubblico'
				)
			);
END $$
DELIMITER ;

/* QUERY 9: Verifica della visibilità di una collezione da parte di un collezionista. */

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

/* QUERY 10: Numero dei brani (tracce di dischi) distinti di un certo autore (compositore, musicista) presenti nelle collezioni pubbliche. */

DROP PROCEDURE IF EXISTS conta_brani_autore;
DELIMITER $$
CREATE PROCEDURE conta_brani_autore(autore_id INTEGER UNSIGNED)

BEGIN
    DECLARE brani_count INT;
    SELECT COUNT(b.ID) INTO brani_count FROM brano b
		JOIN appartiene a ON (a.ID_brano = b.ID)
        JOIN disco d ON (d.ID = b.ID_disco)
        JOIN copia cop ON (cop.ID_disco = d.ID)
        JOIN collezione c ON (c.ID = cop.ID_collezione)
    WHERE a.ID_artista = autore_id AND c.stato = "pubblico";
    SELECT brani_count;
END $$
DELIMITER ;

/* QUERY 11: Minuti totali di musica riferibili a un certo autore (compositore, musicista) memorizzati nelle collezioni pubbliche. */

DROP PROCEDURE IF EXISTS conta_minuti;
DELIMITER $$
CREATE PROCEDURE conta_minuti(autore_id INTEGER UNSIGNED)

BEGIN
    DECLARE minuti_count INT;
    SELECT SUM(TIME_TO_SEC(b.durata)) INTO minuti_count FROM brano b
		JOIN appartiene a ON (a.ID_brano = b.ID)
        JOIN disco d ON (d.ID = b.ID_disco)
        JOIN copia cop ON (cop.ID_disco = d.ID)
        JOIN collezione c ON (c.ID = cop.ID_collezione)
    WHERE a.ID_artista = autore_id AND c.stato = 'pubblico';
    SELECT SEC_TO_TIME(minuti_count) AS minuti_totali;
END $$
DELIMITER ;

/* QUERY 12a: Statistica per numero di collezioni di ciascun collezionista. */

DROP PROCEDURE IF EXISTS conta_collezioni_per_collezionista;
DELIMITER $$
CREATE PROCEDURE conta_collezioni_per_collezionista()
BEGIN
    SELECT c.ID_collezionista, COUNT(*) AS numero_collezioni
    FROM collezione c
    GROUP BY ID_collezionista;
END $$
DELIMITER ;

/* QUERY 12b: Statistica per numero di dischi per genere nel sistema. */

DROP PROCEDURE IF EXISTS conta_dischi_per_genere;
DELIMITER $$
CREATE PROCEDURE conta_dischi_per_genere()
BEGIN
    SELECT g.nome, COUNT(*) AS numero_dischi
    FROM disco d
    JOIN copia c ON (c.ID_disco = d.ID)
    JOIN genere g ON (g.ID = d.ID_genere)
    GROUP BY ID_genere;
END $$
DELIMITER ;

/* QUERY 12_Alternativa: Statistica per numero di collezioni di uno specifico collezionista. */

DROP PROCEDURE IF EXISTS conta_collezioniXcollezionista;
DELIMITER $$
CREATE PROCEDURE conta_collezioniXcollezionista(ID_coll INTEGER)

BEGIN
    DECLARE collezioni_count INT;
    SELECT COUNT(c.ID) INTO collezioni_count FROM collezione c
    WHERE c.ID_collezionista = ID_coll;
    SELECT collezioni_count;
END $$
DELIMITER ;