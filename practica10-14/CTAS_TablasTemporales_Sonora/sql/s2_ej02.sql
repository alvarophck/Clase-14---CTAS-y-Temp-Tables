-- Ejercicio 2. Usuarios de pago
-- Crear #usuarios_pago con CREATE TABLE y clave primaria, llenarla y explicar qué ocurre al repetir el INSERT.

DROP TABLE IF EXISTS #usuarios_pago;

CREATE TABLE #usuarios_pago (
    usuario_id        int           NOT NULL PRIMARY KEY,
    nombre_usuario    nvarchar(50)  NOT NULL,
    pais              char(2)       NOT NULL,
    plan_suscripcion  nvarchar(20)  NOT NULL
);

INSERT INTO #usuarios_pago (usuario_id, nombre_usuario, pais, plan_suscripcion)
SELECT usuario_id, nombre_usuario, pais, plan_suscripcion
FROM dbo.usuarios
WHERE plan_suscripcion IN (N'Premium', N'Familiar');

SELECT pais, COUNT(*) AS usuarios_pago
FROM #usuarios_pago
GROUP BY pais
ORDER BY usuarios_pago DESC, pais;

-- Segunda ejecución, solo del INSERT (falla)
INSERT INTO #usuarios_pago (usuario_id, nombre_usuario, pais, plan_suscripcion)
SELECT usuario_id, nombre_usuario, pais, plan_suscripcion
FROM dbo.usuarios
WHERE plan_suscripcion IN (N'Premium', N'Familiar');
