USE Collectors;
DROP TRIGGER IF EXISTS check_condivisione;
DELIMITER $$

-- una collezionista non può essere condivisa con un collezionista con cui è già stata condivisa

CREATE TRIGGER check_condivisione BEFORE INSERT ON condivisa
FOR EACH ROW
BEGIN

    IF (NEW.collezione.ID_collezionista = OLD.collezione.ID_collezionista) THEN 
        SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT="Hai già condiviso questa collezione con questo collezionista.";
		ELSEIF (NEW.collezione.ID_collezionista != OLD.collezione.ID_collezionista) THEN
			INSERT INTO condivisa (ID_collezionista, ID_collezione) SELECT NEW.collezionista.ID FROM collezionista;
		END IF;
    
END $$
DELIMITER ;