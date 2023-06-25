USE Collectors;
DROP TRIGGER IF EXISTS check_generi;
DELIMITER $$
-- se un genere è riferito da al meno un disco impedisce la cancellazione di quel genere

CREATE TRIGGER check_generi BEFORE DELETE ON genere
FOR EACH ROW
BEGIN

	DECLARE generi_disco SMALLINT UNSIGNED;
    
    SELECT COUNT(*) INTO generi_disco
    FROM disco d
    WHERE d.ID_genere = OLD.ID;

    IF (genri_disco > 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Un disco resterenbbe senza genere';
    END IF;
    

END $$
DELIMITER ;