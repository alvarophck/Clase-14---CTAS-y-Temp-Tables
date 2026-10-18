-- Ejercicio 7. Catálogo por formato
-- Copiar el catálogo en #catalogo, añadir y rellenar la columna formato, contar y borrar las cortas.

DROP TABLE IF EXISTS #catalogo;

SELECT cancion_id, titulo, duracion_seg
INTO #catalogo
FROM dbo.canciones;

ALTER TABLE #catalogo ADD formato nvarchar(10) NULL;
GO

UPDATE #catalogo
SET formato = CASE WHEN duracion_seg < 180  THEN N'Corta'
                   WHEN duracion_seg <= 300 THEN N'Estándar'
                   ELSE N'Larga' END;

SELECT formato, COUNT(*) AS canciones
FROM #catalogo
GROUP BY formato
ORDER BY canciones DESC, formato;

DELETE FROM #catalogo WHERE formato = N'Corta';

SELECT (SELECT COUNT(*) FROM #catalogo)      AS filas_catalogo_temporal,
       (SELECT COUNT(*) FROM dbo.canciones)  AS filas_canciones;
