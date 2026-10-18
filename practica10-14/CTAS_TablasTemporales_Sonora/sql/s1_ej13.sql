-- Ejercicio 13. Ranking de artistas con intercambio
-- Construir ranking_artistas_nueva, validarla y sustituir ranking_artistas dentro de una transacción con su clave primaria.

DROP TABLE IF EXISTS dbo.ranking_artistas_nueva;

SELECT a.artista_id,
       a.nombre                     AS artista,
       COUNT(*)                     AS reproducciones_validas,
       COUNT(DISTINCT r.usuario_id) AS oyentes
INTO dbo.ranking_artistas_nueva
FROM dbo.reproducciones AS r
JOIN dbo.canciones AS c ON c.cancion_id = r.cancion_id
JOIN dbo.artistas  AS a ON a.artista_id = c.artista_id
WHERE r.tipo_contenido = N'Canción'
  AND r.segundos_escuchados >= 30
GROUP BY a.artista_id, a.nombre;

ALTER TABLE dbo.ranking_artistas_nueva
ALTER COLUMN artista_id int NOT NULL;
GO

-- Validación
SELECT (SELECT COUNT(*) FROM dbo.ranking_artistas_nueva) AS filas,
       (SELECT COUNT(*)
        FROM (SELECT artista_id FROM dbo.ranking_artistas_nueva
              GROUP BY artista_id HAVING COUNT(*) > 1) AS rep) AS ids_repetidos;

-- Intercambio, solo si la validación es correcta
IF (SELECT COUNT(*) FROM dbo.ranking_artistas_nueva) > 0
   AND NOT EXISTS (SELECT artista_id FROM dbo.ranking_artistas_nueva
                   GROUP BY artista_id HAVING COUNT(*) > 1)
BEGIN
    BEGIN TRAN;
        DROP TABLE IF EXISTS dbo.ranking_artistas;
        EXEC sp_rename N'dbo.ranking_artistas_nueva', N'ranking_artistas';
        ALTER TABLE dbo.ranking_artistas
        ADD CONSTRAINT PK_ranking_artistas PRIMARY KEY (artista_id);
    COMMIT;
END
ELSE
    PRINT N'Validación fallida: no se sustituye ranking_artistas';
GO

SELECT artista, reproducciones_validas, oyentes
FROM dbo.ranking_artistas
ORDER BY reproducciones_validas DESC, artista;
