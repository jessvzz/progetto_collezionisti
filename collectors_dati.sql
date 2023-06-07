USE Collectors;

DELETE FROM collezionista;
DELETE FROM collezione;
DELETE FROM artista;
DELETE FROM disco;
DELETE FROM brano;
DELETE FROM copia;
DELETE FROM etichetta;
DELETE FROM immagine;
DELETE FROM condivisa;
DELETE FROM e_stata_condivisa;
DELETE FROM contiene;
DELETE FROM quantizza;
DELETE FROM appartiene;


INSERT INTO `collezionista`
VALUES(1, "jess_vzz", "geaviozzi@icloud.com", "Gea", "Viozzi"); 

INSERT INTO `collezionista`
VALUES(2, "cicca_cicca", "francesca@icloud.com", "Francesca", "Ciccarelli");

INSERT INTO `collezionista`
VALUES(3, "fedefalco", "federico@icloud.com", "Federico", "Falcone");

INSERT INTO `collezione`
VALUES(1, "cantautori italiani", false, 1);

INSERT INTO `collezione`
VALUES(2, "dischi rock", true, 2);

INSERT INTO `collezione`
VALUES(3, "in my feels", false, 3);

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

INSERT INTO `disco`
VALUES(1, "D'amore di morte e di altre sciocchezze", 1, 1996, "80000532", 1, 1);

INSERT INTO `brano`
VALUES(1, "IT-D00-07-00111", "5:21", "Vorrei", 1, 1);

INSERT INTO `genere`
VALUES(1, "pop");

INSERT INTO `tipo`
VALUES (1, "CD");

INSERT INTO `copia`
VALUES(1, OTTIMO, 1, 1);

INSERT INTO `etichetta`
VALUES(1, "10199720151", "EMI Italia");

INSERT INTO `etichetta`
VALUES(2, "10199720152", "Warner Bros");

INSERT INTO `condivisa`
VALUES(2, 1);

INSERT INTO `contiene`
VALUES(1, 1);

INSERT INTO `quantizza`
VALUES(1, 1, 1);

INSERT INTO `appartiene`
VALUES(1, 1, 1);


