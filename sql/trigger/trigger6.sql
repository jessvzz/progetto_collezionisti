USE Collectors;
DROP TRIGGER IF EXISTS check_etichetta;
DELIMITER $$ 

-- Controlla se ci sono dischi associati all'etichetta e ,nel caso, impedisce cancellazione
CREATE TRIGGER check_etichetta BEFORE DELETE ON etichetta
FOR EACH ROW
BEGIN
    DECLARE num_dischi SMALLINT UNSIGNED;

    SELECT COUNT(*) INTO num_dischi
    FROM disco d
    WHERE d.ID_etichetta = OLD.ID;

    IF (num_dischi > 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Impossibile eliminare l'etichetta, un disco resterebbe senza etichetta";
    END IF;
END $$
DELIMITER ;
