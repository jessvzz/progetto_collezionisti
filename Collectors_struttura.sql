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

CREATE TABLE collezionista(
 ID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 nickname VARCHAR(100) NOT NULL UNIQUE,
 email VARCHAR(100) NOT NULL UNIQUE,
 nome VARCHAR(100) NOT NULL,
 cognome VARCHAR(100) NOT NULL
	);
    
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
    nome VARCHAR(50)
	);
    
CREATE TABLE tipo(
	ID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50)
	);
    
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
        ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT disco_collezione FOREIGN KEY (ID_collezione)
        REFERENCES collezione (ID)
        ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT disco_genere FOREIGN KEY (ID_genere)
        REFERENCES genere (ID)
        ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT disco_tipo FOREIGN KEY (ID_tipo)
        REFERENCES tipo (ID)
        ON DELETE RESTRICT ON UPDATE CASCADE
	);
        
CREATE TABLE brano( 
 ID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 ISRC VARCHAR(100) NOT NULL UNIQUE,
 durata TIME,
 titolo VARCHAR(100),
 ID_disco INTEGER UNSIGNED NOT NULL,
CONSTRAINT brano_disco FOREIGN KEY (ID_disco)
        REFERENCES disco (ID)
        ON DELETE RESTRICT ON UPDATE CASCADE
	);
 	
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
        ON DELETE RESTRICT ON UPDATE CASCADE
	);

CREATE TABLE condivisa(
    ID_collezionista INTEGER UNSIGNED NOT NULL,
    ID_collezione INTEGER UNSIGNED NOT NULL,
    PRIMARY KEY (ID_collezionista , ID_collezione),
	CONSTRAINT condivisa_collezione FOREIGN KEY (ID_collezione)
		REFERENCES collezione (ID)
        ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT condivisa_collezionista FOREIGN KEY (ID_collezionista)
		REFERENCES collezionista (ID)
        ON DELETE RESTRICT ON UPDATE CASCADE
	);
     
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
        ON DELETE RESTRICT ON UPDATE CASCADE
	);