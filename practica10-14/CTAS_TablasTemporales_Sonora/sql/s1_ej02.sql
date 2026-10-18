-- Ejercicio 2. Usuarios de Latinoamérica
-- Crear usuarios_latam con identificador, nombre, país y plan de los usuarios de MX, AR, CO y PR.

DROP TABLE IF EXISTS dbo.usuarios_latam;

SELECT usuario_id, nombre_usuario, pais, plan_suscripcion
INTO dbo.usuarios_latam
FROM dbo.usuarios
WHERE pais IN ('MX', 'AR', 'CO', 'PR');

SELECT usuario_id, nombre_usuario, pais, plan_suscripcion
FROM dbo.usuarios_latam
ORDER BY pais, nombre_usuario;
