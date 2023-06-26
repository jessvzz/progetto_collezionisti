-- inserimento di una traccia ad un disco
DROP PROCEDURE IF EXISTS inserimento_traccia;
DELIMITER $$
CREATE PROCEDURE inserimento_traccia(
  ISRC VARCHAR(100),
  durata VARCHAR(100),
  titolo VARCHAR(100),
  ID_disco INTEGER,
  flag ENUM('ESECUTORE', 'COMPOSITORE', 'ENTRAMBI'),
  ID_artista INTEGER
)
BEGIN
  DECLARE ID_brano INTEGER;

  -- Inserimento del brano nella tabella "brano"
  INSERT INTO brano(ISRC, durata, titolo, ID_disco)
  VALUES (ISRC, durata, titolo, ID_disco);
  
  -- Ottieni l'ID del brano appena inserito
  SET ID_brano = LAST_INSERT_ID();

  -- Inserimento nella tabella "appartiene"
  INSERT INTO appartiene(ID_artista, ID_brano, flag)
  VALUES (ID_artista, ID_brano, flag);
END $$
DELIMITER ;

CALL inserimento_traccia("8693502U023","00:12:00","traccia X",1, "ENTRAMBI", 1);