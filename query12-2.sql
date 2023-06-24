DROP PROCEDURE IF EXISTS conta_dischi_per_genere;
DELIMITER $$
CREATE PROCEDURE conta_dischi_per_genere()
BEGIN
    SELECT g.nome, COUNT(*) AS numero_dischi
    FROM disco d
    JOIN genere g ON (g.ID = d.ID_genere)
    GROUP BY ID_genere;
END $$
DELIMITER ;

CALL conta_dischi_per_genere();
