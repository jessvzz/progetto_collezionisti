DROP PROCEDURE IF EXISTS conta_collezioni_per_collezionista;
DELIMITER $$
CREATE PROCEDURE conta_collezioni_per_collezionista()
BEGIN
    SELECT c.ID_collezionista, COUNT(*) AS numero_collezioni
    FROM collezione c
    GROUP BY ID_collezionista;
END $$
DELIMITER ;

CALL conta_collezioni_per_collezionista();
