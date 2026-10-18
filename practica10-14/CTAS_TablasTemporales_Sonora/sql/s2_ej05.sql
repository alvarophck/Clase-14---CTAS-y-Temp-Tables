-- Ejercicio 5. Reproducciones válidas del histórico
-- Guardar todas las válidas en #validas y responder tres preguntas usando esa tabla.

DROP TABLE IF EXISTS #validas;

SELECT reproduccion_id, usuario_id, cancion_id, segundos_escuchados, dispositivo
INTO #validas
FROM dbo.reproducciones
WHERE tipo_contenido = N'Canción'
  AND segundos_escuchados >= 30;

-- a)
SELECT u.pais,
       COUNT(*) AS reproducciones,
       CAST(SUM(v.segundos_escuchados) / 60.0 AS decimal(6,1)) AS minutos
FROM #validas AS v
JOIN dbo.usuarios AS u ON u.usuario_id = v.usuario_id
GROUP BY u.pais
ORDER BY reproducciones DESC;

-- b)
SELECT c.titulo
FROM dbo.canciones AS c
WHERE NOT EXISTS (SELECT 1 FROM #validas AS v WHERE v.cancion_id = c.cancion_id)
ORDER BY c.titulo;

-- c)
SELECT u.nombre_usuario, u.plan_suscripcion
FROM dbo.usuarios AS u
WHERE NOT EXISTS (SELECT 1 FROM #validas AS v WHERE v.usuario_id = u.usuario_id);
