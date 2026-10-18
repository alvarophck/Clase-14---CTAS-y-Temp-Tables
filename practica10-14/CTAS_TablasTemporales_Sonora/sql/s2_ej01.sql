-- Ejercicio 1. Lanzamientos de 2026
-- Guardar en #lanzamientos_2026 las canciones lanzadas en 2026 y contar los lanzamientos por artista.

DROP TABLE IF EXISTS #lanzamientos_2026;

SELECT c.cancion_id, c.titulo, a.nombre AS artista, c.fecha_lanzamiento
INTO #lanzamientos_2026
FROM dbo.canciones AS c
JOIN dbo.artistas  AS a ON a.artista_id = c.artista_id
WHERE c.fecha_lanzamiento >= '2026-01-01'
  AND c.fecha_lanzamiento <  '2027-01-01';

SELECT artista, COUNT(*) AS lanzamientos
FROM #lanzamientos_2026
GROUP BY artista
ORDER BY lanzamientos DESC, artista;
