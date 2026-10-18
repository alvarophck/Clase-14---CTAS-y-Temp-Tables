-- Ejercicio 6. Royalties con @tarifas
-- Guardar las tarifas en una variable de tabla y calcular minutos, tarifa e importe por plan.

DROP TABLE IF EXISTS #validas_semana;

SELECT r.reproduccion_id, r.usuario_id, r.cancion_id, r.fecha_hora,
       r.segundos_escuchados, r.dispositivo
INTO #validas_semana
FROM dbo.reproducciones AS r
WHERE r.tipo_contenido = N'Canción'
  AND r.segundos_escuchados >= 30
  AND r.fecha_hora >= '2026-09-16'
  AND r.fecha_hora <  '2026-09-23';
GO

DECLARE @tarifas TABLE (
    plan_suscripcion  nvarchar(20)  NOT NULL PRIMARY KEY,
    euros_minuto      decimal(4,2)  NOT NULL
);

INSERT INTO @tarifas (plan_suscripcion, euros_minuto) VALUES
(N'Premium', 0.08), (N'Familiar', 0.08), (N'Free', 0.02);

SELECT u.plan_suscripcion,
       CAST(SUM(v.segundos_escuchados) / 60.0 AS decimal(6,1)) AS minutos,
       t.euros_minuto,
       CAST(CAST(SUM(v.segundos_escuchados) / 60.0 AS decimal(6,1)) * t.euros_minuto
            AS decimal(6,2)) AS importe
FROM #validas_semana AS v
JOIN dbo.usuarios AS u ON u.usuario_id = v.usuario_id
JOIN @tarifas     AS t ON t.plan_suscripcion = u.plan_suscripcion
GROUP BY u.plan_suscripcion, t.euros_minuto
ORDER BY importe DESC;
