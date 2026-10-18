-- Ejercicio 10. Árbol de géneros
-- Calcular una vez el género principal de cada género en #arbol_generos y usarlo en dos consultas.

DROP TABLE IF EXISTS #arbol_generos;

WITH arbol AS (
    SELECT genero_id, genero_id AS raiz_id
    FROM dbo.generos
    WHERE genero_padre_id = (SELECT genero_id FROM dbo.generos WHERE genero_padre_id IS NULL)

    UNION ALL

    SELECT g.genero_id, a.raiz_id
    FROM dbo.generos AS g
    JOIN arbol AS a ON g.genero_padre_id = a.genero_id
)
SELECT a.genero_id, gp.nombre AS genero_principal
INTO #arbol_generos
FROM arbol AS a
JOIN dbo.generos AS gp ON gp.genero_id = a.raiz_id;

-- a)
SELECT ag.genero_principal, COUNT(*) AS canciones
FROM dbo.canciones AS c
JOIN #arbol_generos AS ag ON ag.genero_id = c.genero_id
GROUP BY ag.genero_principal
ORDER BY canciones DESC, ag.genero_principal;

-- b)
SELECT ag.genero_principal,
       COUNT(*) AS reproducciones,
       CAST(SUM(r.segundos_escuchados) / 60.0 AS decimal(6,1)) AS minutos
FROM dbo.reproducciones AS r
JOIN dbo.canciones      AS c  ON c.cancion_id = r.cancion_id
JOIN #arbol_generos     AS ag ON ag.genero_id = c.genero_id
WHERE r.tipo_contenido = N'Canción'
  AND r.segundos_escuchados >= 30
GROUP BY ag.genero_principal
ORDER BY reproducciones DESC;
