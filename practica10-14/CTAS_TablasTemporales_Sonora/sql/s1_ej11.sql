-- Ejercicio 11. Personas por país
-- Crear personas_por_pais uniendo usuarios y artistas con UNION ALL y contar ambos por país.

DROP TABLE IF EXISTS dbo.personas_por_pais;

SELECT pais,
       CAST(N'Usuario' AS nvarchar(10)) AS tipo,
       nombre_usuario                   AS nombre
INTO dbo.personas_por_pais
FROM dbo.usuarios
UNION ALL
SELECT pais, N'Artista', nombre
FROM dbo.artistas;

SELECT pais,
       SUM(CASE WHEN tipo = N'Usuario' THEN 1 ELSE 0 END) AS usuarios,
       SUM(CASE WHEN tipo = N'Artista' THEN 1 ELSE 0 END) AS artistas
FROM dbo.personas_por_pais
GROUP BY pais
ORDER BY usuarios DESC, pais;
