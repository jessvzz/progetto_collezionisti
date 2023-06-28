USE Collectors;
DROP TRIGGER IF EXISTS check_visibilita;
DELIMITER $$

CREATE TRIGGER check_visibilita AFTER UPDATE ON collezione
FOR EACH ROW
BEGIN

    IF (NEW.collezione.stato != OLD.collezione.stato) THEN -- verifica se lo stato è cambiato
        IF  (NEW.stato = 'pubblico') THEN
            -- Rimuovi la condivisione della collezione per tutti i collezionisti eccetto se stesso
            DELETE FROM condivisa WHERE ID_collezione = NEW.ID;
        END IF;
    END IF;

END $$
DELIMITER ;