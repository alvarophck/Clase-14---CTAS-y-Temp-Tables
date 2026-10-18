-- Ejercicio 7. Seguimiento de lanzamientos
-- Crear seguimiento_lanzamientos con tres columnas de seguimiento y registrar la revisión de Galaxia Dembow.

DROP TABLE IF EXISTS dbo.seguimiento_lanzamientos;

SELECT cancion_id,
       titulo,
       fecha_lanzamiento,
       CAST(N'Sin revisar' AS nvarchar(30)) AS estado,
       CAST(NULL AS nvarchar(100))          AS revisado_por,
       CAST(NULL AS date)                   AS fecha_revision
INTO dbo.seguimiento_lanzamientos
FROM dbo.canciones
WHERE fecha_lanzamiento >= '2026-08-01';

UPDATE dbo.seguimiento_lanzamientos
SET estado         = N'Revisado: apta para portada',
    revisado_por   = N'Carmen Lozano',
    fecha_revision = '2026-09-23'
WHERE titulo = N'Galaxia Dembow';

SELECT cancion_id, titulo, fecha_lanzamiento, estado, revisado_por, fecha_revision
FROM dbo.seguimiento_lanzamientos
ORDER BY fecha_lanzamiento;
