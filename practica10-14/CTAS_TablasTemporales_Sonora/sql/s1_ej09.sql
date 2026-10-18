-- Ejercicio 9. Actividad de usuarios
-- Crear actividad_usuarios con válidas, saltos y anuncios por usuario, calculados en una CTE. Deben aparecer los 10 usuarios.

DROP TABLE IF EXISTS dbo.actividad_usuarios;

WITH recuentos AS (
    SELECT usuario_id,
           SUM(CASE WHEN tipo_contenido = N'Canción' AND segundos_escuchados >= 30 THEN 1 ELSE 0 END) AS validas,
           SUM(CASE WHEN tipo_contenido = N'Canción' AND segundos_escuchados <  30 THEN 1 ELSE 0 END) AS saltos,
           SUM(CASE WHEN tipo_contenido = N'Anuncio' THEN 1 ELSE 0 END)                                AS anuncios
    FROM dbo.reproducciones
    GROUP BY usuario_id
)
SELECT u.usuario_id,
       u.nombre_usuario,
       u.plan_suscripcion,
       COALESCE(r.validas, 0)  AS validas,
       COALESCE(r.saltos, 0)   AS saltos,
       COALESCE(r.anuncios, 0) AS anuncios
INTO dbo.actividad_usuarios
FROM dbo.usuarios AS u
LEFT JOIN recuentos AS r ON r.usuario_id = u.usuario_id;

SELECT usuario_id, nombre_usuario, plan_suscripcion, validas, saltos, anuncios
FROM dbo.actividad_usuarios
ORDER BY usuario_id;
