USE Collectors;
DROP TRIGGER IF EXISTS check_artista;
DELIMITER $$

CREATE TRIGGER check_artista BEFORE INSERT ON disco
FOR EACH ROW
BEGIN

  IF(NEW.disco.anno_uscita > YEAR(NOW())) THEN
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT="Errore nella data di nascita.";
  END IF;


  
END $$
DELIMITER ;