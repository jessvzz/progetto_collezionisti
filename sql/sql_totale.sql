-- CREAZIONE DEL DATABASE --

DROP DATABASE IF EXISTS Collectors;

CREATE DATABASE IF NOT EXISTS Collectors;
USE Collectors;

DROP TABLE IF EXISTS collezionista;
DROP TABLE IF EXISTS collezione;
DROP TABLE IF EXISTS artista;
DROP TABLE IF EXISTS disco;
DROP TABLE IF EXISTS brano;
DROP TABLE IF EXISTS etichetta;
DROP TABLE IF EXISTS immagine;
DROP TABLE IF EXISTS condivisa;
DROP TABLE IF EXISTS quantizza;
DROP TABLE IF EXISTS appartiene;
DROP TABLE IF EXISTS genere;
DROP TABLE IF EXISTS tipo;

-- Creiamo l'utente che accederà ai dati
DROP USER IF EXISTS 'collectorsUser'@'localhost';
CREATE USER 'collectorsUser'@'localhost' IDENTIFIED BY 'collectorsPwd€123';
GRANT select,insert,update,delete,execute ON Collectors.* TO 'collectorsUser'@'localhost';

/* Abbiamo deciso di impostare tutti i VARCHAR ad una lunghezza di 100 caratteri per dare 
più libertà agli utenti che utilizzeranno l'applicazione. */

CREATE TABLE collezionista(
 ID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 nickname VARCHAR(100) NOT NULL UNIQUE,
 email VARCHAR(100) NOT NULL UNIQUE,
 nome VARCHAR(100) NOT NULL,
 cognome VARCHAR(100) NOT NULL
	);

/*In riferimento alla chiave esterna del collezionista, vogliamo che in caso di cancellazione 
di un collezionista la collezione venga eliminata. */
    
CREATE TABLE collezione(
ID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL UNIQUE,
stato enum('pubblico','privato') DEFAULT 'privato',
ID_collezionista INTEGER UNSIGNED NOT NULL,
CONSTRAINT collezione_collezionista FOREIGN KEY (ID_collezionista)
        REFERENCES collezionista (ID)
        ON DELETE RESTRICT ON UPDATE CASCADE
	);
    
CREATE TABLE artista(
 ID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 nome_dArte VARCHAR(100) NOT NULL,
 nome VARCHAR(100),
 cognome VARCHAR(100),
 gruppo BOOLEAN
    );
    
CREATE TABLE etichetta(
 ID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 p_iva VARCHAR(100) UNIQUE,
 nome VARCHAR(100) UNIQUE NOT NULL
 	);
    
CREATE TABLE genere(
	ID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100)
	);
    
CREATE TABLE tipo(
	ID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100)
	);
 
/* In riferimento alle chiavi esterne di artista, etichetta, genere e tipo, vogliamo che non sia possibile cancellare dal db 
un artista, un'etichetta, un genere o un tipo a cui sia referenziato un disco; per le chiavi esterne di collezionista e collezione
invece vogliamo che, in caso di cancellazione di una delle due tabelle, venga eliminato anche il disco.  */ 
 
CREATE TABLE disco(
 ID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 barcode VARCHAR(100),
 stato_di_conservazione ENUM ('OTTIMO','BUONO','USURATO'),
 titolo VARCHAR(100) NOT NULL,
 ID_artista INTEGER UNSIGNED NOT NULL,
 ID_etichetta INTEGER UNSIGNED NOT NULL,
 ID_collezionista INTEGER UNSIGNED NOT NULL,
 ID_collezione INTEGER UNSIGNED NOT NULL,
 ID_genere INTEGER UNSIGNED NOT NULL,
 ID_tipo INTEGER UNSIGNED NOT NULL,
 anno_uscita INTEGER UNSIGNED,
 CONSTRAINT disco_artista FOREIGN KEY (ID_artista)
        REFERENCES artista (ID)
        ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT disco_etichetta FOREIGN KEY (ID_etichetta)
        REFERENCES etichetta (ID)
        ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT disco_collezionista FOREIGN KEY (ID_collezionista)
        REFERENCES collezionista (ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT disco_collezione FOREIGN KEY (ID_collezione)
        REFERENCES collezione (ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT disco_genere FOREIGN KEY (ID_genere)
        REFERENCES genere (ID)
        ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT disco_tipo FOREIGN KEY (ID_tipo)
        REFERENCES tipo (ID)
        ON DELETE RESTRICT ON UPDATE CASCADE
	);
        
/* In riferimento alla chiave esterna disco, vogliamo che in caso venga eliminato un disco sia eliminato anche il brano. */ 

/* L'ISRC non è unico per via del  fatto che abbiamo aggiunto la possibilità di avere più copie dello stesso
   disco contenenti gli stessi brani. Per di più abbiamo preso in considerazione la possibilità che uno stesso brano possa
   essere in dischi diversi. */
   
CREATE TABLE brano( 
 ID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 ISRC VARCHAR(100) NOT NULL,
 durata TIME,
 titolo VARCHAR(100),
 ID_disco INTEGER UNSIGNED NOT NULL,
CONSTRAINT brano_disco FOREIGN KEY (ID_disco)
        REFERENCES disco (ID)
        ON DELETE CASCADE ON UPDATE CASCADE
	);
    
/* In riferimento alla chiave esterna disco, vogliamo che in caso venga eliminato un disco sia eliminata anche l'immagine 
ad esso riferita. */ 
 	
CREATE TABLE immagine(
 ID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 nome VARCHAR(100), 
 dimensione VARCHAR(100),
 formato VARCHAR(100),
 url_sorgente VARCHAR(255),
 collocazione VARCHAR(100),
 ID_disco INTEGER UNSIGNED NOT NULL,
 CONSTRAINT immagine_disco FOREIGN KEY (ID_disco)
		REFERENCES disco (ID)
        ON DELETE CASCADE ON UPDATE CASCADE
	);

/* In caso di cancellazione di una collezione e/o di un collezionista, viene eliminata anche 
la condivisione che vi è tra quella collezione e quel collezionista. */ 

CREATE TABLE condivisa(
    ID_collezionista INTEGER UNSIGNED NOT NULL,
    ID_collezione INTEGER UNSIGNED NOT NULL,
    PRIMARY KEY (ID_collezionista , ID_collezione),
	CONSTRAINT condivisa_collezione FOREIGN KEY (ID_collezione)
		REFERENCES collezione (ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT condivisa_collezionista FOREIGN KEY (ID_collezionista)
		REFERENCES collezionista (ID)
        ON DELETE CASCADE ON UPDATE CASCADE
	);
 
 /* Se l'artista è referenziato da un brano non possiamo eliminarlo mentre, se viene eliminato il brano, 
 vogliamo che venga eliminata la relazione tra il brano e l'artista. */
 
 CREATE TABLE appartiene(
  ID_artista INTEGER UNSIGNED NOT NULL,
  ID_brano INTEGER UNSIGNED NOT NULL,
  flag ENUM("ESECUTORE","COMPOSITORE","ENTRAMBI") DEFAULT "ESECUTORE", 
  PRIMARY KEY (ID_artista , ID_brano),
	CONSTRAINT appartiene_artista FOREIGN KEY (ID_artista)
		REFERENCES artista (ID)
        ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT appartiene_brano FOREIGN KEY (ID_brano)
		REFERENCES brano (ID)
        ON DELETE CASCADE ON UPDATE CASCADE
	);
    
-- POPOLAMENTO DEL DATABASE --
-- collezionista(ID, nickname, email, nome, cognome)
INSERT INTO `collezionista`
VALUES(1, "jess_vzz", "geaviozzi@icloud.com", "Gea", "Viozzi"); 

INSERT INTO `collezionista`
VALUES(2, "user", "user@icloud.com", "User", "User");

INSERT INTO `collezionista`
VALUES(3, "fedefalco", "federico@icloud.com", "Federico", "Falcone");

INSERT INTO `collezionista`
VALUES(4, "leomasci", "leonardo@icloud.com", "Leonardo", "Masci");

INSERT INTO `collezionista`
VALUES(5, "fabdam", "fabio@icloud.com", "Fabio", "D'Andreamatteo");

INSERT INTO `collezionista`
VALUES(6, "cicca_cicca", "francesca@icloud.com", "Francesca", "Ciccarelli");

-- collezione(ID, nome, flag, ID_collezionista)
INSERT INTO `collezione`
VALUES(1, "cantautori italiani", "pubblico", 1);

INSERT INTO `collezione`
VALUES(2, "dischi rock", "pubblico", 2);

INSERT INTO `collezione`
VALUES(3, "in my feels","privato", 3);

INSERT INTO `collezione`
VALUES(4, "sunday", "privato", 5);

INSERT INTO `collezione`
VALUES(5, "work", "pubblico", 4);

INSERT INTO `collezione`
VALUES(6, "workout","privato", 3);

INSERT INTO `collezione`
VALUES(7, "study time","privato", 1);

INSERT INTO `collezione`
VALUES(8, "relax", "pubblico", 6);

-- artista(ID, nomeDarte, nome, cognome, gruppo)
INSERT INTO `artista`
VALUES(1, "Francesco Guccini", "Francesco", "Guccini", false);

INSERT INTO `artista`
VALUES(2, "Red Hot Chilli Pepper",  null, null, true);

INSERT INTO `artista`
VALUES(3, "System Of A Down",  null, null, true);

INSERT INTO `artista`
VALUES(4, "Taylor Swift",  "Taylor", "Swift", false);

INSERT INTO `artista`
VALUES(5, "Jon Bellion",  "Jon", "Bellion", false);

INSERT INTO `artista`
VALUES(6, "Eminem",  "Eminem", null , false);

INSERT INTO `artista`
VALUES(7, "Imagine Dragons", null, null , true);

INSERT INTO `artista`
VALUES(8, "Jovanotti",  "Lorenzo", "Cherubini" , false);

-- etichetta(ID, p_iva, nome)
INSERT INTO `etichetta`
VALUES(1, "10199720151", "EMI Italia");

INSERT INTO `etichetta`
VALUES(2, "00896521002", "Warner Bros");

INSERT INTO `etichetta`
VALUES(3, "04913851004", "Sony");

-- genere(ID, nome)
INSERT INTO `genere`
VALUES(1, "pop");

INSERT INTO `genere`
VALUES(2, "rap");

INSERT INTO `genere`
VALUES(3, "metal");

INSERT INTO `genere`
VALUES(4, "rock");

INSERT INTO `genere`
VALUES(5, "altro");

-- tipo(ID, nome)
INSERT INTO `tipo`
VALUES (1, "CD");

INSERT INTO `tipo`
VALUES (2, "ALTRO");

INSERT INTO `tipo`
VALUES (3, "MUSICASSETTA");

INSERT INTO `tipo`
VALUES (4, "VINILE");

INSERT INTO `tipo`
VALUES (5, "DIGITALE");

-- disco(ID, barcode, stato_di_conservazione, titolo, ID_artista, ID_etichetta, 
-- ID_collezionista, ID_collezione, ID_genere, ID_tipo, anno_uscita)
INSERT INTO `disco`
VALUES(1, "123456789", "OTTIMO", "D'amore di morte e di altre sciocchezze", 1, 1, 1, 1, 1, 1, 1996);

INSERT INTO `disco`
VALUES(2, "123256789", "BUONO", "Disco1", 5, 3, 4, 4, 2, 3, 1995);

INSERT INTO `disco`
VALUES(3, "423456789", "OTTIMO", "Disco2", 1, 2, 3, 3, 3, 1, 2000);

INSERT INTO `disco`
VALUES(4, "145456789", "USURATO", "Disco3", 6, 1, 2, 2, 4, 5, 1970);

INSERT INTO `disco`
VALUES(5, "023456789", "BUONO", "Disco4", 2, 2, 1, 1, 1, 4, 1990);

INSERT INTO `disco`
VALUES(6, "123446789", "BUONO", "Disco5", 1, 1, 1, 1, 2, 2, 1976);

INSERT INTO `disco`
VALUES(7, "123456389", "OTTIMO", "Disco6", 1, 3, 4, 5, 3, 1, 1995);

INSERT INTO `disco`
VALUES(8, "123406789", "OTTIMO", "Disco7", 1, 1, 5, 4, 1, 3, 2000);

INSERT INTO `disco`
VALUES(9, "103406789", "USURATO", "Disco7", 1, 1, 5, 4, 1, 2, 2000);

INSERT INTO `disco`
VALUES(10, "103406489", "BUONO", "Disco7", 1, 1, 6, 8, 1, 2, 2000);

INSERT INTO `disco`
VALUES(11, "103406419", "BUONO", "Disco11", 8, 2, 2, 2, 1, 2, 1975);

INSERT INTO `disco`
VALUES(12, "100406489", "OTTIMO", "Disco12", 8, 3, 5, 7, 3, 1, 2017);

-- brano(ID, ISRC, durata, titolo, ID_disco)
INSERT INTO `brano`
VALUES(1, "IT-D00-07-00111", "00:05:21", "Vorrei", 1);

INSERT INTO `brano`
VALUES(2, "IT-D00-07-00112", "00:04:30", "Brano1", 2);

INSERT INTO `brano`
VALUES(3, "IT-D00-07-00113", "00:03:43", "Brano2", 1);

INSERT INTO `brano`
VALUES(4, "IT-D00-07-00114", "00:02:23", "Brano3", 6);

INSERT INTO `brano`
VALUES(5, "IT-D00-07-00115", "00:05:03", "Brano4", 6);

INSERT INTO `brano`
VALUES(6, "IT-D00-07-00116", "00:04:31", "Brano5", 6);

INSERT INTO `brano`
VALUES(7, "IT-D00-07-00117", "00:02:31", "Brano6", 7);

INSERT INTO `brano`
VALUES(8, "IT-D00-07-00118", "00:03:31", "Brano7", 11);

INSERT INTO `brano`
VALUES(9, "IT-D00-07-00119", "00:04:01", "Brano8", 12);

-- condivisa(ID_collezionista, ID_collezione)
INSERT INTO `condivisa`
VALUES(2, 4);

INSERT INTO `condivisa`
VALUES(2, 1);

INSERT INTO `condivisa`
VALUES(2, 6);

-- appartiene(ID_artista, ID_brano, flag)
INSERT INTO `appartiene`
VALUES(1, 1, "ESECUTORE");

INSERT INTO `appartiene`
VALUES(1, 2, "ENTRAMBI");

INSERT INTO `appartiene`
VALUES(1, 3, "ESECUTORE");

INSERT INTO `appartiene`
VALUES(2, 4, "COMPOSITORE");

INSERT INTO `appartiene`
VALUES(3, 5, "ESECUTORE");

INSERT INTO `appartiene`
VALUES(4, 6, "ESECUTORE");

INSERT INTO `appartiene`
VALUES(4, 7, "COMPOSITORE");

-- QUERIES --
/* QUERY 1: Inserimento di una nuova collezione */

DROP PROCEDURE IF EXISTS inserimento_collezione;
DELIMITER $$
	CREATE PROCEDURE inserimento_collezione(ID_collezionista INTEGER UNSIGNED, nome VARCHAR(100), stato ENUM("PUBBLICO","PRIVATO"))
    BEGIN
    INSERT INTO collezione(ID, ID_collezionista, nome, stato)
    VALUES(ID, ID_collezionista, nome, stato);
    END $$
DELIMITER ;

/* QUERY 2a: Aggiunta di dischi ad una collezione */

DROP PROCEDURE IF EXISTS inserimento_disco;
DELIMITER $$
	CREATE PROCEDURE inserimento_disco(barcode VARCHAR(100), stato_di_conservazione ENUM("OTTIMO","BUONO","USURATO"), titolo VARCHAR(100), 
									   ID_artista INTEGER UNSIGNED, ID_etichetta INTEGER UNSIGNED, ID_collezionista INTEGER UNSIGNED, 
                                       ID_collezione INTEGER UNSIGNED, ID_genere INTEGER UNSIGNED, ID_tipo INTEGER UNSIGNED,
                                       anno_uscita INTEGER UNSIGNED)
    BEGIN
    INSERT INTO disco
    VALUES(ID, barcode, stato_di_conservazione, titolo, ID_artista, ID_etichetta, ID_collezionista, ID_collezione, ID_genere, ID_tipo, anno_uscita);
    END $$
DELIMITER ;

/* QUERY 2b: Aggiunta di tracce ad un disco */

DROP PROCEDURE IF EXISTS inserimento_traccia;
DELIMITER $$
CREATE PROCEDURE inserimento_traccia(ISRC VARCHAR(100), durata VARCHAR(100), titolo VARCHAR(100), ID_disco INTEGER UNSIGNED, 
									 flag ENUM('ESECUTORE', 'COMPOSITORE', 'ENTRAMBI'), ID_artista INTEGER UNSIGNED)
BEGIN
  DECLARE ID_brano INTEGER UNSIGNED;

  -- Inserimento del brano nella tabella "brano"
  INSERT INTO brano(ISRC, durata, titolo, ID_disco)
  VALUES (ISRC, durata, titolo, ID_disco);
  
  -- Ottiene l'ID del brano appena inserito
  SET ID_brano = LAST_INSERT_ID();

  -- Inserimento nella tabella "appartiene"
  INSERT INTO appartiene(ID_artista, ID_brano, flag)
  VALUES (ID_artista, ID_brano, flag);
END $$
DELIMITER ;

/* QUERY 3a: Modifica dello stato di pubblicazione di una collezione (da privata a pubblica e viceversa)*/

DROP PROCEDURE IF EXISTS modifica_pubblicazione;
DELIMITER $$
	CREATE PROCEDURE modifica_pubblicazione(ID1 INTEGER) -- ID1 = ID_collezione
    BEGIN
    DECLARE stato_corrente VARCHAR(10);
    SELECT stato INTO stato_corrente FROM collezione WHERE ID = ID1;

    IF stato_corrente = 'pubblico' THEN
        UPDATE collezione SET stato = 'privato' WHERE ID = ID1;
    ELSEIF stato_corrente = 'privato' THEN
        UPDATE collezione SET stato = 'pubblico' WHERE ID = ID1;
        -- tolgo tutti i record di condivisa che contengono quella collezione.
        DELETE FROM condivisa WHERE ID_collezione = ID1;
    END IF;
    
    SELECT ID, stato FROM collezione WHERE ID = ID1; 
END $$
DELIMITER ;

/* QUERY 3b: Aggiunta di nuove condivisioni ad una collezione */

DROP PROCEDURE IF EXISTS inserimento_condivisioni;
DELIMITER $$
	CREATE PROCEDURE inserimento_condivisioni(ID_collezione INTEGER UNSIGNED, ID_collezionista INTEGER UNSIGNED)
    BEGIN
    INSERT INTO condivisa(ID_collezione, ID_collezionista)
    VALUES(ID_collezione, ID_collezionista);
    END $$
DELIMITER ;

/* QUERY 4: Rimozione di un disco da una collezione. */

DROP PROCEDURE IF EXISTS rimozione_disco;
DELIMITER $$
	CREATE PROCEDURE rimozione_disco(ID1 INTEGER UNSIGNED) -- ID1 = ID_disco
    BEGIN
    DELETE FROM disco WHERE ID = ID1;
    END $$
DELIMITER ;

/* QUERY 5: Rimozione di una collezione. */

DROP PROCEDURE IF EXISTS rimozione_collezione;
DELIMITER $$
	CREATE PROCEDURE rimozione_collezione(ID1 INTEGER UNSIGNED) -- ID1 = ID_collezione
    BEGIN
    DELETE FROM collezione WHERE collezione.ID = ID1;
    END $$
DELIMITER ;

/* QUERY 6: Lista di tutti i dischi in una collezione. */

DROP PROCEDURE IF EXISTS lista_dischi;
DELIMITER $$
	CREATE PROCEDURE lista_dischi(ID1 INTEGER UNSIGNED) -- ID1 = ID_collezione
    BEGIN
    SELECT d.ID, d.titolo, d.ID_artista, d.ID_etichetta, d.ID_collezionista, d.ID_genere, 
		   d.anno_uscita, d.stato_di_conservazione, d.ID_tipo, d.barcode FROM disco d
    WHERE d.ID_collezione = ID1;
    END $$
DELIMITER ;

/* QUERY 7: Track list di un disco. */

DROP PROCEDURE IF EXISTS tracklist;
DELIMITER $$
	CREATE PROCEDURE tracklist(ID1 INTEGER UNSIGNED) -- ID1 = ID_disco
    BEGIN
    SELECT b.ID, b.titolo, b.ISRC, b.durata FROM brano b
        JOIN disco d ON (b.ID_disco = d.ID)
    WHERE d.ID = ID1;
    END $$
DELIMITER ;

/* QUERY 8: Ricerca di dischi in base a nomi di autori/compositori/interpreti e/o titoli. 
Si potrà decidere di includere nella ricerca le collezioni di un certo collezionista e/o 
quelle condivise con lo stesso collezionista e/o quelle pubbliche. */

/* Per la query in oggetto si è deciso di procedere nel seguente modo: passiamo in input una stringa che può essere 
sia il nome dell’artista sia il titolo del disco, l’ID del collezionista e tre parametri booleani che ci serviranno per 
effettuare la ricerca in base alle collezioni possedute dal collezionista, a quelle condivise con lui e/o alle collezioni pubbliche.
Abbiamo creato tre procedure differenti:
-ricerca1 inserisce in una tabella temporanea (ric1) tutte le collezioni che sono possedute dal collezionista;
-ricerca2 inserisce in una tabella temporanea (ric2) tutte le collezioni condivise con il collezionista;
-ricerca3 inserisce in una tabella temporanea (ric3) tutte le collezioni che sono pubbliche e quindi visibili dal collezionista.
A questo punto, grazie alla procedura ricerca_dischi, sarà possibile fare diversi tipi di ricerca in base al valore dei 
parametri booleani in input (tramite la UNION DISTINCT delle temporary table); in particolare possiamo:
-ricercare le collezioni che sono possedute da un collezionista, condivise con lui e pubbliche;
-ricercare le collezioni solo possedute dal collezionista;
-ricercare solo le collezioni condivise con il collezionista;
-ricercare tutte le collezioni pubbliche;
-ricercare le collezioni possedute dal collezionista e condivise con lui ma non pubbliche;
-ricercare le collezioni possedute dal collezionista e pubbliche;
-ricercare le collezioni che sono state condivise con il collezionista e che sono pubbliche. */

DROP PROCEDURE IF EXISTS ricerca_dischi;
DELIMITER $$

CREATE PROCEDURE ricerca_dischi(stringa VARCHAR(100), ID_coll INTEGER UNSIGNED, posseduta BOOLEAN, condivisa BOOLEAN, pubblica BOOLEAN)
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
CREATE PROCEDURE ricerca1(stringa VARCHAR(100), ID_coll INTEGER UNSIGNED)
BEGIN
DROP TEMPORARY TABLE IF EXISTS ric1;
CREATE TEMPORARY TABLE ric1 AS
	SELECT DISTINCT d.ID, d.titolo, d.ID_etichetta, d.ID_collezionista, d.ID_genere, 
		   d.anno_uscita, d.stato_di_conservazione, d.ID_tipo, d.barcode, d.ID_artista, a.nome_dArte AS artista_nome 
		FROM disco d
		JOIN artista a ON d.ID_artista = a.ID
		WHERE (d.titolo = stringa OR a.nome_dArte = stringa)
		AND d.ID_collezionista = ID_coll;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS ricerca2;
DELIMITER $$
CREATE PROCEDURE ricerca2(stringa VARCHAR(100), ID_coll INTEGER UNSIGNED)
BEGIN
DROP TEMPORARY TABLE IF EXISTS ric2;
CREATE TEMPORARY TABLE ric2 AS
		SELECT DISTINCT d.ID, d.titolo, d.ID_etichetta, d.ID_collezionista, d.ID_genere, 
		   d.anno_uscita, d.stato_di_conservazione, d.ID_tipo, d.barcode,  d.ID_artista, a.nome_dArte AS artista_nome 
		FROM disco d
		JOIN artista a ON d.ID_artista = a.ID
		WHERE (d.titolo = stringa OR a.nome_dArte = stringa) AND (d.ID_collezione IN(
			SELECT ID_collezione FROM condivisa con WHERE con.ID_collezionista = ID_coll));
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS ricerca3;
DELIMITER $$
CREATE PROCEDURE ricerca3(stringa VARCHAR(100), ID_coll INTEGER UNSIGNED)
BEGIN
DROP TEMPORARY TABLE IF EXISTS ric3;
CREATE TEMPORARY TABLE ric3 AS
		SELECT DISTINCT d.ID, d.titolo, d.ID_etichetta, d.ID_collezionista, d.ID_genere, 
		   d.anno_uscita, d.stato_di_conservazione, d.ID_tipo, d.barcode, d.ID_artista, a.nome_dArte AS artista_nome
			FROM disco d
			JOIN artista a ON d.ID_artista = a.ID
			WHERE (d.titolo = stringa OR a.nome_dArte = stringa) AND (d.ID_collezione IN(
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
	CREATE PROCEDURE check_visibilita(ID1 INTEGER UNSIGNED, ID2 INTEGER UNSIGNED) -- ID1 = ID_collezione; ID2 = ID_collezionista
    
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
    DECLARE brani_count INTEGER UNSIGNED;
    
    SELECT COUNT(b.ID) INTO brani_count FROM brano b
		JOIN appartiene a ON (a.ID_brano = b.ID)
        JOIN disco d ON (d.ID = b.ID_disco)
        JOIN collezione c ON (c.ID = d.ID_collezione)
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
        JOIN collezione c ON (c.ID = d.ID_collezione)
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
		JOIN genere g ON (g.ID = d.ID_genere)
    GROUP BY ID_genere;
END $$
DELIMITER ;

/* QUERY 12_Alternativa: Statistica per numero di collezioni di uno specifico collezionista. */

DROP PROCEDURE IF EXISTS conta_collezioniXcollezionista;
DELIMITER $$
CREATE PROCEDURE conta_collezioniXcollezionista(ID_coll INTEGER UNSIGNED)

BEGIN
    DECLARE collezioni_count INT;
    SELECT COUNT(c.ID) INTO collezioni_count FROM collezione c
    WHERE c.ID_collezionista = ID_coll;
    SELECT collezioni_count;
END $$
DELIMITER ;

-- Query 13

/* Abbiamo differenziato due casi: uno in cui il barcode è nullo e uno in cui il barcode non è nullo. */
-- questa query e' stata implementata in java quando si cerca di aggiungere un disco gia' esistente

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
    
    
    -- PROCEDURES AGGIUNTIVE CHE CI SONO TORNATE UTILI
    
    /* Funzione per contare le copie di un disco di un collezionista */
DROP FUNCTION IF EXISTS conta_copie;

DELIMITER $$
CREATE FUNCTION conta_copie(ID_disco INTEGER)
RETURNS INTEGER UNSIGNED DETERMINISTIC
BEGIN
    DECLARE numero_copie INTEGER UNSIGNED;
    DECLARE disco_titolo VARCHAR(255);
    DECLARE disco_artista INTEGER;
    DECLARE disco_collezionista INTEGER;
    
    SELECT titolo, ID_artista, ID_collezionista INTO disco_titolo, disco_artista, disco_collezionista
    FROM disco WHERE ID = ID_disco;
    
    SET numero_copie = (
        SELECT COUNT(DISTINCT disc.ID) FROM disco disc  
        WHERE disc.ID_artista = disco_artista AND disc.titolo = disco_titolo AND disc.ID_collezionista = disco_collezionista
    );
    
    RETURN numero_copie;
END $$
DELIMITER ;


	
-- procedura A: aggiunge un disco già esistente in una collezione
DROP PROCEDURE IF EXISTS aggiungi_disco_esistente;
DELIMITER $$
CREATE PROCEDURE aggiungi_disco_esistente(id_disco INTEGER UNSIGNED, id_coll INTEGER UNSIGNED)
BEGIN 
    INSERT INTO disco (barcode, stato_di_conservazione, titolo, ID_artista, ID_etichetta, ID_collezionista, ID_collezione, ID_genere, ID_tipo, anno_uscita)
    SELECT barcode, stato_di_conservazione, titolo, ID_artista, ID_etichetta, ID_collezionista, id_coll, ID_genere, ID_tipo, anno_uscita
    FROM disco
    WHERE ID = id_disco;
   
    SET @new_disco_id = LAST_INSERT_ID();
    
   -- inserisco i brani
    INSERT INTO brano (ISRC, titolo, durata, ID_disco)
    SELECT b.ISRC, b.titolo, b.durata, @new_disco_id
    FROM brano b
    INNER JOIN disco d ON b.ID_disco = d.ID
    WHERE d.ID = id_disco;
    
    

END $$
DELIMITER ;


-- TRIGGERS --

-- Trigger 1 --

-- una condivisione non puo' essere ricondivisa con lo stesso collezionista, con sè stessi oppure se è pubblica
DROP TRIGGER IF EXISTS check_condivisione;
DELIMITER $$

CREATE TRIGGER check_condivisione BEFORE INSERT ON condivisa
FOR EACH ROW
BEGIN
    DECLARE count SMALLINT UNSIGNED;
    DECLARE pubblica_count SMALLINT UNSIGNED;
    DECLARE stesso_collezionista_count SMALLINT UNSIGNED;

    -- conto quante collezioni con il nuovo ID sono condivise con il nuovo collezionista
    SELECT COUNT(*) INTO count
    FROM condivisa
    WHERE ID_collezionista = NEW.ID_collezionista AND ID_collezione = NEW.ID_collezione;

   -- conto le collezioni con il nuovo ID che sono pubbliche
    SELECT COUNT(*) INTO pubblica_count
    FROM collezione
    WHERE ID = NEW.ID_collezione AND stato = 'pubblico';

  --  conto le collezioni con il nuovo ID che appartengono al collezionista
    SELECT COUNT(*) INTO stesso_collezionista_count
    FROM collezione
    WHERE ID = NEW.ID_collezione AND ID_collezionista = NEW.ID_collezionista;

-- se ho già quella collezione condivisa con me, o pubblica o è mia, ritorna errore
    IF ((count > 0) OR (pubblica_count > 0) OR (stesso_collezionista_count > 0)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore! Impossibile condividere questa collezione con il collezionista indicato.';
    END IF;
END$$

DELIMITER ;

-- Trigger 2 --

-- un collezionista non puo' avere più di una collezione con lo stesso nome.
DROP TRIGGER IF EXISTS check_collezioni_nomi;
DELIMITER $$

CREATE TRIGGER check_collezioni_nomi BEFORE INSERT ON collezione
FOR EACH ROW
BEGIN
    DECLARE count SMALLINT UNSIGNED;

    SELECT COUNT(*) INTO count
    FROM collezione
    WHERE ID_collezionista = NEW.ID_collezionista AND nome = NEW.nome;

    IF (count > 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore! Impossibile utilizzare questo nome poichè è già stato utilizzato.';
    END IF;
END $$

DELIMITER ;
