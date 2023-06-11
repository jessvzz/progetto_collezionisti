USE Collectors;

DELETE FROM collezione;
DELETE FROM artista;
DELETE FROM disco;
DELETE FROM brano;
DELETE FROM copia;
DELETE FROM etichetta;
DELETE FROM immagine;
DELETE FROM condivisa;
DELETE FROM condivisa;
DELETE FROM contiene;
DELETE FROM appartiene;

-- collezionista(ID, nickname, email, nome, cognome)
INSERT INTO `collezionista`
VALUES(1, "jess_vzz", "geaviozzi@icloud.com", "Gea", "Viozzi"); 

INSERT INTO `collezionista`
VALUES(2, "cicca_cicca", "francesca@icloud.com", "Francesca", "Ciccarelli");

INSERT INTO `collezionista`
VALUES(3, "fedefalco", "federico@icloud.com", "Federico", "Falcone");

INSERT INTO `collezionista`
VALUES(4, "leomasci", "leonardo@icloud.com", "Leonardo", "Masci");

INSERT INTO `collezionista`
VALUES(5, "fabdam", "fabio@icloud.com", "Fabio", "D'Andreamatteo");

-- collezione(ID, nome, flag, ID_collezionista
INSERT INTO `collezione`
VALUES(1, "cantautori italiani", "privato", 1);

INSERT INTO `collezione`
VALUES(2, "dischi rock", "pubblico", 2);

INSERT INTO `collezione`
VALUES(3, "in my feels","privato", 3);

INSERT INTO `collezione`
VALUES(4, "sunday", "pubblico", 5);

INSERT INTO `collezione`
VALUES(5, "work", "privato", 4);

INSERT INTO `collezione`
VALUES(6, "collezione1","privato", 3);

INSERT INTO `collezione`
VALUES(7, "collezione2","privato", 1);

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

-- etichetta(ID, p_iva, nome)
INSERT INTO `etichetta`
VALUES(1, "10199720151", "EMI Italia");

INSERT INTO `etichetta`
VALUES(2, "10199720152", "Warner Bros");

INSERT INTO `etichetta`
VALUES(3, "10199720153", "Sony");

-- disco(ID, nome, ID_artista, ID_etichetta, ID_collezionista, anno_uscita)
INSERT INTO `disco`
VALUES(1, "D'amore di morte e di altre sciocchezze", 1, 1, 1, 1996);

INSERT INTO `disco`
VALUES(2, "Disco1", 5, 3, 4, 1995);

INSERT INTO `disco`
VALUES(3, "Disco2", 1, 2, 3, 2000);

INSERT INTO `disco`
VALUES(4, "Disco3", 6, 1, 2, 1970);

INSERT INTO `disco`
VALUES(5, "Disco4", 2, 2, 1, 1990);

INSERT INTO `disco`
VALUES(6, "Disco5", 1, 1, 1, 1976);

INSERT INTO `disco`
VALUES(7, "Disco7", 1, 3, 4, 1995);

-- genere(ID, nome)
INSERT INTO `genere`
VALUES(1, "pop");

INSERT INTO `genere`
VALUES(2, "rap");

INSERT INTO `genere`
VALUES(3, "metal");

INSERT INTO `genere`
VALUES(4, "rock");

-- brano(ID, ISRC, durata, titolo, ID_genere, ID_disco)
INSERT INTO `brano`
VALUES(1, "IT-D00-07-00111", "5:21", "Vorrei", 1, 1);

INSERT INTO `brano`
VALUES(2, "IT-D00-07-00112", "4:30", "Brano1", 2, 2);

INSERT INTO `brano`
VALUES(3, "IT-D00-07-00113", "3:43", "Brano2", 3, 1);

INSERT INTO `brano`
VALUES(4, "IT-D00-07-00114", "2:23", "Brano3", 1, 6);

INSERT INTO `brano`
VALUES(5, "IT-D00-07-00115", "5:03", "Brano4", 2, 6);

INSERT INTO `brano`
VALUES(6, "IT-D00-07-00116", "4:31", "Brano5", 1, 6);

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

-- copia(ID, stato_di_conservazione, ID_disco, ID_tipo, barcode)
INSERT INTO `copia`
VALUES(1, "OTTIMO" , 1, 1, "123456789");

INSERT INTO `copia`
VALUES(2, "BUONO" , 2, 2, "987654321");

-- condivisa(ID_collezionista, ID_collezione)
INSERT INTO `condivisa`
VALUES(2, 1);

-- contiene(ID_collezione, ID_disco)
INSERT INTO `contiene`
VALUES(1, 1);

INSERT INTO `contiene`
VALUES(7, 6);

INSERT INTO `contiene`
VALUES(5, 7);

-- appartiene(ID_artista, ID_brano, flag)
INSERT INTO `appartiene`
VALUES(1, 1, "esecutore");


