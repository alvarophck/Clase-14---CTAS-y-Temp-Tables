-- Ejercicio 12. Foto de usuarios por plan
-- a) Crear foto_usuarios_plan. b) Pasar a nachox a Premium en una transacción y comparar la foto con el recuento actual antes del ROLLBACK.

-- a)
DROP TABLE IF EXISTS dbo.foto_usuarios_plan;

SELECT plan_suscripcion, COUNT(*) AS usuarios
INTO dbo.foto_usuarios_plan
FROM dbo.usuarios
GROUP BY plan_suscripcion;

SELECT plan_suscripcion, usuarios
FROM dbo.foto_usuarios_plan
ORDER BY usuarios DESC;

-- b)
BEGIN TRAN;

UPDATE dbo.usuarios
SET plan_suscripcion = N'Premium'
WHERE nombre_usuario = N'nachox';

WITH ahora AS (
    SELECT plan_suscripcion, COUNT(*) AS usuarios
    FROM dbo.usuarios
    GROUP BY plan_suscripcion
)
SELECT COALESCE(f.plan_suscripcion, a.plan_suscripcion) AS plan_suscripcion,
       COALESCE(f.usuarios, 0) AS usuarios_foto,
       COALESCE(a.usuarios, 0) AS usuarios_ahora
FROM dbo.foto_usuarios_plan AS f
FULL JOIN ahora AS a ON a.plan_suscripcion = f.plan_suscripcion
WHERE COALESCE(f.usuarios, 0) <> COALESCE(a.usuarios, 0)
ORDER BY plan_suscripcion;

ROLLBACK;
