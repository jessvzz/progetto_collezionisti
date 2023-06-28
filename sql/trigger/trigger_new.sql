USE Collectors;
DROP TRIGGER IF EXISTS check_condivisioni;
DELIMITER $$

CREATE TRIGGER check_condivisioni BEFORE INSERT ON condivisa
FOR EACH ROW
BEGIN
SELECT * FROM condivisa WHERE ID_collezione = NEW.ID_collezione;
	IF (NEW.ID_collezionista in (condivisa.ID_collezionista))
    THEN  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Impossibile eliminare l'etichetta, un disco resterebbe senza etichetta";
    END IF;

END $$
DELIMITER ;