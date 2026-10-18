-- Ejercicio 12. Validar y cargar las novedades
-- Apartar en #novedades_rechazadas las canciones que incumplen las dos reglas y cargar el resto en una transacción que se deshace.

DROP TABLE IF EXISTS #novedades;

SELECT DISTINCT cancion_id, titulo, artista_id, genero_id, duracion_seg, fecha_lanzamiento
INTO #novedades
FROM dbo.stg_canciones_2509;

DELETE FROM #novedades
WHERE EXISTS (SELECT 1 FROM dbo.canciones AS c WHERE c.cancion_id = #novedades.cancion_id);

DROP TABLE IF EXISTS #novedades_rechazadas;

CREATE TABLE #novedades_rechazadas (
    cancion_id  int            NOT NULL,
    titulo      nvarchar(150)  NULL,
    motivo      nvarchar(60)   NOT NULL
);

-- Regla 1: el artista debe existir
INSERT INTO #novedades_rechazadas (cancion_id, titulo, motivo)
SELECT cancion_id, titulo, N'Artista inexistente'
FROM #novedades
WHERE NOT EXISTS (SELECT 1 FROM dbo.artistas AS a WHERE a.artista_id = #novedades.artista_id);

DELETE FROM #novedades
WHERE NOT EXISTS (SELECT 1 FROM dbo.artistas AS a WHERE a.artista_id = #novedades.artista_id);

-- Regla 2: duración mayor que cero
INSERT INTO #novedades_rechazadas (cancion_id, titulo, motivo)
SELECT cancion_id, titulo, N'Duración no válida'
FROM #novedades
WHERE duracion_seg <= 0;

DELETE FROM #novedades
WHERE duracion_seg <= 0;

SELECT cancion_id, titulo, motivo
FROM #novedades_rechazadas
ORDER BY cancion_id;

-- Carga dentro de transacción
BEGIN TRAN;

    INSERT INTO dbo.canciones (cancion_id, titulo, artista_id, genero_id, duracion_seg, fecha_lanzamiento)
    SELECT n.cancion_id, n.titulo, n.artista_id, n.genero_id, n.duracion_seg, n.fecha_lanzamiento
    FROM #novedades AS n
    WHERE NOT EXISTS (SELECT 1 FROM dbo.canciones AS c WHERE c.cancion_id = n.cancion_id);

    SELECT COUNT(*) AS canciones_en_transaccion FROM dbo.canciones;

ROLLBACK;

SELECT COUNT(*) AS canciones_tras_rollback FROM dbo.canciones;
