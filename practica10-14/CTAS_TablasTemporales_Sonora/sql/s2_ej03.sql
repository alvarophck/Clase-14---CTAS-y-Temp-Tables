-- Ejercicio 3. Script de Hugo
-- Explicar por qué el script falla en la segunda ejecución, corregirlo y responder qué pasa en una ventana nueva.

-- Script original (falla en la segunda ejecución)
SELECT cancion_id, titulo, duracion_seg
INTO #largas
FROM dbo.canciones
WHERE duracion_seg > 300;

SELECT COUNT(*) AS canciones_largas FROM #largas;

-- Script corregido
DROP TABLE IF EXISTS #largas;

SELECT cancion_id, titulo, duracion_seg
INTO #largas
FROM dbo.canciones
WHERE duracion_seg > 300;

SELECT COUNT(*) AS canciones_largas FROM #largas;
