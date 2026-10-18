-- Ejercicio 4. Anuncios emitidos
-- Crear anuncios_emitidos con las reproducciones de tipo Anuncio, en un script re-ejecutable.

DROP TABLE IF EXISTS dbo.anuncios_emitidos;

SELECT reproduccion_id, usuario_id, fecha_hora, dispositivo
INTO dbo.anuncios_emitidos
FROM dbo.reproducciones
WHERE tipo_contenido = N'Anuncio';

SELECT reproduccion_id, usuario_id, fecha_hora, dispositivo
FROM dbo.anuncios_emitidos
ORDER BY reproduccion_id;
