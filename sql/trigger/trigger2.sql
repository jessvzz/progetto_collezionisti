USE Collectors;
DROP TRIGGER IF EXISTS check_visibilita;
DELIMITER $$

CREATE TRIGGER check_visibilita AFTER UPDATE ON collezione
FOR EACH ROW
BEGIN

    IF (NEW.collezione.stato != OLD.collezione.stato) THEN -- verifica se lo stato è cambiato
        IF (NEW.collezione.stato = 'pubblico') THEN
            -- Aggiungi la condivisione della collezione a tutti i collezionisti
            INSERT INTO condivisa (ID_collezionista, ID_collezione) SELECT collezionista.ID, NEW.collezione.ID FROM collezionista;
        ELSEIF (NEW.stato = 'privato') THEN
            -- Rimuovi la condivisione della collezione per tutti i collezionisti eccetto se stesso
            DELETE FROM condivisa WHERE ID_collezione = NEW.ID AND ID_collezionista <> NEW.ID_collezionista;
        END IF;
    END IF;

END $$
DELIMITER ;