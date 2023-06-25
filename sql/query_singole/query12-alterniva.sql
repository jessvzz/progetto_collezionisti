DROP PROCEDURE IF EXISTS conta_collezioniXcollezionista;
DELIMITER $$
CREATE PROCEDURE conta_collezioniXcollezionista(ID_coll INTEGER)

BEGIN
    DECLARE collezioni_count INT;
    SELECT COUNT(c.ID) INTO collezioni_count FROM collezione c
    WHERE c.ID_collezionista = ID_coll;
    SELECT collezioni_count;
END $$
DELIMITER ;

CALL conta_collezioniXcollezionista(1);
