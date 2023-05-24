DROP DATABASE IF EXISTS Collectors;

CREATE DATABASE IF NOT EXISTS Collectors;
USE Collectors;

DROP TABLE IF EXISTS collezionista;
DROP TABLE IF EXISTS collezione;
DROP TABLE IF EXISTS artista;
DROP TABLE IF EXISTS disco;
DROP TABLE IF EXISTS brano;
DROP TABLE IF EXISTS copia;
DROP TABLE IF EXISTS etichetta;
DROP TABLE IF EXISTS immagine;
DROP TABLE IF EXISTS condivisa;
DROP TABLE IF EXISTS e_stata_condivisa;
DROP TABLE IF EXISTS contiene;
DROP TABLE IF EXISTS quantizza;
DROP TABLE IF EXISTS appartiene;

CREATE TABLE collezionista(
 ID INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
 nickname VARCHAR(100) NOT NULL UNIQUE,
 email VARCHAR(100) NOT NULL UNIQUE,
 nome VARCHAR(100) NOT NULL,
 cognome VARCHAR(100) NOT NULL,
 data_di_nascita VARCHAR(100) 
    );
    
CREATE TABLE collezione(
 ID INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
 nome VARCHAR(100) NOT NULL UNIQUE,
 pubblico BOOLEAN,
CONSTRAINT collezione_collezionista FOREIGN KEY (ID_collezionista)
        REFERENCES collezionista (ID)
        ON DELETE RESTRICT ON UPDATE CASCADE
    );

    
CREATE TABLE artista(
 ID INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
 nome_dArte VARCHAR(100) NOT NULL,
 nome VARCHAR(100),
 cognome VARCHAR(100),
 data_di_nascita DATETIME NOT NULL,
 gruppo BOOLEAN
    );
    
CREATE TABLE disco(
 ID INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
 titolo VARCHAR(100) NOT NULL,
 CONSTRAINT disco_artista FOREIGN KEY (ID_artista)
        REFERENCES artista (ID)
        ON DELETE RESTRICT ON UPDATE CASCADE,
 anno_uscita INTEGER UNSIGNED,
 barcode VARCHAR(100),
  CONSTRAINT disco_etichetta FOREIGN KEY (ID_etichetta)
        REFERENCES etichetta (ID)
        ON DELETE RESTRICT ON UPDATE CASCADE,
tipo ENUM ('CD', 'Vinile', 'Musicassetta', 'EP', 'Digitale', 'Altro')	

    );
    
CREATE TABLE brano( -- vedere per genere
 ID INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
 ISRC VARCHAR(100) NOT NULL UNIQUE,
 durata VARCHAR(100),
 titolo VARCHAR(100),
CONSTRAINT brano_disco FOREIGN KEY (ID_disco)
        REFERENCES disco (ID)
        ON DELETE RESTRICT ON UPDATE CASCADE
    );
    
CREATE TABLE copia(
	ID INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    ID_disco INTEGER UNSIGNED,
    stato_di_conservazione VARCHAR(100) -- ENUM??
    );

CREATE TABLE etichetta(
 ID INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
 p_iva INTEGER UNSIGNED NOT NULL,
 nome VARCHAR(100),
 sede VARCHAR(100)
 	);
 	
CREATE TABLE immagini(
 ID INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
 -- sorgente
 nome VARCHAR(100), 
 dimensione VARCHAR(100),
 formato VARCHAR(100),
 collocazione VARCHAR(100),
 ID_disco INTEGER UNSIGNED
	);

CREATE TABLE condivisa(
 ID_collezionista INTEGER UNSIGNED,
 ID_collezione INTEGER UNSIGNED,
 data_inizio DATE
	);

CREATE TABLE e_stata_condivisa(
 ID_collezionista INTEGER UNSIGNED,
 ID_collezione	INTEGER UNSIGNED,
 data_inizio DATETIME,
 data_fine DATETIME
	);
    
CREATE TABLE contiene(
 ID_collezione INTEGER UNSIGNED,
 ID_disco INTEGER UNSIGNED
	);
    
CREATE TABLE quantizza(
 quantita SMALLINT UNSIGNED DEFAULT 1, -- or 0??
 ID_disco INTEGER UNSIGNED,
 ID_copia INTEGER UNSIGNED
	);
 
 CREATE TABLE appartiene(
  ID_artista INTEGER UNSIGNED,
  ID_brano INTEGER UNSIGNED,
  esegue_o_compone SMALLINT DEFAULT 1 -- potremmo dire 1 esegue -1 compone??
	);
 
 
    
    
    
