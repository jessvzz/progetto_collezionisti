-- track list di un disco
DROP PROCEDURE IF EXISTS ricerca_dischi;
DELIMITER $$
	CREATE PROCEDURE ricerca_dischi(nome VARCHAR(200), ID_col INTEGER)
    BEGIN
    DROP VIEW IF EXISTS ricerca1;
    CREATE VIEW ricerca1(artista, collezionista) AS
    SELECT d.ID FROM disco d
        JOIN artista a ON (a.ID = d.ID_artista)
        JOIN collezionista c ON (c.ID = d.ID_collezionista)
    WHERE a.nome_dArte = nome AND c.ID = ID_col;
    DROP VIEW IF EXISTS ricerca2;
    CREATE VIEW ricerca2(artista, condivisa) AS
    SELECT d.ID FROM disco d
		JOIN artista a ON (a.ID = d.ID_artista)
        JOIN condivisa con ON (con.ID_collezionista = d.ID_collezionista)
	WHERE a.nome_dArte = nome AND con.ID = ID_col;
    DROP VIEW IF EXISTS ricerca3;
    CREATE VIEW ricerca3() AS
    SELECT d.ID FROM disco d
		JOIN artista a ON (a.ID = d.ID_artista)
        JOIN contiene con ON (con.ID_disco = d.ID)
		JOIN collezione c ON (c.ID_collezione = d.ID)
	WHERE a.nome_dArte = nome AND con.ID = ID_col;
    END $$
DELIMITER ;
 OR con.ID_collezionista = ID_col);