USE Collectors;

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

-- genere(ID, nome)
INSERT INTO `genere`
VALUES(1, "pop");

INSERT INTO `genere`
VALUES(2, "rap");

INSERT INTO `genere`
VALUES(3, "metal");

INSERT INTO `genere`
VALUES(4, "rock");

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

/* -- copia(ID, stato_di_conservazione, ID_disco, ID_tipo, ID_collezione, barcode)
INSERT INTO `copia`
VALUES(1, "OTTIMO" , 1, 1, 1, "123456789");

INSERT INTO `copia`
VALUES(2, "BUONO" , 2, 3, 4, "123456787");

INSERT INTO `copia`
VALUES(3, "OTTIMO" , 3, 1, 3, "123456786");

INSERT INTO `copia`
VALUES(4, "USURATO" , 4, 5, 2, "123456784");

INSERT INTO `copia`
VALUES(5, "BUONO" , 5, 4, 1, "123456785");

INSERT INTO `copia`
VALUES(6, "BUONO" , 6, 2, 1, "987654321");

INSERT INTO `copia`
VALUES(7, "OTTIMO" , 7, 1, 5, "123456783");

INSERT INTO `copia`
VALUES(8, "OTTIMO" , 8, 3, 4, "123456788");

INSERT INTO `copia`
VALUES(9, "BUONO" , 8, 1, 4, "223456788"); */


-- condivisa(ID_collezionista, ID_collezione)
INSERT INTO `condivisa`
VALUES(2, 4);

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




