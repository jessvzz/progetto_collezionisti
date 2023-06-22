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

CALL ricerca_dischi("Francesco Guccini", 1, true,false,true);
