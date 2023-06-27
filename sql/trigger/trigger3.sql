USE Collectors;
DROP TRIGGER IF EXISTS check_anno_uscita;
DELIMITER $$

CREATE TRIGGER check_anno_uscita BEFORE INSERT ON disco
FOR EACH ROW
BEGIN

  IF(NEW.disco.anno_uscita > YEAR(NOW())) THEN
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT="Errore nella data di uscita del disco.";
  END IF;
  
END $$
DELIMITER ;