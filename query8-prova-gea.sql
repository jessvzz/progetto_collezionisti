DROP PROCEDURE IF EXISTS ricerca_dischi;
DELIMITER $$
CREATE PROCEDURE ricerca_dischi(
    stringa VARCHAR(100), ID_coll INTEGER
)
BEGIN
    SELECT d.titolo AS disco_titolo, a.nome_dArte AS artista_nome, b.titolo AS brano_titolo
    FROM disco d
    JOIN artista a ON d.ID_artista = a.ID
    JOIN brano b ON b.ID_disco = d.ID
    JOIN appartiene ap ON ap.ID_brano = b.ID
    WHERE (d.titolo = stringa OR a.nome_dArte = stringa)
      AND (
        d.ID_collezionista = ID_coll
        OR d.ID_collezionista IN (
          SELECT ID_collezionista FROM condivisa WHERE ID_collezione IN (
            SELECT ID FROM collezione WHERE ID_collezionista = ID_coll
          ) AND ID_collezionista = ID_coll
        )
        OR d.ID_collezionista IN (
          SELECT ID_collezionista FROM collezione WHERE ID_collezionista = ID_coll AND stato = 'pubblico'
        )
      );
END $$
DELIMITER ;
