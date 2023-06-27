USE Collectors;
DROP TRIGGER IF EXISTS check_genere;
DELIMITER $$
-- un genere che è presente nei dati di un disco non può essere cancellato

CREATE TRIGGER check_genere BEFORE DELETE ON genere
FOR EACH ROW
BEGIN
	DECLARE genere_disco SMALLINT UNSIGNED;
    
    SELECT COUNT(*) INTO genere_disco
    FROM disco d
    WHERE d.ID_genere = OLD.ID;

    IF (genere_disco > 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore! Un disco resterebbe senza genere';
    END IF;
END $$
DELIMITER ;