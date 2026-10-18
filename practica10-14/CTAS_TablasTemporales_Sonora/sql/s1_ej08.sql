-- Ejercicio 8. Catálogo completo
-- Crear catalogo_completo con artista, país, género y género padre, y contar canciones por género padre.

DROP TABLE IF EXISTS dbo.catalogo_completo;

SELECT c.cancion_id,
       c.titulo,
       a.nombre  AS artista,
       a.pais    AS pais_artista,
       g.nombre  AS genero,
       gp.nombre AS genero_padre
INTO dbo.catalogo_completo
FROM dbo.canciones AS c
JOIN dbo.artistas  AS a  ON a.artista_id = c.artista_id
JOIN dbo.generos   AS g  ON g.genero_id  = c.genero_id
LEFT JOIN dbo.generos AS gp ON gp.genero_id = g.genero_padre_id;

SELECT genero_padre, COUNT(*) AS canciones
FROM dbo.catalogo_completo
GROUP BY genero_padre
ORDER BY canciones DESC, genero_padre;
