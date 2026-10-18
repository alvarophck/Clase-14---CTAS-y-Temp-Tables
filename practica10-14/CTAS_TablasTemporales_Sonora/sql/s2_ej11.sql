-- Ejercicio 11. Aterrizar el lote de novedades
-- Aterrizar stg_canciones_2509 en #novedades sin duplicados, comprobar repetidos y descartar lo que ya existe.

DROP TABLE IF EXISTS #novedades;

SELECT DISTINCT cancion_id, titulo, artista_id, genero_id, duracion_seg, fecha_lanzamiento
INTO #novedades
FROM dbo.stg_canciones_2509;

SELECT cancion_id, COUNT(*) AS veces
FROM #novedades
GROUP BY cancion_id
HAVING COUNT(*) > 1;

DELETE FROM #novedades
WHERE EXISTS (SELECT 1 FROM dbo.canciones AS c WHERE c.cancion_id = #novedades.cancion_id);

SELECT cancion_id, titulo, artista_id, duracion_seg
FROM #novedades
ORDER BY cancion_id;
