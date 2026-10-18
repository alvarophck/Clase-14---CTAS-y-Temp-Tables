-- Ejercicio 10. Organigrama plano
-- Crear organigrama_plano con una CTE recursiva (nivel y ruta) y consultarlo sin recursión.

-- Comprobación previa del nombre de la columna del jefe
SELECT TOP (3) * FROM dbo.empleados;

DROP TABLE IF EXISTS dbo.organigrama_plano;

WITH org AS (
    SELECT empleado_id, nombre, puesto,
           0 AS nivel,
           CAST(nombre AS nvarchar(500)) AS ruta
    FROM dbo.empleados
    WHERE jefe_id IS NULL

    UNION ALL

    SELECT e.empleado_id, e.nombre, e.puesto,
           o.nivel + 1,
           CAST(o.ruta + N' > ' + e.nombre AS nvarchar(500))
    FROM dbo.empleados AS e
    JOIN org AS o ON e.jefe_id = o.empleado_id
)
SELECT empleado_id, nombre, puesto, nivel, ruta
INTO dbo.organigrama_plano
FROM org;

-- a)
SELECT nivel, COUNT(*) AS empleados
FROM dbo.organigrama_plano
GROUP BY nivel
ORDER BY nivel;

-- b)
SELECT nombre, puesto, nivel
FROM dbo.organigrama_plano
WHERE ruta LIKE N'%Raúl Benet%'
ORDER BY nivel, nombre;
