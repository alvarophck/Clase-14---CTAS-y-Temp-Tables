-- Ejercicio 3. Tabla de staging vacía
-- Crear stg_usuarios_2309 vacía, con las mismas columnas que usuarios, y responder dos preguntas sobre sus restricciones.

DROP TABLE IF EXISTS dbo.stg_usuarios_2309;

SELECT *
INTO dbo.stg_usuarios_2309
FROM dbo.usuarios
WHERE 1 = 0;

SELECT COUNT(*) AS filas FROM dbo.stg_usuarios_2309;

SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = N'dbo' AND TABLE_NAME = N'stg_usuarios_2309'
ORDER BY ORDINAL_POSITION;
