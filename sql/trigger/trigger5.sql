USE Collectors;
DROP TRIGGER IF EXISTS check_numero_dischi;
DELIMITER $$

-- una collezione non può essere formata da un numero di dischi superiore a quelli posseduti

CREATE TRIGGER check_numero_dischi BEFORE UPDATE ON collezione
FOR EACH ROW
BEGIN
	DECLARE numero_dischi_totali SMALLINT UNSIGNED DEFAULT 0;
    DECLARE numero_dischi_collezione SMALLINT UNSIGNED DEFAULT 0;
    
    SELECT d.ID_collezionista, COUNT(*) INTO numero_dischi_totali
    FROM disco d
    GROUP BY d.ID_collezionista;
    
    SELECT d.ID_collezione, COUNT(*) INTO numero_dischi_collezione
    FROM disco d
    GROUP BY d.ID_collezione;

    IF (numero_dischi_collezione > numero_dischi_totali) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore! Stai inserendo una quantità errata di dischi nella collezione';
    END IF;
END $$
DELIMITER ;
