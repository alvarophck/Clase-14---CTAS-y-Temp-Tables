-- Ejercicio 1. Copia completa de artistas
-- Crear una copia completa de artistas en artistas_copia y comprobar cuántas filas tiene.

DROP TABLE IF EXISTS dbo.artistas_copia;

SELECT *
INTO dbo.artistas_copia
FROM dbo.artistas;

SELECT COUNT(*) AS filas FROM dbo.artistas_copia;
