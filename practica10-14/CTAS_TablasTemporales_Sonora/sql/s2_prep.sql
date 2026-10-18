-- Punto de partida
-- Crear los lotes stg_usuarios_2309 y stg_canciones_2509 y comprobar el punto de partida.

USE SonoraDB;
GO

-- Lote de altas de usuarios del 23/09
DROP TABLE IF EXISTS dbo.stg_usuarios_2309;

CREATE TABLE dbo.stg_usuarios_2309 (
    usuario_id        int,
    nombre_usuario    nvarchar(50),
    email             nvarchar(150),
    pais              char(2),
    plan_suscripcion  nvarchar(20),
    fecha_alta        date
);

INSERT INTO dbo.stg_usuarios_2309
    (usuario_id, nombre_usuario, email, pais, plan_suscripcion, fecha_alta) VALUES
(10, N'kiara_perreo', N'kiara.perreo@mail.com', 'PR', N'Premium',  '2026-09-21'),
(11, N'teo.bass',     N'teo.bass@mail.com',     'ES', N'Free',     '2026-09-22'),
(12, N'ines_wave',    N'ines.wave@mail.com',    'CO', N'Premium',  '2026-09-22'),
(12, N'ines_wave',    N'ines.wave@mail.com',    'CO', N'Premium',  '2026-09-22'),
(13, N'rober.mx',     N'rober.mx@mail.com',     'MX', N'Premiun',  '2026-09-23'),
(14, N'cami_ar',      NULL,                     'AR', N'Familiar', '2026-09-23'),
(15, N'lola.pop',     N'lola.pop@mail.com',     'ES', N'Family',   '2026-09-23'),
(16, N'max_techno',   N'max.techno@mail.com',   'CO', N'Free',     '2026-09-23');
GO

-- Lote de novedades de catálogo
DROP TABLE IF EXISTS dbo.stg_canciones_2509;

CREATE TABLE dbo.stg_canciones_2509 (
    cancion_id         int,
    titulo             nvarchar(150),
    artista_id         int,
    genero_id          int,
    duracion_seg       int,
    fecha_lanzamiento  date
);

INSERT INTO dbo.stg_canciones_2509
    (cancion_id, titulo, artista_id, genero_id, duracion_seg, fecha_lanzamiento) VALUES
(114, N'Sin Cobertura',  5,  7,  175, '2026-09-18'),
(116, N'Órbita',         9,  2,  192, '2026-09-25'),
(117, N'Asfalto Mojado', 8,  8,  221, '2026-09-25'),
(117, N'Asfalto Mojado', 8,  8,  221, '2026-09-25'),
(118, N'Voltaje',        4,  9,  0,   '2026-09-25'),
(119, N'Bruma',          15, 11, 240, '2026-09-25'),
(120, N'Cumbia Digital', 7,  11, 263, '2026-09-25');
GO

-- Comprobación
SELECT (SELECT COUNT(*) FROM dbo.reproducciones)     AS reproducciones,
       (SELECT COUNT(*) FROM dbo.usuarios)           AS usuarios,
       (SELECT COUNT(*) FROM dbo.canciones)          AS canciones,
       (SELECT COUNT(*) FROM dbo.stg_usuarios_2309)  AS lote_altas,
       (SELECT COUNT(*) FROM dbo.stg_canciones_2509) AS lote_canciones;
