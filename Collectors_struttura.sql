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
DROP TABLE IF EXISTS contiene;
DROP TABLE IF EXISTS quantizza;
DROP TABLE IF EXISTS appartiene;
DROP TABLE IF EXISTS genere;
DROP TABLE IF EXISTS tipo;

-- (opzionale) (ri)creiamo anche l'utente che accederà ai dati
DROP USER IF EXISTS 'collectorsUser'@'localhost';
CREATE USER 'collectorsUser'@'localhost' IDENTIFIED BY 'collectorsPwd';
GRANT select,insert,update,delete,execute ON Collectors.* TO 'collectorsUser'@'localhost';

CREATE TABLE collezionista(
 ID_collezionista INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
 nickname VARCHAR(100) NOT NULL UNIQUE,
 email VARCHAR(100) NOT NULL UNIQUE,
 nome VARCHAR(100) NOT NULL,
 cognome VARCHAR(100) NOT NULL
	);
    
CREATE TABLE collezione(
 ID_collezione INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
 nome VARCHAR(100) NOT NULL UNIQUE,
 pubblico enum('pubblico','privato') default 'privato',
 ID_collezionista INTEGER UNSIGNED,
CONSTRAINT collezione_collezionista FOREIGN KEY (ID_collezionista)
        REFERENCES collezionista (ID_collezionista)
        ON DELETE RESTRICT ON UPDATE CASCADE
	);

    
CREATE TABLE artista(
 ID_artista INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
 nome_dArte VARCHAR(100) NOT NULL,
 nome VARCHAR(100),
 cognome VARCHAR(100),
 gruppo BOOLEAN
    );
    
CREATE TABLE etichetta(
 ID_etichetta INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
 p_iva VARCHAR(100) UNIQUE,
 nome VARCHAR(100) UNIQUE NOT NULL
 	);
    
CREATE TABLE disco(
 ID_disco INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
 titolo VARCHAR(100) NOT NULL,
 ID_artista INTEGER UNSIGNED NOT NULL,
 CONSTRAINT disco_artista FOREIGN KEY (ID_artista)
        REFERENCES artista (ID_artista)
        ON DELETE RESTRICT ON UPDATE CASCADE,
 anno_uscita INTEGER UNSIGNED,
 ID_etichetta INTEGER UNSIGNED,
  CONSTRAINT disco_etichetta FOREIGN KEY (ID_etichetta)
        REFERENCES etichetta (ID_etichetta)
        ON DELETE RESTRICT ON UPDATE CASCADE,
ID_collezione INTEGER UNSIGNED NOT NULL, 
CONSTRAINT disco_collezione FOREIGN KEY (ID_collezionista)
        REFERENCES collezione (ID_collezionista)
        ON DELETE RESTRICT ON UPDATE CASCADE
	);
    
CREATE TABLE genere(
	ID_genere INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50)
	);
    
CREATE TABLE brano( 
 ID_brano INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
 ISRC VARCHAR(100) NOT NULL UNIQUE,
 durata VARCHAR(100),
 titolo VARCHAR(100),
 ID_genere INTEGER UNSIGNED NOT NULL,
 CONSTRAINT brano_genere FOREIGN KEY (ID_genere)
        REFERENCES genere (ID_genere)
        ON DELETE RESTRICT ON UPDATE CASCADE,
ID_disco INTEGER UNSIGNED NOT NULL,
CONSTRAINT brano_disco FOREIGN KEY (ID_disco)
        REFERENCES disco (ID_disco)
        ON DELETE RESTRICT ON UPDATE CASCADE
	);
    

CREATE TABLE tipo(
	ID_tipo INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50)
	);
    
CREATE TABLE copia(
	ID_copia INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    barcode VARCHAR(100),
    stato_di_conservazione ENUM ('OTTIMO','BUONO','USURATO'),
    ID_disco INTEGER UNSIGNED NOT NULL,
    CONSTRAINT copia_disco FOREIGN KEY (ID_disco)
		REFERENCES disco (ID_disco)
        ON DELETE RESTRICT ON UPDATE CASCADE,
	ID_tipo INTEGER UNSIGNED NOT NULL,
    CONSTRAINT copia_tipo FOREIGN KEY (ID_tipo)
        REFERENCES tipo (ID_tipo)
        ON DELETE RESTRICT ON UPDATE CASCADE
	);

 	
CREATE TABLE immagine(
 ID_immagine INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
 nome VARCHAR(100), 
 dimensione VARCHAR(100),
 formato VARCHAR(100),
 url_sorgente VARCHAR(255),
 collocazione VARCHAR(100),
 ID_disco INTEGER UNSIGNED NOT NULL,
 CONSTRAINT immagine_disco FOREIGN KEY (ID_disco)
		REFERENCES disco (ID_disco)
        ON DELETE RESTRICT ON UPDATE CASCADE
	);

CREATE TABLE condivisa(
    ID_collezionista INTEGER UNSIGNED NOT NULL,
    ID_collezione INTEGER UNSIGNED NOT NULL,
    PRIMARY KEY (ID_collezionista , ID_collezione),
	CONSTRAINT condivisa_collezione FOREIGN KEY (ID_collezione)
		REFERENCES collezione (ID_collezione)
        ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT condivisa_collezionista FOREIGN KEY (ID_collezionista)
		REFERENCES collezionista (ID_collezionista)
        ON DELETE RESTRICT ON UPDATE CASCADE
	);
    
CREATE TABLE contiene(
 ID_collezione INTEGER UNSIGNED NOT NULL,
 ID_disco INTEGER UNSIGNED NOT NULL,
 PRIMARY KEY (ID_disco , ID_collezione),
	CONSTRAINT contiene_collezione FOREIGN KEY (ID_collezione)
		REFERENCES collezione (ID_collezione)
        ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT contiene_disco FOREIGN KEY (ID_disco)
		REFERENCES disco (ID_disco)
        ON DELETE RESTRICT ON UPDATE CASCADE
	);
    
 
 CREATE TABLE appartiene(
  ID_artista INTEGER UNSIGNED NOT NULL,
  ID_brano INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY (ID_artista , ID_brano),
	CONSTRAINT appartiene_artista FOREIGN KEY (ID_artista)
		REFERENCES artista (ID_artista)
        ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT appartiene_brano FOREIGN KEY (ID_brano)
		REFERENCES brano (ID_brano)
        ON DELETE RESTRICT ON UPDATE CASCADE,
  esegue_o_compone SMALLINT DEFAULT 1 -- potremmo dire 1 esegue -1 compone??
	);
 
 
    
    
    
