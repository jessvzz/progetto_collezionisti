DROP TRIGGER IF EXISTS check_collezioni_nomi;
DELIMITER $$

CREATE TRIGGER check_collezioni_nomi BEFORE INSERT ON collezione
FOR EACH ROW
BEGIN
    DECLARE count SMALLINT UNSIGNED;

    SELECT COUNT(*) INTO count
    FROM collezione
    WHERE ID_collezionista = NEW.ID_collezionista AND nome = NEW.nome;

    IF (count > 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore! Impossibile utilizzare questo nome poichè è già stato utilizzato.';
    END IF;
END $$

DELIMITER ;
-- ---------------
DROP TRIGGER IF EXISTS check_condivisione;
DELIMITER $$

CREATE TRIGGER check_condivisione BEFORE INSERT ON condivisa
FOR EACH ROW
BEGIN
    DECLARE count SMALLINT UNSIGNED;
    DECLARE pubblica_count SMALLINT UNSIGNED;
    DECLARE stesso_collezionista_count SMALLINT UNSIGNED;

    -- conto quante collezioni con il nuovo ID sono condivise con il nuovo collezionista
    SELECT COUNT(*) INTO count
    FROM condivisa
    WHERE ID_collezionista = NEW.ID_collezionista AND ID_collezione = NEW.ID_collezione;

   -- conto le collezioni con il nuovo ID che sono pubbliche
    SELECT COUNT(*) INTO pubblica_count
    FROM collezione
    WHERE ID = NEW.ID_collezione AND stato = 'pubblico';

  --  conto le collezioni con il nuovo ID che appartengono al collezionista
    SELECT COUNT(*) INTO stesso_collezionista_count
    FROM collezione
    WHERE ID = NEW.ID_collezione AND ID_collezionista = NEW.ID_collezionista;

-- se ho già quella collezione condivisa con me, o pubblica o è mia, ritorna errore
    IF ((count > 0) OR (pubblica_count > 0) OR (stesso_collezionista_count > 0)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore! Impossibile condividere questa collezione con il collezionista indicato.';
    END IF;
END$$

DELIMITER ;

