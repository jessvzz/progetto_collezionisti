DROP PROCEDURE IF EXISTS ricerca_dischi;
DELIMITER $$
CREATE PROCEDURE ricerca_dischi(
    stringa VARCHAR(100), ID_coll INTEGER
)
BEGIN
    SELECT d.ID, d.titolo AS disco_titolo, a.nome_dArte AS artista_nome
    FROM disco d
    JOIN artista a ON d.ID_artista = a.ID
    WHERE (d.titolo = stringa OR a.nome_dArte = stringa)
    AND d.ID_collezionista = ID_coll
    
    UNION DISTINCT
    
    -- controllo tutte le collezioni condivise con il collezionista
    SELECT d.ID, d.titolo AS disco_titolo, a.nome_dArte AS artista_nome
    FROM disco d
    JOIN artista a ON d.ID_artista = a.ID
    JOIN copia c ON c.ID_disco = d.ID
    WHERE (d.titolo = stringa OR a.nome_dArte = stringa) AND (c.ID_collezione IN(
		SELECT ID_collezione FROM condivisa con WHERE con.ID_collezionista = ID_coll))
    
    
    
    UNION DISTINCT
    
    -- controllo di tutte le collezioni pubbliche
	SELECT d.ID, d.titolo AS disco_titolo, a.nome_dArte AS artista_nome
    FROM disco d
    JOIN artista a ON d.ID_artista = a.ID
    JOIN copia c ON c.ID_disco = d.ID
    WHERE (d.titolo = stringa OR a.nome_dArte = stringa) AND (c.ID_collezione IN(
                SELECT ID
                FROM collezione
                WHERE stato = 'pubblico'
            )
        );
    
    /*UNION DISTINCT
    
	SELECT d.ID, d.titolo AS disco_titolo, a.nome_dArte AS artista_nome
    FROM disco d
    JOIN artista a ON d.ID_artista = a.ID
    JOIN copia c ON c.ID_disco = d.ID
    WHERE d.ID IN (
        SELECT ID_disco
        FROM brano b
        JOIN appartiene ap ON b.ID = ap.ID_brano
        WHERE ap.ID_artista = (
            SELECT ID
            FROM artista a
            WHERE a.nome_dArte = stringa
        )
    )
    AND (
        d.ID_collezionista = ID_coll
        OR c.ID_collezione IN(
		SELECT ID_collezione FROM condivisa con WHERE con.ID_collezionista = ID_coll)
        
        OR c.ID_collezione IN(
                SELECT ID
                FROM collezione
                WHERE stato = 'pubblico'
            )
    );
		   */
END $$
DELIMITER ;

CALL ricerca_dischi("Francesco Guccini", 2);
