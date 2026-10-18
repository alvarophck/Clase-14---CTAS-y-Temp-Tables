-- Ejercicio 6. Ficha de canciones
-- Crear canciones_ficha con la duración en minutos (decimal(4,1)) y una categoría (nvarchar(10)).

DROP TABLE IF EXISTS dbo.canciones_ficha;

SELECT cancion_id,
       titulo,
       CAST(duracion_seg / 60.0 AS decimal(4,1)) AS duracion_min,
       CAST(CASE WHEN duracion_seg >= 300 THEN N'Larga'
                 WHEN duracion_seg >= 180 THEN N'Media'
                 ELSE N'Corta' END AS nvarchar(10)) AS categoria
INTO dbo.canciones_ficha
FROM dbo.canciones;

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, NUMERIC_PRECISION, NUMERIC_SCALE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = N'dbo' AND TABLE_NAME = N'canciones_ficha'
ORDER BY ORDINAL_POSITION;

SELECT categoria, COUNT(*) AS canciones
FROM dbo.canciones_ficha
GROUP BY categoria
ORDER BY categoria;
