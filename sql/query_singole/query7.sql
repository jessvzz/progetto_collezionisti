-- track list di un disco
DROP PROCEDURE IF EXISTS tracklist;
DELIMITER $$
	CREATE PROCEDURE tracklist(ID1 INTEGER)
    BEGIN
    SELECT b.ID, b.titolo, b.ISRC, b.durata FROM brano b
        JOIN disco d ON (b.ID_disco = d.ID)
    WHERE d.ID = ID1;
    END $$
DELIMITER ;