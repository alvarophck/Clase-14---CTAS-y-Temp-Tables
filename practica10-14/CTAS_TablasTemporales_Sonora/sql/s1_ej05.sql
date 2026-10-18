-- Ejercicio 5. Cruce de países usuario y artista
-- Explicar los dos problemas del CTAS del compañero, corregirlo y mostrar las 5 combinaciones con más reproducciones.

-- Script original (falla)
SELECT u.pais, a.pais, COUNT(*)
INTO dbo.cruce_paises
FROM dbo.reproducciones AS r
JOIN dbo.usuarios  AS u ON u.usuario_id = r.usuario_id
JOIN dbo.canciones AS c ON c.cancion_id = r.cancion_id
JOIN dbo.artistas  AS a ON a.artista_id = c.artista_id
WHERE r.tipo_contenido = N'Canción'
  AND r.segundos_escuchados >= 30
GROUP BY u.pais, a.pais;

-- Script corregido
DROP TABLE IF EXISTS dbo.cruce_paises;

SELECT u.pais   AS pais_usuario,
       a.pais   AS pais_artista,
       COUNT(*) AS reproducciones
INTO dbo.cruce_paises
FROM dbo.reproducciones AS r
JOIN dbo.usuarios  AS u ON u.usuario_id = r.usuario_id
JOIN dbo.canciones AS c ON c.cancion_id = r.cancion_id
JOIN dbo.artistas  AS a ON a.artista_id = c.artista_id
WHERE r.tipo_contenido = N'Canción'
  AND r.segundos_escuchados >= 30
GROUP BY u.pais, a.pais;

SELECT COUNT(*) AS filas FROM dbo.cruce_paises;

SELECT TOP (5) pais_usuario, pais_artista, reproducciones
FROM dbo.cruce_paises
ORDER BY reproducciones DESC, pais_usuario, pais_artista;
