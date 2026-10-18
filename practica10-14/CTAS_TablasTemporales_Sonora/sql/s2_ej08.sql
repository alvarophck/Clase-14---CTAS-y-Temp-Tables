-- Ejercicio 8. Tabla global ##artistas_semana
-- Publicar las cifras por artista en una tabla temporal global, consultarla desde otra ventana y responder dos preguntas.

-- Ventana 1
DROP TABLE IF EXISTS ##artistas_semana;

SELECT a.nombre AS artista,
       COUNT(*) AS reproducciones,
       CAST(SUM(v.segundos_escuchados) / 60.0 AS decimal(6,1)) AS minutos
INTO ##artistas_semana
FROM #validas_semana AS v
JOIN dbo.canciones AS c ON c.cancion_id = v.cancion_id
JOIN dbo.artistas  AS a ON a.artista_id = c.artista_id
GROUP BY a.nombre;

-- Ventana 2
SELECT artista, reproducciones, minutos
FROM ##artistas_semana
WHERE reproducciones > 1
ORDER BY reproducciones DESC, artista;
